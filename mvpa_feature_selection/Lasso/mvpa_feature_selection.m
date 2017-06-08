function [data_f,apply_param,idx_weight] = mvpa_feature_selection(data,label,param)
B = lasso(data,label,'Lambda',param(2));
idx_weight=B;
[~,pply_param] = sort(B,'descend');
data_f=data(:,pply_param(1:param(1)));
apply_param=pply_param(1:param(1));
end