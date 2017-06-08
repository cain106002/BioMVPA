function mvpa_run(mvpabatch)
mvpabatch.initial_path();
mvpabatch.load_data();
mvpabatch.load_label();
mvpabatch.balanced();
mvpabatch.cross_validation();
mvpabatch.normalization();
mvpabatch.classification();
disp(mvpabatch.acc_best);
end