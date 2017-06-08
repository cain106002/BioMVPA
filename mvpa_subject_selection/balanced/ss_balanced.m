function [mvpa_data]=ss_balanced(mvpa_data,ss_para)
%MVPA_SUBJECT_SELECTION create a balanced dataset
% create a balanced dataset 
% eg: the input data is 20 vs 30, the destination of this function is to
% select a most matched dataset of 20 vs 20
% 
% if extra is empty, the first 20 subject in group2 will be selected
% extra: the first row indicate the type of measures of each subjects
% (1:continuous or 2:distinct)
%
% created by Yangyang Yu 2016.09.12
% modified by Heng Chen 2016.09.19
if(ischar(ss_para))
    scores = load(ss_para);
else
    scores = ss_para;
end
scores_z = zscore(scores);
bias_z = sqrt(sum(scores_z.^2,2));
label = mvpa_data.label;
sele_index = ones(length(label),1);
label_unique=unique(label);
for i=1:length(label_unique)
    label_num(i)=sum(label==label_unique(i));
end
label_num_min=min(label_num);
label_num_extra = label_num-label_num_min;
if(sum(label_num_extra) == 0)
    mvpa_data.sub_sele = sele_index;
    return
end
if(isempty(scores_z))
    for i = 1:length(label_unique)
        if(label_num_extra(i) == 0)
            continue;
        end
        label_id_tmp = find(label == label_unique(i));
        sele_index(label_id_tmp(1:label_num_extra(i))) = 0;
    end
else
    [~,sort_idx] = sort(bias_z,'descend');
    label_sorted = label(sort_idx);
    for i = 1:length(label_unique)
        if(label_num_extra(i) == 0)
            continue;
        end
        label_id_tmp = find(label_sorted == label_unique(i));
        sele_index(sort_idx(label_id_tmp(1:label_num_extra(i)))) = 0;
    end
end
mvpa_data.label(sele_index == 0) = [];
mvpa_data.data(sele_index == 0,:) = [];
mvpa_data.sub_sele = sele_index;
end