function [data_f,apply_param,fs_weight] = fs_Fscore(data,label,para)
% input:
% data: 输入数据
% label: 数据标签
% param: 参数,param(1)最好设定为要选取的特征个数
% output:
% data_f: 经过特征选择变换后的特征矩阵
% apply_param: 输入到mvpa_feature_selection_apply函数中的变换参数,根据该参数进行测试集的特征选择
% idx_weight: 每个特征的权重，根据这个得到一致特征。

%% fs_para modification
fnum = fix(para);
if(fnum<1)
    fnum = 1;
elseif(fnum>size(data,2))
    fnum = size(data,2);
end

%% label modification
label_fs = label(:,1);
label_unique = unique(label_fs);
for i = 1:length(label_unique)
    label_fs(label == label_unique(i)) = i;
end

%% call fsFisher.m
out = fsFisher(data,label_fs);
fs_weight = zeros(size(data,2),1);
fs_weight(out.fList(1:fnum)) = out.W(out.fList(1:fnum));
apply_param = out.fList(1:fnum);
data_f = data(:,apply_param);
end