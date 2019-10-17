function compile_icv_vol_mats
% compile_icv_vol_mats combine icv_vol.mat files (output for tissue volume) for each subject into dataset (ds) icv_vol_ds.mat
% ds variable names = {'c1','c2','c3','icv','seg8_file','subx'}

AnalysisDir='data/scratch/zakell/vbm'; %<- make sure this is correct
AnatsDir=fullfile(AnalysisDir,'Anats'); 

ptrn='\<sub\d+_icv_vol\.mat\>';
subx_icv_vol_files = regexp(ls(AnatsDir), ptrn, 'match');
assert(~isempty(subx_icv_vol_files),'Could not find files that match this patterns, %s', ptrn);clear ptrn
subx_icv_vol_files = cellstr(subx_icv_vol_files);

S = struct();
S = repmat(S,numel(subx_icv_vol_files),1);
for f=1:numel(subx_icv_vol_files)
    this_file = fullfile( AnatsDir, subx_icv_vol_files{f});
    S(f) = importdata(this_file);
    S(f).seg8_file = cellstr(S(f).seg8_file);
end; clear this_file f
ds = struct2dataset(S); clear S
ds.subx = regexprep(subx_icv_vol_files, '_icv_vol.mat', '');
saveto=fullfile(AnalysisDir,'icv_vol_ds.mat');
save(saveto, 'ds','-mat');
fprintf('Saved %s\n',saveto)
% done
end
