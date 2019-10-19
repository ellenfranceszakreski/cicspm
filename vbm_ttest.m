function vbm_ttest(AnaName, smoothxx, xvars)
if nargin==0
    xvars='alhb_total';
end
xvars = cellstr(xvars);
AnaDir='/data/scratch/zakell/vbm';
InputDir=fullfile(AnaDir,'gm_only',smoothxx);% has scans
ds = importdata(fullfile(AnaDir,'AllSubjects.mat'));
% make image names
ds.images = strcat(InputDir,'/swc1',ds.subx,'_anat.nii');
% exclude subjects without images
keep=false(size(ds,1), 1);
for n = 1:size(ds,1)
    keep(n) = exist(ds.images{n},'file')==2;
end
assert(any(keep),'no images found.')
ds = ds(keep, :); clear keep
% get ICV for each subject
N = size(ds,1);
ds.icv=NaN(N,1);
for n=1:N
    subx = ds.subx{n};
    S = importdata(fullfile(AnaDir,'Anats',[subx,'_icv_vol.mat']));
    ds.icv(n) = S.icv;
    clear S
end
% now
matlabbatch{1}.spm.stats.factorial_design.dir = {InputDir};
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = ds.images;
for x=1:numel(xvars)
    xvar=xvars{x};
    matlabbatch{1}.spm.stats.factorial_design.cov(x).c = ds.(xvar);
    matlabbatch{1}.spm.stats.factorial_design.cov(x).cname = xvar;
    matlabbatch{1}.spm.stats.factorial_design.cov(x).iCFI = 1;
    matlabbatch{1}.spm.stats.factorial_design.cov(x).iCC = 1; clear xvar
end; clear x
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tma.athresh = 0.2;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1; % use implicit mask
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_user.global_uval = ds.icv;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 2;

clear ds

%% estimate
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
%% do job
spm('defaults','PET');% same defaults for VBM
spm_jobman('run',matlabbatch);
%%

AnaDir=fullfile(InputDir,AnaName);
if exist(AnaDir,'dir')==7
    if ~isempty(ls(AnaDir))
        delete(fullfile(AnaDir,'*'))
    end
else
    mkdir(AnaDir)
end

files2move={'SPM.mat','RPV.nii','ResMS*','beta*.nii','mask.nii'};
for f=1:numel(files2move)
    movefile(fullfile(InputDir,files2move{f}), AnaDir);
end

end
