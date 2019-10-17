% template for CIC job tissue volume for one subject
% add after defining variable subx. e.g. subx = 'sub8';

AnalysisDir='data/scratch/zakell/vbm'; %<- make sure this is correct

subxDir=fullfile(AnalysisDir,'Anats'); % NOTE: files for all subjects are kept in same directory for vbm
jobs = {fullfile(AnalysisDir,'Scripts/tissuevolume_job.m')};
inputs = cell(6, 1);
inputs{1, 1} = fullfile(subxDir, strcat(subx, '_anat_seg8.mat')); % Named File Selector: File Set - cfg_files e.g.sub9_anat_seg8.mat file
inputs{2, 1} = fullfile(subxDir, strcat('c1',subx, '_anat.nii'));% Named File Selector: File Set - cfg_files c1 file
inputs{3, 1} = fullfile(subxDir, strcat('c2',subx, '_anat.nii')); % Named File Selector: File Set - cfg_files c2 file
inputs{4, 1} = fullfile(subxDir, strcat('c3',subx, '_anat.nii')); % Named File Selector: File Set - cfg_files c3 file
inputs{5, 1} = strcat(subx,'_icv_mask');    % Image Calculator: Output Filename - cfg_entry  name of output file sub8_icv_mask (.nii is added by spm)
inputs{6, 1} = strcat(subx,'_icv_vol.mat'); % Save Variables: Output Filename - cfg_entry  e.g. sub8_icv_vol.mat

spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
% DONE
