function label_predict = mvpa_predict(data,label,model)
%MVPA_PREDICT
label_predict = svmpredict(label,data,model);

end