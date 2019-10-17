%-----------------------------------------------------------------------
% Job saved on 16-Oct-2019 18:33:34 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = '_seg8.mat file';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {'<UNDEFINED>'};
matlabbatch{2}.cfg_basicio.file_dir.cfg_fileparts.files(1) = cfg_dep('Named File Selector: _seg8.mat file(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'c1';
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {'<UNDEFINED>'};
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'c2';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {'<UNDEFINED>'};
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_named_file.name = 'c3';
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_named_file.files = {'<UNDEFINED>'};
matlabbatch{6}.spm.util.imcalc.input(1) = cfg_dep('Named File Selector: c1(1) - Files', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{6}.spm.util.imcalc.input(2) = cfg_dep('Named File Selector: c2(1) - Files', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{6}.spm.util.imcalc.input(3) = cfg_dep('Named File Selector: c3(1) - Files', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{6}.spm.util.imcalc.output = '<UNDEFINED>';
matlabbatch{6}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{6}.spm.util.imcalc.expression = '(i1+i2+i3)>0'; % make mask
matlabbatch{6}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{6}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{6}.spm.util.imcalc.options.mask = 0;
matlabbatch{6}.spm.util.imcalc.options.interp = 1;
matlabbatch{6}.spm.util.imcalc.options.dtype = 4;
matlabbatch{7}.spm.util.tvol.matfiles(1) = cfg_dep('Named File Selector: _seg8.mat file(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{7}.spm.util.tvol.tmax = 3;
matlabbatch{7}.spm.util.tvol.mask(1) = cfg_dep('Image Calculator: ImCalc Computed Image', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.util.tvol.outf = '';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.name = '<UNDEFINED>';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(1).vname = 'c1';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(1).vcont(1) = cfg_dep('Tissue Volumes: 1', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','vol1'));
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(2).vname = 'c2';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(2).vcont(1) = cfg_dep('Tissue Volumes: 2', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','vol2'));
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(3).vname = 'c3';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(3).vcont(1) = cfg_dep('Tissue Volumes: 3', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','vol3'));
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(4).vname = 'icv';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(4).vcont(1) = cfg_dep('Tissue Volumes: Sum', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','vol_sum'));
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(5).vname = 'seg8_file';
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.vars(5).vcont(1) = cfg_dep('Named File Selector: _seg8.mat file(1) - Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '{}',{1}));
matlabbatch{8}.cfg_basicio.var_ops.cfg_save_vars.saveasstruct = false;
