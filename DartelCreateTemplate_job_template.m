% append this code after defining variable channel_prefixes
% e.g. channel_prefixes = {'rc1'}; channel_prefixes = {'rc1','rc2'};


% add this code to jobs using spm for the cluster.
AnalysisDir='/data/scratch/zakell/vbm'; % <-make sure this is correct!
%% set up cluster
number_of_cores=12;
d=tempname();% get temporary directory location
mkdir(d);
% create cluster
cluster = parallel.cluster.Local('JobStorageLocation',d,'NumWorkers',number_of_cores);
matlabpool(cluster, number_of_cores);
%% run analysis
% get data for subject
addpath([AnalysisDir,'/Scripts']);
addpath(genpath([spm('dir'),'/config']));

matlabbatch = DartelCreateTemplate_matlabbatch(channel_prefixes);

spm('defaults','PET'); % defaults for VBM
spm_jobman('run', matlabbatch);
