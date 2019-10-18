function matlabbatch = matlabbatch_DartelCreateTemplate(channel_prefixes)
% make_matlabbatch_DartelCreateTemplate make matlabbatch for dartel create 
% template using specific DARTEL imports.

% e.g. matlabbatch_DartelCreateTemplate('rc1')
% e.g. matlabbatch_DartelCreateTemplate('rc2')
% e.g. matlabbatch_DartelCreateTemplate({'rc1','rc2'})
AnalysisDir='/data/scratch/zakell/vbm';
InputDir=fullfile(AnalysisDir,'Anats'); %<-make sure this is correct
%% validate input
valid_channel_prefixes={'rc1','rc2','rc3'}; % DARTEL import from segment
channel_prefixes = cellstr(channel_prefixes);
cellfun(@(x)validatestring(x,valid_channel_prefixes),channel_prefixes,'UniformOutput',false);
channel_prefixes = valid_channel_prefixes(ismember(valid_channel_prefixes, channel_prefixes));
%% get images;
% first set of images
ptrn=['\<',channel_prefixes{1},'sub\d+_anat\.nii\>'];
Images1 = regexp(ls(InputDir), ptrn, 'match');
assert(~isempty(Images1),'Could not find any images to match pattern %s',ptrn); clear ptrn
Images1 = cellstr(Images1);
Images1 = reshape(Images1, numel(Images1), 1); % make column vector
Images1 = strcat(InputDir,'/',Images1,',1');
%
nChannels=numel(channel_prefixes);
TemplateName = strcat('Template_',channel_prefixes{1});
if nChannels == 1
    Images={Images1};
else
    % add other channels making sure subjects are in same order
    Images = cell(nChannels, 1);
    Images{1} = Images1;
    for c = 2:nChannels
         Images{c} = regexprep(Images1, [channel_prefixes{1},'(?=sub\d+_anat\.nii,1$)'], channel_prefixes{c});
         TemplateName = strcat(TemplateName,'_',channel_prefixes{c});
    end; clear c
end
clear Images1 nChannels
%% make matlabbatch
matlabbatch = {};
matlabbatch{1}.spm.tools.dartel.warp.images = Images;
matlabbatch{1}.spm.tools.dartel.warp.settings.template = TemplateName; 
% these settings were the defaults
matlabbatch{1}.spm.tools.dartel.warp.settings.rform = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).rparam = [4 2 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).K = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).slam = 16;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).rparam = [2 1 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).K = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).slam = 8;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).rparam = [1 0.5 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).K = 1;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).slam = 4;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).rparam = [0.5 0.25 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).K = 2;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).slam = 2;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).K = 4;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).slam = 1;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).K = 6;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).slam = 0.5;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.lmreg = 0.01;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.cyc = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.its = 3;
%% save matlabbatch
saveas = fullfile(AnalysisDir, ['matlabbatch_DartelCreate',TemplateName,'.mat']);
save(saveas,'matlabbatch');
fprintf('Saved matlabbatch to %s\n',saveas);
% done

end
