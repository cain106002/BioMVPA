function [fs_param_best,cfier_param_best] = mvpa_param_search...
    (data,label,fs_param_default,cfier_param_default,...
    fs_param_range,cfier_param_range,fs_ps_ind,cfier_ps_ind)
k = 5;
log_step = 2;
ps_count = 3;
for i = 1:length(fs_param_default)        
    if(fs_ps_ind(i))
        log_min = log2(fs_param_range{i}(2));
        log_max = log2(fs_param_range{i}(3));
        fs_param_cell{i} = log_min:((log_max-log_min)/ps_count):log_max;
        fs_param_cell{i} = 2.^fs_param_cell{i};
        if(fs_param_range{i}(1) == 2)
            fs_param_cell{i} = fix(fs_param_cell{i});
        end
        if(fs_param_range{i}(1) == 3)
            fs_param_cell{i} = fix(fs_param_cell{i});
            fs_param_cell{i}(fs_param_cell{i}<1) = 1;
            fs_param_cell{i}(fs_param_cell{i}>size(data,2)) = size(data,2);
        end
        fs_param_cell{i}(fs_param_cell{i}>fs_param_range{i}(3)) = fs_param_range{i}(3);
        fs_param_cell{i}(fs_param_cell{i}<fs_param_range{i}(2)) = fs_param_range{i}(2);
        fs_param_cell{i} = unique(fs_param_cell{i});
    else
        fs_parm_cell{i} = fs_param_default(i);
    end
end
for i = 1:length(cfier_param_default)        
    if(cfier_ps_ind(i))
        log_min = log2(cfier_param_range{i}(2));
        log_max = log2(cfier_param_range{i}(3));
        cfier_param_cell{i} = log_min:((log_max-log_min)/ps_count):log_max;
        cfier_param_cell{i} = 2.^cfier_param_cell{i};
        if(cfier_param_range{i}(1) == 2)
            cfier_param_cell{i} = fix(cfier_param_cell{i});
        end
        cfier_param_cell{i}(cfier_param_cell{i}>cfier_param_range{i}(3)) = cfier_param_range{i}(3);
        cfier_param_cell{i}(cfier_param_cell{i}<cfier_param_range{i}(2)) = cfier_param_range{i}(2);
        cfier_param_cell{i} = unique(cfier_param_cell{i});
    else
        cfier_param_cell{i} = cfier_param_default(i);
    end
end
fs_param_num = length(fs_param_cell);
cfier_param_num = length(cfier_param_cell);
total_param = [fs_param_cell,cfier_param_cell];
com_str_left = '[';
com_str_right = '=ndgrid(';
for i = 1:length(total_param)
    com_str_left = [com_str_left,'total_param_mat(',num2str(i)];
    for j = 1:length(total_param)
        com_str_left = [com_str_left,',:'];
    end
    com_str_left = [com_str_left,')'];
    com_str_right = [com_str_right,'total_param{',num2str(i),'}'];
    if(i == length(total_param))
        com_str_left = [com_str_left,']'];
        com_str_right = [com_str_right,');'];
    else
        com_str_left = [com_str_left,','];
        com_str_right = [com_str_right,','];
    end
end
eval([com_str_left,com_str_right]);
com_str = 'total_param_cell = mat2cell(total_param_mat,length(total_param)';
for i = 1:length(total_param)
    com_str = [com_str,',ones(',num2str(length(total_param{i})),',1)'];
end
com_str = [com_str,');'];
eval(com_str);
acc_best = 0;
[train_idx,test_idx] = mvpa_cross_validation(label,k);
for param_tmp = total_param_cell
    fs_param_tmp = squeeze(param_tmp{1}(1:fs_param_num));
    cfier_param_tmp = squeeze(param_tmp{1}(fs_param_num+1:end));
    for i = 1:k
        data_train = data(train_idx{i},:);
        label_train = label(train_idx{i},:);
        data_test = data(test_idx{i},:);
        label_test = label(test_idx{i},:);
        [data_train_f,apply_param] = ...
            mvpa_feature_selection(data_train,label_train,fs_param_tmp);
        data_test_f = mvpa_feature_selection_apply(data_test,label_test,apply_param);
        model = mvpa_classify(data_train_f,label_train,cfier_param_tmp);
        label_predict(test_idx{i}) = mvpa_predict(data_test_f,label_test,model);
    end
    acc_tmp = sum(label_predict' == label(:,1))./length(label(:,1));
    if(acc_tmp>acc_best)
        acc_best = acc_tmp;
        param_best = param_tmp;
    end
end
fs_param_best = param_best{1}(1:fs_param_num);
cfier_param_best = param_best{1}(fs_param_num+1:end);