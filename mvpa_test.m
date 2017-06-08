clear
clc
%
mvpa_mri = mvpa('.\test_data\data','.\test_data\label.txt','.\test_data\mask.mat',...
    'data_import','FC_map',[],'subject_selection','balanced','.\test_data\measures.txt',...
    'feature_selection','Fscore',[200],'param_search','grid_search',[],'normalization',...
    'zscore',[],'classifier','linearSVM',[1],'fs_param_range',{[3,10,100]},...
    'cfier_param_range',{[1,0.0001,1000]},'fs_ps_ind',[1],'cfier_ps_ind',[1],...
    'cross_validation','kfold',[5]);
mvpa_mri.initial_path();
mvpa_mri.load_data();
mvpa_mri.load_params();
mvpa_mri.subject_selection();
mvpa_mri.normalization();
mvpa_mri.cross_validation();
mvpa_mri.classification();
[acc_total,label_out,acc_group,label_group] = mvpa_mri.get_accuracy();
mvpa_mri.export_result();

