function [fs_param_best,cfier_param_best] = mvpa_param_search...
    (data,label,fs_param_default,cfier_param_default,...
    fs_param_range,cfier_param_range,fs_ps_ind,cfier_ps_ind)
c1 = 2;
c2 = 2;
maxgen = 2;
sizepop = 5;
Vmax_multi = 0.1;
kfold_num = 5;
[train_idx,test_idx] = mvpa_cross_validation(label,kfold_num);
for i = 1:length(fs_ps_ind)
    if(fs_ps_ind(i))
        Vmax_fs(i) = Vmax_multi*(fs_param_range{i}(3)-fs_param_range{i}(2));
    else
        Vmax_fs(i) = 0;
    end
end
for i = 1:length(cfier_ps_ind)
    if(cfier_ps_ind(i))
        Vmax_cfier(i) = Vmax_multi*(cfier_param_range{i}(3)-cfier_param_range{i}(2));
    else
        Vmax_cfier(i) = 0;
    end
end
% initialization
for i = 1:sizepop
    for j = 1:length(fs_ps_ind)
        if(fs_ps_ind(j))
            pop_fs(i,j) = fs_param_range{j}(2)+rand*(fs_param_range{j}(3)-fs_param_range{j}(2));
            V_fs(i,j) = 0.2*(rand-0.5)*(fs_param_range{j}(3)-fs_param_range{j}(2));
        else
            pop_fs(i,j) = fs_param_default(j);
            V_fs(i,j) = 0;
        end
    end
    for j = 1:length(cfier_ps_ind)
        if(cfier_ps_ind(j))
            pop_cfier(i,j) = cfier_param_range{j}(2)+rand*(cfier_param_range{j}(3)-cfier_param_range{j}(2));
            V_cfier(i,j) = 0.2*(rand-0.5)*(cfier_param_range{j}(3)-cfier_param_range{j}(2));
        else
            pop_cfier(i,j) = cfier_param_default(j);
            V_cfier(i,j) = 0;
        end
    end
    fitness(i) = ps_classify(data,label,train_idx,test_idx,kfold_num,pop_fs(i,:),pop_cfier(i,:),...
        fs_param_range,cfier_param_range,fs_ps_ind,cfier_ps_ind);
end
[bestfitness, bestindex] = max(fitness);
zbest_fs = pop_fs(bestindex,:);
zbest_cfier = pop_cfier(bestindex,:);
gbest_fs = pop_fs;
gbest_cfier = pop_cfier;
fitnessgbest = fitness;
fitnesszbest = bestfitness;
for i = 1:maxgen
    for j = 1:sizepop
        c1_multi = rand;
        c2_multi = rand;
        V_fs(j,:) = V_fs(j,:)+...
            c1*c1_multi*(gbest_fs(j,:)-pop_fs(j,:))+...
            c2*c2_multi*(zbest_fs-pop_fs(j,:));
        V_cfier(j,:) = V_cfier(j,:)+...
            c1*c1_multi*(gbest_cfier(j,:)-pop_cfier(j,:))+...
            c2*c2_multi*(zbest_cfier-pop_cfier(j,:));
        for k = 1:length(fs_ps_ind)
            if(V_fs(j,k)>Vmax_fs(k))
                V_fs(j,k) = Vmax_fs(k);
            end
        end
        for k = 1:length(cfier_ps_ind)
            if(V_cfier(j,k)>Vmax_cfier(k))
                V_cfier(j,k) = Vmax_cfier(k);
            end
        end
        pop_fs(j,:) = pop_fs(j,:)+0.5*V_fs(j,:);
        pop_cfier(j,:) = pop_cfier(j,:)+0.5*V_cfier(j,:);
        if(rand>0.8)
            for p = 1:length(fs_ps_ind)
                if(fs_ps_ind(p))
                    pop_fs(j,p) = fs_param_range{p}(2)+...
                        rand*(fs_param_range{p}(3)-...
                        fs_param_range{p}(2));
                else
                    pop_fs(j,p) = fs_param_default(p);
                end
            end
            for p = 1:length(cfier_ps_ind)
                if(cfier_ps_ind(p))
                    pop_cfier(j,p) = cfier_param_range{p}(2)+...
                        rand*(cfier_param_range{p}(3)-...
                        cfier_param_range{p}(2));
                else
                    pop_cfier(j,p) = cfier_param_default(p);
                end
            end
        end
        fitness(j) = ps_classify(data,label,train_idx,test_idx,kfold_num,pop_fs(j,:),pop_cfier(j,:),...
            fs_param_range,cfier_param_range,fs_ps_ind,cfier_ps_ind);
        if(fitness(j)>fitnessgbest(j))
            gbest_fs(j,:) = pop_fs(j,:);
            gbest_cfier(j,:) = pop_cfier(j,:);
            fitnessgbest(j) = fitness(j);
        end
        if(fitness(j)>fitnesszbest)
            zbest_fs = pop_fs(j,:);
            zbest_cfier = pop_cfier(j,:);
            fitnesszbest = fitness(j);
        end
    end
end
fs_param_best = zbest_fs;
cfier_param_best = zbest_cfier;
end

function acc = ps_classify(data,label,train_idx,test_idx,k,pop_fs,pop_cfier,...
            fs_param_range,cfier_param_range,fs_ps_ind,cfier_ps_ind)
        for i = 1:length(fs_ps_ind)
            if(fs_param_range{i}(1) == 2)
                pop_fs(i) = fix(pop_fs(i));
            end
            if(fs_param_range{i}(1) == 3)
                pop_fs(i) = fix(pop_fs(i));
                if(pop_fs(i)<1)
                    pop_fs(i) = 1;
                end
                if(pop_fs(i)>size(data,2))
                    pop_fs(i) = size(data,2);
                end
            end
            if(pop_fs(i)>fs_param_range{i}(3))
                pop_fs(i) = fs_param_range{i}(3);
            end
            if(pop_fs(i)<fs_param_range{i}(2))
                pop_fs(i) = fs_param_range{i}(2);
            end
        end
        for i = 1:length(cfier_ps_ind)
            if(pop_cfier(i)>cfier_param_range{i}(3))
                pop_cfier(i) = cfier_param_range{i}(3);
            end
            if(pop_cfier(i)<cfier_param_range{i}(2))
                pop_cfier(i) = cfier_param_range{i}(2);
            end
            if(cfier_param_range{i}(1) == 2)
                pop_cfier(i) = fix(pop_cfier(i));
            end
        end

        fs_param_tmp = pop_fs;
        cfier_param_tmp = pop_cfier;
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
        acc = sum(label_predict' == label(:,1))./length(label(:,1)); 
end