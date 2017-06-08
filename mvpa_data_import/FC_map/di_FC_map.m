function [mvpa_data] = di_FC_map(data_path,label_path,mask_path,para_di)
%MVPA_DATA_IMPORT 此处显示有关此函数的摘要
%   此处显示详细说明

% initial
mvpa_data = struct('data',[],'data_ex',[],'label',[],...
            'label_ex',[],'mask',[],'mask_ex',[],'sub_sele',[],...
            'sub_sele_ex',[],'sub_info',[]);
% load label
label = load(label_path);

% load mask
if(~isempty(mask_path))
    if(strcmp(mask_path(end-3:end),'.mat'))
        var_struct = whos('-file',mask_path);
        if(length(var_struct) ~= 1)
            error('more than 1 var in the mask file');
        end
        mask_tmp = feval('load',mask_path,var_struct.name);
        mask = mask_tmp.(var_struct.name);
    elseif(strcmp(mask_path(end-3:end),'.nii') || ...
            strcmp(mask_path(end-3:end),'.img') || ...
            strcmp(mask_path(end-3:end),'.hdr'))
        mask = rest_ReadNiftiImage(mask_path);
    end
end

% load data
subs = dir(data_path);
subs(1:2) = [];
for i = 1:length(subs)
    sub_name = subs(i).name;
    disp(['loading ',sub_name]);
    mat_file = dir([data_path,filesep,sub_name,filesep,'*.mat']);
    if(length(mat_file) == 1)
        var_struct = whos('-file',[data_path,filesep,...
            sub_name,filesep,mat_file.name]);
        if(length(var_struct)~=1)
            error('more than 1 var in the mat file');
        end
        if(~exist('mask','var'))
            mask = ones(var_struct.size);
        end
        var_name = var_struct.name;
        mat_var = feval('load',[data_path,filesep,...
            sub_name,filesep,mat_file.name],var_name);
        data_tmp = mat_var.(var_name);
        data(i,:) = data_tmp(mask == 1)';
    elseif(isempty(mat_file))
        error(['no FC_map file of subject: ',sub_name,...
            '. Attention: All FC_map must be stored as .mat file']);
    else
        error(['more than 1 mat file in subject: ',sub_name]);
    end
end

mvpa_data(1).data = data;
mvpa_data.label = label;
mvpa_data.mask = mask;
end

