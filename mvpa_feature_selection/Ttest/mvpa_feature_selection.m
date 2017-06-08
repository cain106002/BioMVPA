function [data_f,apply_param,idx_weight] = mvpa_feature_selection(data,label,param)
num=unique(label);
[~,p] = ttest2(data(label ==num(1),:),data(label == num(2),:));
idx_weight=p;
[~,pply_param] = sort(p,'ascend');
data_f=data(:,pply_param(1:param(1)));
apply_param=pply_param(1:param(1));
end