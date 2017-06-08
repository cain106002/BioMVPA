function label_predict = mvpa_predict(data,label,model)
%MVPA_PREDICT
label_predict = predict(label,sparse(data),model,'-q');

end

