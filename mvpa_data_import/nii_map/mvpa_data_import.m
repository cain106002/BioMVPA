function [data,label,mask,data_info] = mvpa_data_import(data_path,label_path,mask_path)
%MVPA_DATA_IMPORT 此处显示有关此函数的摘要
%   此处显示详细说明

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
    nii_file = dir([data_path,filesep,sub_name,filesep,'*.nii']);
    if(isempty(nii_file))
        nii_file = dir([data_path,filesep,sub_name,filesep,'*.img']);
    end
    if(length(nii_file) == 1)
        [data_tmp,data_info] = rest_ReadNiftiImage(data_path,filesep,sub_name,filesep,...
            nii_file(1).name);
        if(~exist('mask','var'))
            mask = ones(size(data_tmp));
        end
        data(i,:) = data_tmp(mask == 1)';
    elseif(isempty(nii_file))
        error(['no nii file of subject: ',sub_name]);
    else
        error(['more than 1 nii file in subject: ',sub_name]);
    end
end
end

