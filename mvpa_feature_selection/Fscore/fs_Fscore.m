function [data_f,apply_param,fs_weight] = fs_Fscore(data,label,para)
% input:
% data: ��������
% label: ���ݱ�ǩ
% param: ����,param(1)����趨ΪҪѡȡ����������
% output:
% data_f: ��������ѡ��任�����������
% apply_param: ���뵽mvpa_feature_selection_apply�����еı任����,���ݸò������в��Լ�������ѡ��
% idx_weight: ÿ��������Ȩ�أ���������õ�һ��������

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