function isok = mvpa_result_export(result_path,acc_total,acc_group,label_group,label_out,sub_list,fs_weight,fs_consensus,data_info)
%MVPA_RESULT_EXPORT 此处显示有关此函数的摘要
%   此处显示详细说明
if(isempty(result_path))
    result_path = uigetdir(pwd,'select the path to export the result');
end
fid = fopen([result_path,filesep,'acc_report.txt'],'w');
fprintf(fid,['mean accuracy = ',num2str(acc_total*100),'%%\n']);
for i = 1:length(acc_group)
    fprintf(fid,['accuracy on group',num2str(label_group(i)),' = ',num2str(acc_group(i)*100),'%%\n']);
end
fclose(fid);

fid = fopen([result_path,filesep,'predicted_label.txt'],'w');
for i = 1:length(sub_list)
    fprintf(fid,[sub_list{i},'\t']);
    fprintf(fid,[num2str(label_out(i)),'\n']);
end
fclose(fid);

rest_WriteNiftiImage(fs_weight,data_info,[result_path,filesep,'feature_weight.nii']);
rest_WriteNiftiImage(fs_consensus,data_info,[result_path,filesep,'consensus_feature.nii']);
isok = 1;
end

