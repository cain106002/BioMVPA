function [fs_param_best,cfier_param_best] = ps_grid_search...
    (data,label,...
    ps_para,fs_ps_ind,cf_ps_ind,...
    fs_para_range,cf_para_range,fs_para_default,cf_para_default,...
    fs_func,fsa_func,cf_func,cfp_func)
% ps_para [k,log_step,ps_count]
fold_k = ps_para(1);
log_base = ps_para(2);
ps_count = ps_para(3);
for i = 1:length(fs_param_default)        
    if(fs_ps_ind(i))
        log_min = log(fs_para_range{i}(2))./log(log_base);
        log_max = log(fs_para_range{i}(3))./log(log_base);
        fs_para_cell{i} = log_min:((log_max-log_min)/ps_count):log_max;
        fs_para_cell{i} = log_base.^fs_para_cell{i};
        if(fs_para_range{i}(1) == 2)
            fs_para_cell{i} = fix(fs_para_cell{i});
        end
        fs_para_cell{i}(fs_para_cell{i}>fs_param_range{i}(3)) = fs_param_range{i}(3);
        fs_para_cell{i}(fs_para_cell{i}<fs_param_range{i}(2)) = fs_param_range{i}(2);
        fs_para_cell{i} = unique(fs_para_cell{i});
    else
        fs_para_cell{i} = fs_para_default(i);
    end
end
for i = 1:length(cf_para_default)        
    if(cf_ps_ind(i))
        log_min = log(cf_para_range{i}(2))./log(log_base);
        log_max = log(cf_para_range{i}(3))./log(log_base);
        cf_para_cell{i} = log_min:((log_max-log_min)/ps_count):log_max;
        cf_para_cell{i} = log_base.^cf_para_cell{i};
        if(cf_para_range{i}(1) == 2)
            cf_para_cell{i} = fix(cf_para_cell{i});
        end
        cf_para_cell{i}(cf_para_cell{i}>cf_para_range{i}(3)) = cf_para_range{i}(3);
        cf_para_cell{i}(cf_para_cell{i}<cf_para_range{i}(2)) = cf_para_range{i}(2);
        cf_para_cell{i} = unique(cf_para_cell{i});
    else
        cf_para_cell{i} = cf_para_default(i);
    end
end
[fs_para_mat,cf_para_mat] = my_ndgrid(fs_para_cell,cf_para_cell);

acc_best = 0;
[train_idx,test_idx] = sub_cv(label,fold_k);
for i = 1:size(fs_para_mat,1)
    
    fs_para_tmp = fs_para_mat(i,:);
    cf_para_tmp = cf_para_mat(i,:);
    for i = 1:fold_k
        data_train = data(train_idx{i},:);
        label_train = label(train_idx{i},:);
        data_test = data(test_idx{i},:);
        label_test = label(test_idx{i},:);
        [data_train_f,apply_param] = ...
            fs_func(data_train,label_train,fs_para_tmp);
        data_test_f = fsa_func(data_test,label_test,apply_param);
        model = cf_func(data_train_f,label_train,cf_para_tmp);
        label_predict(test_idx{i}) = cfp_func(data_test_f,label_test,model);
    end
    acc_tmp = sum(label_predict' == label(:,1))./length(label(:,1));
    if(acc_tmp>acc_best)
        acc_best = acc_tmp;
        param_best = param_tmp;
    end
end
fs_param_best = param_best{1}(1:fs_param_num);
cfier_param_best = param_best{1}(fs_param_num+1:end);
end

function [fs_para_nd_mat,cf_para_nd_mat] = my_ndgrid(fs_para_cell,cf_para_cell)
    para_cell = [fs_para_cell,cf_para_cell];
    fs_para_length = length(fs_para_cell);
%     cf_para_length = length(cf_para_cell);
    s = ones(1,length(para_cell));
    for i_sub = 1:length(para_cell)
        s(i_sub) = length(para_cell{i_sub});
    end
    for i_sub = 1:length(para_cell)
        sx = s;
        sx(i_sub) = 1;
        para_nd_cell{i_sub} = repmat(para_cell{i_sub}',sx);
    end
    for i_sub = 1:length(para_cell)
        para_nd_cell{i_sub} = para_nd_cell{i_sub}(:);
    end
    para_nd_mat = cell2mat(para_nd_cell);
    fs_para_nd_mat = para_nd_mat(:,1:fs_para_length);
    cf_para_nd_mat = para_nd_mat(:,(fs_para_length+1):end);
end

function [cv_train_idx,cv_test_idx] = sub_cv(cv_label,cv_k)
    cv_rand_idx = randperm(length(cv_label));
    cv_block_size = floor(length(cv_lable)./cv_k);
    for cv_i = 1:cv_k
        if(cv_i == cv_k)
            cv_test_idx{cv_i} = cv_rand_idx(((cv_i-1)*cv_block_size+1):end);
            cv_train_idx{cv_i} = 1:length(cv_label);
            cv_train_idx{cv_i}(cv_test_idx{cv_i}) = [];
        else
            cv_test_idx{cv_i} = cv_rand_idx(((cv_i-1)*cv_block_size+1):cv_i*cv_block_size);
            cv_train_idx{cv_i} = 1:length(cv_label);
            cv_train_idx{cv_i}(cv_test_idx{cv_i}) = [];
        end
    end
end