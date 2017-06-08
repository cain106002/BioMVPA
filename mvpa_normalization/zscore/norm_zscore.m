function mvpa_data = norm_zscore(mvpa_data,norm_param)
mvpa_data.data = zscore(mvpa_data.data);
end