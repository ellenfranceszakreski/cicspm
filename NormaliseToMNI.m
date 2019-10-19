function NormaliseToMNI(fwhm)

%% parse inputs

% smoothing kernel
assert(isnumeric(fwhm),'fwhm must be numeric');
assert(numel(fwhm)==1,'fwhm must be scalar.');
assert(fwhm>=1,'fwhm must be not a NaN and >= 1.');
assert(fwhm==round(fwhm),'fwhm must be whole number.');
%% template name
TemplateName='Template_rc1_rc2';
%% set up directories
% main directory
    function dname = subfun_assert_dir_exists(varargin)
        % make directory name from inputs and throw error if it does not exist.
        dname = fullfile(varargin{:});
        dname = regexprep(dname,'/$','');
        assert(exist(dname,'dir')==7,'Could not find directory at %s.',dname)
    end
vbmDir = subfun_assert_dir_exists('/data/scratch/zakell/vbm');
%% AnatsDir (all subjects segmentation output kept here)
%AnatsDir = subfun_assert_dir_exists(vbmDir,'Anats');

% template directory (contains 'TemplateData')
TemplateDir = subfun_assert_dir_exists(vbmDir,TemplateName);
% TemplateDataDir contains flow fields and copies of c1subx_anat.nii,
% c2subx_anat.nii and Templates (e.g. Template_rc1_rc2_6.nii)
TemplateDataDir = subfun_assert_dir_exists(TemplateDir,'TemplateData');
% setup smoothing directory (in template directory
if fwhm<10
    smoothxx=sprintf('smooth0%d',fwhm); % e.g. smooth04
else
    smoothxx=sprintf('smooth%d',fwhm);
end
smoothxxDir=fullfile(TemplateDir, smoothxx);
if exist(smoothxxDir,'dir')==7
    % delete any old files
    if ~isempty(ls(smoothxxDir))
        delete([smoothxxDir,'/*.nii']);
        delete([smoothxxDir,'/*.mat']);
    end
else
    mkdir(smoothxxDir);
end
fprintf('smooth %d directory:\n\t%s\n\n', fwhm, smoothxxDir);


%% temporarily copy files to smooth dir
disp('Making temporary copies');

    function subfun_temp_copy(file_pattern)
        status = unix(sprintf('cp -v %s %s',fullfile(TemplateDataDir,file_pattern), smoothxxDir));
        assert(status==0, 'Failed to copy %s', file_pattern)
    end
subfun_temp_copy('c*sub*_anat.nii');
subfun_temp_copy('u_*sub*_anat_Template*.nii');
subfun_temp_copy('Template*_6.nii');

%% get subjects
subxs = regexp(ls(smoothxxDir),'sub\d+(?=_anat)','match');
assert(~isempty(subxs),'Could not find subjects in TemplateDataDir\n\t%s.',smoothxxDir);
subxs = cellstr(subxs);
subxs = unique(subxs,'stable');
subxN = numel(subxs);
subxs = reshape(subxs, subxN, 1); % make subxs a column vector cell string
% order images by subject
c1files = strcat(smoothxxDir,'/c1',subxs,'_anat.nii');
c2files = strcat(smoothxxDir,'/c2',subxs,'_anat.nii');
u_rc1files = strcat(smoothxxDir,'/u_rc1',subxs,'_anat_',TemplateName,'.nii');


%% make matlabbatch template
matlabbatch = {};
matlabbatch{1}.spm.tools.dartel.mni_norm.template = {[smoothxxDir, '/', TemplateName,'_6.nii']};
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = u_rc1files;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = {c1files; c2files}'; clear c1files c2files
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = '<UNDEFINED>'; % 0=no modulation (preserve concentration) 1=modulation (preserve amount)

matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [fwhm, fwhm, fwhm];
% make batches for no modulation and modulation
mb0 = matlabbatch;
mb0{1}.spm.tools.dartel.mni_norm.preserve = 0;
mb1 = matlabbatch;
mb1{1}.spm.tools.dartel.mni_norm.preserve = 1;
clear matlabbatch


%% run jobs
spm('defaults','PET'); % same defaults for VBM
% doing job with and without modulation
spm_jobman('run', {mb0, mb1}); % do job without modulation then with modulation
disp('Jobs completed sucessfully');

%% delete copies
disp('deleting copies of u_* c* and Template*6')
delete(fullfile(smoothxxDir,'/c*sub*_anat.nii'));
delete(fullfile(smoothxxDir,'/u_*sub*_anat_Template*.nii'));
delete(fullfile(smoothxxDir,'/Template*.nii'));

%% DONE

end
