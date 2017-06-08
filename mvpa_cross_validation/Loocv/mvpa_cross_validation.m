function [train_idx,test_idx] = mvpa_cross_validation(label,k)
if k
    train_idx=cell(1,length(label));test_idx=train_idx;
    for i=1:length(label)
        temp=1:length(label);
        test_idx{i}=i;
        temp(i)=[];
        train_idx{i}=temp;
    end
end