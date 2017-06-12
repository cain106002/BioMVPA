function mvpa_session = cv_kfold(label,cv_para)
%MVPA_CROSS_VALIDATION create the tainning/testing dataset index
%
% 
mvpa_session = struct('idx_train',{},'idx_test',{});
k = cv_para(1);
rep = cv_para(2);

label = label(:,1);
whole_idx = 1:length(label);
whole_idx = whole_idx';
label_uniq = unique(label);
idx_groups = cell(length(label_uniq),1);

ses_ind = 0;
for i_rep = 1:rep
    for i = 1:length(label_uniq)
        idx_groups{i} = whole_idx(label == label_uniq(i),:);
        idx_groups{i} = idx_groups{i}(randperm(sum(label == label_uniq(i))));
    end
    for i = 1:k
        ses_ind = ses_ind+1;
        train_idx = [];
        test_idx = [];
        for j = 1:length(label_uniq)
            sec_num = floor(sum(label == label_uniq(j))/k);
            train_idx_tmp = 1:sum(label == label_uniq(j));
            if(i == k)
                test_idx_tmp = ((i-1)*sec_num+1):sum(label == label_uniq(j));
                train_idx_tmp(test_idx_tmp) = [];
            else
                test_idx_tmp = ((i-1)*sec_num+1):(i*sec_num);
                train_idx_tmp(test_idx_tmp) = [];
            end
            train_idx = [train_idx;idx_groups{j}(train_idx_tmp)];
            test_idx = [test_idx;idx_groups{j}(test_idx_tmp)];
        end
        mvpa_session(1).idx_train{ses_ind} = train_idx;
        mvpa_session(1).idx_test{ses_ind} = test_idx;
    end
end
    
    