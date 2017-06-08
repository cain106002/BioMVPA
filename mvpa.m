classdef mvpa < handle
    %MVPA class
    %   BioMVPA (alpha 0.01) oMVPA2.0 project started Heng@2017/06/06
    
    properties (SetAccess = public)
        % function_name
        mvpa_func = struct('cv','kfold','norm','none','fea_sele','none',...
            'cfier','linearSVM','para_sele','none','sub_sele','none',...
            'data_import','FC_map');
        % function_handles
        mvpa_func_handle = struct('cv',[],'norm',[],'fea_sele',[],...
            'cfier_train',[],'cfier_predict',[],'para_sele',[],...
            'sub_sele',[],'data_import',[],'result_export',[]);
        % data_pathes
        mvpa_path = struct('app',[],'data',[],'label',[],'mask',[],...
            'sub_info',[],'result',[]);
        % data
        mvpa_data = struct('data',[],'data_ex',[],'label',[],...
            'label_ex',[],'mask',[],'mask_ex',[],'sub_sele',[],...
            'sub_sele_ex',[],'sub_info',[]);
        % input params
        mvpa_para = struct('cv',[],'norm',[],'fea_sele',[],'cfier',[],...
            'para_sele',[],'fea_sele_range',[],'cfier_range',[],...
            'para_sele_ind',{},'data_import',[]);
        % sessions train_idx & test_idx
        mvpa_session = struct('idx_train',{},'idx_test',{});
        % output
        mvpa_output = struct('acc_best',[],'label_predict',[],...
            'labels',[],'fea_wei',[],'con_wei',[],'classify_wei',[]);
    end
    
    methods
        function obj = mvpa(varargin)
            obj.mvpa_path.data = varargin{1};
            obj.mvpa_path.label = varargin{2};
            if(nargin>2)
                obj.mvpa_path.mask = varargin{3};
            end
            mvpa_path_tmp = mfilename('fullpath');
            obj.mvpa_path.app = mvpa_path_tmp(1:end-4);
            if(nargin>3)
                i = 4;
                while(i<nargin)
                    switch varargin{i}
                        case 'data_import'
                            i = i+1;
                            obj.mvpa_func.data_import = varargin{i};
                            i = i+1;
                            obj.mvpa_para(1).data_import = varargin{i};
                        case 'subject_selection'
                            i = i+1;
                            obj.mvpa_func.sub_sele = varargin{i};
                            i = i+1;
                            obj.mvpa_para.sub_sele = varargin{i};
                        case 'cross_validation'
                            i = i+1;
                            obj.mvpa_func.cv = varargin{i};
                            i = i+1;
                            obj.mvpa_para.cv = varargin{i};
                        case 'normalization'
                            i = i+1;
                            obj.mvpa_func.norm= varargin{i};
                            i = i+1;
                            obj.mvpa_para.norm= varargin{i};
                        case 'feature_selection'
                            i = i+1;
                            obj.mvpa_func.fea_sele = varargin{i};
                            i = i+1;
                            obj.mvpa_para.fea_sele = varargin{i};
                        case 'classifier'
                            i = i+1;
                            obj.mvpa_func.cfier = varargin{i};
                            i = i+1;
                            obj.mvpa_para.cfier = varargin{i};
                        case 'param_search'
                            i = i+1;
                            obj.mvpa_func.para_sele = varargin{i};
                            i = i+1;
                            obj.mvpa_para.para_sele = varargin{i};
                        case 'fs_param_range'
                            i = i+1;
                            obj.mvpa_para.fea_sele_range = varargin{i};
                        case 'cfier_param_range'
                            i = i+1;
                            obj.mvpa_para.cfier_range = varargin{i};
                        case 'fs_ps_ind'
                            i = i+1;
                            obj.mvpa_para.para_sele_ind{1} = varargin{i};
                        case 'cfier_ps_ind'
                            i = i+1;
                            obj.mvpa_para.para_sele_ind{2}= varargin{i};
                        case 'output'
                            i = i+1;
                            obj.mvpa_path.result = varargin{i};
                        otherwise
                            error(['wrong param: ',varargin{i}]);
                    end
                    i = i+1;
                end
            end
            obj.mvpa_func_handle.cv = eval(['@cv_',obj.mvpa_func.cv]);
            obj.mvpa_func_handle.sub_sele = eval(['@ss_',obj.mvpa_func.sub_sele]);
            obj.mvpa_func_handle.norm = eval(['@norm_',obj.mvpa_func.norm]);
            obj.mvpa_func_handle.data_import = eval(['@di_',obj.mvpa_func.data_import]);
            obj.mvpa_func_handle.result_export = eval(['@re_',obj.mvpa_func.data_import]);
            obj.mvpa_func_handle.fea_sele = eval(['@fs_',obj.mvpa_func.fea_sele]);
            obj.mvpa_func_handle.cfier_train = eval(['@train_',obj.mvpa_func.cfier]);
            obj.mvpa_func_handle.cfier_predict = eval(['@predict_',obj.mvpa_func.cfier]);
            obj.mvpa_func_handle.para_sele = eval(['@ps_',obj.mvpa_func.para_sele]);
        end
        
        function load_data(obj)
            [obj.mvpa_data] = ...
                obj.mvpa_func_handle.data_import(obj.mvpa_path.data,...
                obj.mvpa_path.label,obj.mvpa_path.mask,...
                obj.mvpa_para.data_import);
        end
        
        function subject_selection(obj)
            [obj.mvpa_data] = obj.mvpa_func_handle.sub_sele(obj.mvpa_data,obj.mvpa_para.sub_sele);
        end
        
        function normalization(obj)
            obj.mvpa_data = obj.mvpa_func_handle.norm(obj.mvpa_data,obj.mvpa_para.norm);
        end
        
        function cross_validation(obj)
            obj.mvpa_session(1) = obj.mvpa_func_handle.cv(obj.mvpa_data.label,obj.mvpa_para.cv);
        end
        
        function [data_train_f,apply_param,idx_weight_out] = feature_selection(obj,data_train,label_train)
            fs_param_tmp = obj.fs_param;
            for i = 1:length(fs_param_tmp)
                if(obj.fs_param_range{i}(1) == 2)
                    %1: continous param
                    %2: distinct param
                    %3: feature number
                    fs_param_tmp(i) = fix(fs_param_tmp(i));
                end
                if(obj.fs_param_range{i}(1) == 3)
                    fs_param_tmp(i) = fix(fs_param_tmp(i));
                    if(fs_param_tmp(i)<1)
                        fs_param_tmp(i) = 1;
                    elseif(fs_param_tmp(i)>size(obj.data,2))
                        fs_param_tmp(i) = size(obj.data,2);
                    end
                end
                if(fs_param_tmp(i) < obj.fs_param_range{i}(2))
                    fs_param_tmp(i) = obj.fs_param_range{i}(2);
                elseif(fs_param_tmp(i) > obj.fs_param_range{i}(3))
                    fs_param_tmp(i) = obj.fs_param_range{i}(3);
                end
            end
            [data_train_f,apply_param,idx_weight_out] = ...
                mvpa_feature_selection(data_train,label_train,fs_param_tmp);
        end
        
        function classification(obj)
            obj.label_predict = zeros(size(obj.data,1),1);
            fs_weight = cell(length(obj.train_idx),1);
            for i = 1:length(obj.train_idx)
                disp(['classification: ',num2str(i),'/',num2str(length(obj.train_idx))]);
                data_train = obj.data(obj.train_idx{i},:);
                label_train = obj.label(obj.train_idx{i},:);
                data_test = obj.data(obj.test_idx{i},:);
                label_test = obj.label(obj.test_idx{i},:);
                
                [fs_param_best,cfier_param_best] = mvpa_param_search...
                    (data_train,label_train,obj.fs_param,obj.cfier_param,...
                    obj.fs_param_range,obj.cfier_param_range,obj.fs_ps_ind,obj.cfier_ps_ind);
                obj.fs_param = fs_param_best;
                obj.cfier_param = cfier_param_best;
                [data_train_f,apply_param,fs_weight{i}] = obj.feature_selection(data_train,label_train);
                data_test_f = mvpa_feature_selection_apply(data_test,label_test,apply_param);
                model = mvpa_classify(data_train_f,label_train,obj.cfier_param);
                obj.label_predict(obj.test_idx{i}) = mvpa_predict(data_test_f,label_test,model);
            end
            obj.acc_best(1) = sum(obj.label_predict == obj.label(:,1))./length(obj.label(:,1));
            obj.label_unique = unique(obj.label);
            for i = 1:length(obj.label_unique)
                obj.acc_best(i+1) = sum(obj.label_predict == obj.label_unique(i) ...
                    & obj.label(:,1) == obj.label_unique(i))...
                    ./sum(obj.label == obj.label_unique(i));
            end
            
            feature_weight_1d = zeros(size(fs_weight{1}));
            consensus_weight_1d = feature_weight_1d;
            % classification_weight_1d = feature_weight_1d;
            for i = 1:length(fs_weight)
                feature_weight_1d = feature_weight_1d+fs_weight{i};
                consensus_weight_1d(fs_weight{i}~= 0) = consensus_weight_1d(fs_weight{i}~= 0)+1;
                % classification_weight_1d = classification_weight_1d +
                % class_weight;
            end
            feature_weight_1d = feature_weight_1d./length(fs_weight);
            consensus_weight_1d = consensus_weight_1d./length(fs_weight);
            % classification_weight_1d =
            % classificcation_weight_1d./length(fs_weight);
            obj.feature_weight = zeros(size(obj.mask));
            obj.consensus_weight = zeros(size(obj.mask));
            obj.feature_weight(obj.mask ~= 0) = feature_weight_1d;
            obj.consensus_weight(obj.mask ~=0) = consensus_weight_1d;
        end
        
        function export_result(obj)
            [acc_total,label_out,acc_group,label_group] = obj.get_accuracy();
            sub_list = obj.get_subjects_used();
            fs_weight = obj.get_feature_weight();
            fs_consensus = obj.get_consensus_feature();
            mvpa_result_export(obj.output_path,acc_total,acc_group,label_group,label_out,...
                sub_list,fs_weight,fs_consensus,obj.data_info);
        end
        
        function [acc_total,label_out,acc_group,label_group] = get_accuracy(obj)
            acc_total = obj.acc_best(1);
            label_out = obj.label_predict;
            acc_group = obj.acc_best(2:end);
            label_group = obj.label_unique;
        end
        
        function sub_list = get_subjects_used(obj)
            subs = dir(obj.data_path);
            subs(1:2) = [];
            subs = subs(obj.ss_idx);
            sub_list = cell(length(subs),1);
            for i = 1:length(subs)
                sub_list{i} = subs(i).name;
            end
        end
        
        function fs_weight = get_feature_weight(obj)
            fs_weight = obj.feature_weight;
        end
        
        function fs_consensus = get_consensus_feature(obj)
            fs_consensus = obj.consensus_weight;
        end
        
    end
end