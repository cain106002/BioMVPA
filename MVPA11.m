function varargout = MVPA11(varargin)
% MVPA11 M-file for MVPA11.fig
%      MVPA11, by itself, creates a new MVPA11 or raises the existing
%      singleton*.
%
%      H = MVPA11 returns the handle to a new MVPA11 or the handle to
%      the existing singleton*.
%
%      MVPA11('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MVPA11.M with the given input arguments.
%
%      MVPA11('Property','Value',...) creates a new MVPA11 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MVPA11_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MVPA11_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MVPA11

% Last Modified by GUIDE v2.5 12-Sep-2016 16:17:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MVPA11_OpeningFcn, ...
                   'gui_OutputFcn',  @MVPA11_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MVPA11 is made visible.
function MVPA11_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MVPA11 (see VARARGIN)

% Choose default command line output for MVPA11
handles.output = hObject;
global k;
k=0;
global position;
position=get(gcf,'Position');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MVPA11 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MVPA11_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in Dataainput.
function Dataainput_Callback(hObject, eventdata, handles)
% hObject    handle to Dataainput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datadir=uigetdir(cd,'Get data directory');
set(handles.datainputs,'String',datadir);
handles.Datadir=datadir;
guidata(hObject, handles);


function datainputs_Callback(hObject, eventdata, handles)
% hObject    handle to datainputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datainputs as text
%        str2double(get(hObject,'String')) returns contents of datainputs as a double


% --- Executes during object creation, after setting all properties.
function datainputs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datainputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in labell.
function labell_Callback(hObject, eventdata, handles)
% hObject    handle to labell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[labelname,pathname]=uigetfile({'*.txt'},'Get Label');
set(handles.labels,'String',[pathname,filesep,labelname]);
handles.Labeldir=[pathname,filesep,labelname];
guidata(hObject, handles);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in maskk.
function maskk_Callback(hObject, eventdata, handles)
% hObject    handle to maskk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[maskname,pathname]=uigetfile({'*.mat'},'Get Mask');
set(handles.masks,'String',[pathname,filesep,maskname]);
handles.Maskdir=[pathname,filesep,maskname];
guidata(hObject, handles);


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runn.
function runn_Callback(hObject, eventdata, handles)
% hObject    handle to runn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kf=get(handles.Kfold,'value');kfn=str2num(get(handles.kfolds,'String'));
Loo=get(handles.LOOCVV,'value');
if kf
    cr='kfold';
    crn=kfn;
elseif Loo
    cr='Loocv';
    crn=1;
end
Ztran=get(handles.Ztrans,'value');
FS=get(handles.FisherScoree,'value');FSa=str2num(get(handles.fisherscorea,'String'));FSb=str2num(get(handles.fisherscoreb,'String'));
Lass=get(handles.lassoo,'value');Lassa=str2num(get(handles.lassoa,'String'));Lassb=str2num(get(handles.lassoa,'String'));
Lambdaa=str2num(get(handles.lambdaa,'String'));Lambdab=str2num(get(handles.lambdab,'String'));
Ttest=get(handles.Ttest,'value');Ttesta=str2num(get(handles.Ttesta,'String'));Ttestb=str2num(get(handles.Ttestb,'String'));
nonlin=get(handles.nolinearsvmm,'value');
nonlinca=str2num(get(handles.nosvmca,'String'));nonlincb=str2num(get(handles.nosvmcb,'String'));
nonlinga=str2num(get(handles.nosvmga,'String'));nonlingb=str2num(get(handles.nosvmgb,'String'));
lin=get(handles.linearsvmm,'value');linca=str2num(get(handles.linsvmca,'String'));lincb=str2num(get(handles.linsvmcb,'String'));
grid=get(handles.gridsearchh,'value');PSO=get(handles.PSOO,'value');
if grid
    po='grid_search';
elseif PSO
    po='PSO';
end
mvpa_1 = mvpa(handles.Datadir,handles.Labeldir,handles.Maskdir,...
    'feature_selection','Fscore',[200],'param_search',po,[5],'normalization',...
    'zscore',[Ztran],'classifier','linearSVM',[1],'fs_param_range',{[2,FSa,FSb]},...
    'cfier_param_range',{[1,linca,lincb]},'fs_ps_ind',[1],'cfier_ps_ind',[1],...
     'cross_validation',cr,[crn]);
mvpa_2 = mvpa(handles.Datadir,handles.Labeldir,handles.Maskdir,...
    'feature_selection','Fscore',[200],'param_search',po,[5],'normalization',...
    'zscore',[Ztran],'classifier','libSVM',[1],'fs_param_range',{[2,FSa,FSb]},...
    'cfier_param_range',{[1,nonlinca,nonlincb],[1,nonlinga,nonlingb]},'fs_ps_ind',[1],'cfier_ps_ind',[1,1],...
     'cross_validation',cr,[crn]);
mvpa_3 = mvpa(handles.Datadir,handles.Labeldir,handles.Maskdir,...
    'feature_selection','Lasso',[200,0.05],'param_search',po,[5],'normalization',...
    'zscore',[Ztran],'classifier','linearSVM',[1],'fs_param_range',{[2,Lassa,Lassb],[2,Lambdaa,Lambdab]},...
    'cfier_param_range',{[1,linca,lincb]},'fs_ps_ind',[1,1],'cfier_ps_ind',[1],...
     'cross_validation',crn,[crn]);
mvpa_4 = mvpa(handles.Datadir,handles.Labeldir,handles.Maskdir,...
    'feature_selection','Lasso',[200,0.05],'param_search',po,[5],'normalization',...
    'zscore',[Ztran],'classifier','libSVM',[1],'fs_param_range',{[2,Lassa,Lassb],[2,Lambdaa,Lambdab]},...
    'cfier_param_range',{[1,nonlinca,nonlincb],[1,nonlinga,nonlingb]},'fs_ps_ind',[1,1],'cfier_ps_ind',[1,1],...
     'cross_validation',cr,[crn]);
mvpa_5 = mvpa(handles.Datadir,handles.Labeldir,handles.Maskdir,...
    'feature_selection','Ttest',[200],'param_search',po,[5],'normalization',...
    'zscore',[Ztran],'classifier','linearSVM',[1],'fs_param_range',{[2,Ttesta,Ttestb]},...
    'cfier_param_range',{[1,linca,lincb]},'fs_ps_ind',[1],'cfier_ps_ind',[1],...
     'cross_validation',cr,[crn]);
mvpa_6 = mvpa(handles.Datadir,handles.Labeldir,handles.Maskdir,...
    'feature_selection','Ttest',[200],'param_search',po,[5],'normalization',...
    'zscore',[Ztran],'classifier','libSVM',[1],'fs_param_range',{[2,Ttesta,Ttestb]},...
    'cfier_param_range',{[1,nonlinca,nonlincb],[1,nonlinga,nonlingb]},'fs_ps_ind',[1],'cfier_ps_ind',[1,1],...
     'cross_validation','cr',[crn]);
%
mkdir(['result']);
for i = 1:6
    folderName{i} = [cd,filesep,'result',filesep,'result_mvpa_', num2str(i)];  
    mkdir(folderName{i}); 
end
%
if FS&&lin
    mvpa_run(mvpa_1);
    save([cd,filesep,'result',filesep,'result_mvpa_1',filesep,'result.mat'],'mvpa_1');
end
if FS&&nonlin
    mvpa_run(mvpa_2);
    save([cd,filesep,'result',filesep,'result_mvpa_2',filesep,'result.mat'],'mvpa_2');
end
if Lass&&lin
    mvpa_run(mvpa_3);
    save([cd,filesep,'result',filesep,'result_mvpa_3',filesep,'result.mat'],'mvpa_3');
end
if Lass&&nonlin
    mvpa_run(mvpa_4);
    save([cd,filesep,'result',filesep,'result_mvpa_4',filesep,'result.mat'],'mvpa_4');
end
if Ttest&&lin
    mvpa_run(mvpa_5);
    save([cd,filesep,'result',filesep,'result_mvpa_5',filesep,'result.mat'],'mvpa_5');
end
if Ttest&&nonlin
    mvpa_run(mvpa_6);
    save([cd,filesep,'result',filesep,'result_mvpa_6',filesep,'result.mat'],'mvpa_6');
end
distest=get(handles.displaydonee,'value');
a=0;
for i=1:6
    tmp=['mvpa','_',num2str(2)];
    if tmp.acc_best(1)>a
        a=tmp.acc_best(1);
    end
end
if distest
%     MVPA_GUI2;
    handlesGU2=guihandles(MVPA_GUI2);
    set(handlesGU2.resultshow,'String',num2str(a));
end
guidata(hObject, handles);

% --- Executes on button press in Advancedd.
function Advancedd_Callback(hObject, eventdata, handles)
nposition=get(gcf,'Position');
global position
global k
k=k+1;
if mod(k,2)==0
    set(gcf,'Position',[nposition(1),nposition(2),position(3),position(4)]);
    set(handles.Advancedd,'String','Advanced>>');
else
    set(gcf,'Position',[nposition(1),nposition(2),2.2*position(3),position(4)]);
    resizeui=findobj('Tag','uipanel9');
    set(resizeui,'Visible','on');
    set(handles.Advancedd,'String','Advanced<<');
end
guidata(hObject, handles);


% hObject    handle to Advancedd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function labels_Callback(hObject, eventdata, handles)
% hObject    handle to labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of labels as text
%        str2double(get(hObject,'String')) returns contents of labels as a double


% --- Executes during object creation, after setting all properties.
function labels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function masks_Callback(hObject, eventdata, handles)
% hObject    handle to masks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of masks as text
%        str2double(get(hObject,'String')) returns contents of masks as a double


% --- Executes during object creation, after setting all properties.
function masks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to masks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Kfold.
function Kfold_Callback(hObject, eventdata, handles)
% hObject    handle to Kfold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Kfold



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LOOCVV.
function LOOCVV_Callback(hObject, eventdata, handles)
% hObject    handle to LOOCVV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOOCVV


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in FisherScoree.
function FisherScoree_Callback(hObject, eventdata, handles)
% hObject    handle to FisherScoree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FisherScoree


% --- Executes on button press in lassoo.
function lassoo_Callback(hObject, eventdata, handles)
% hObject    handle to lassoo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lassoo



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ttest.
function Ttest_Callback(hObject, eventdata, handles)
% hObject    handle to Ttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Ttest



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in nolinearsvmm.
function nolinearsvmm_Callback(hObject, eventdata, handles)
% hObject    handle to nolinearsvmm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nolinearsvmm


% --- Executes on button press in linearsvmm.
function linearsvmm_Callback(hObject, eventdata, handles)
% hObject    handle to linearsvmm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of linearsvmm



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fisherscorea_Callback(hObject, eventdata, handles)
% hObject    handle to fisherscorea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fisherscorea as text
%        str2double(get(hObject,'String')) returns contents of fisherscorea as a double


% --- Executes during object creation, after setting all properties.
function fisherscorea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fisherscorea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kfolds_Callback(hObject, eventdata, handles)
% hObject    handle to kfolds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kfolds as text
%        str2double(get(hObject,'String')) returns contents of kfolds as a double


% --- Executes during object creation, after setting all properties.
function kfolds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kfolds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nosvmca_Callback(hObject, eventdata, handles)
% hObject    handle to nosvmca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nosvmca as text
%        str2double(get(hObject,'String')) returns contents of nosvmca as a double


% --- Executes during object creation, after setting all properties.
function nosvmca_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nosvmca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nosvmcb_Callback(hObject, eventdata, handles)
% hObject    handle to nosvmcb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nosvmcb as text
%        str2double(get(hObject,'String')) returns contents of nosvmcb as a double


% --- Executes during object creation, after setting all properties.
function nosvmcb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nosvmcb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nosvmga_Callback(hObject, eventdata, handles)
% hObject    handle to nosvmga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nosvmga as text
%        str2double(get(hObject,'String')) returns contents of nosvmga as a double


% --- Executes during object creation, after setting all properties.
function nosvmga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nosvmga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nosvmgb_Callback(hObject, eventdata, handles)
% hObject    handle to nosvmgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nosvmgb as text
%        str2double(get(hObject,'String')) returns contents of nosvmgb as a double


% --- Executes during object creation, after setting all properties.
function nosvmgb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nosvmgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function linsvmca_Callback(hObject, eventdata, handles)
% hObject    handle to linsvmca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of linsvmca as text
%        str2double(get(hObject,'String')) returns contents of linsvmca as a double


% --- Executes during object creation, after setting all properties.
function linsvmca_CreateFcn(hObject, eventdata, handles)
% hObject    handle to linsvmca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function linsvmcb_Callback(hObject, eventdata, handles)
% hObject    handle to linsvmcb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of linsvmcb as text
%        str2double(get(hObject,'String')) returns contents of linsvmcb as a double


% --- Executes during object creation, after setting all properties.
function linsvmcb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to linsvmcb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fisherscoreb_Callback(hObject, eventdata, handles)
% hObject    handle to fisherscoreb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fisherscoreb as text
%        str2double(get(hObject,'String')) returns contents of fisherscoreb as a double


% --- Executes during object creation, after setting all properties.
function fisherscoreb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fisherscoreb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lassoa_Callback(hObject, eventdata, handles)
% hObject    handle to lassoa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lassoa as text
%        str2double(get(hObject,'String')) returns contents of lassoa as a double


% --- Executes during object creation, after setting all properties.
function lassoa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lassoa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lassob_Callback(hObject, eventdata, handles)
% hObject    handle to lassob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lassob as text
%        str2double(get(hObject,'String')) returns contents of lassob as a double


% --- Executes during object creation, after setting all properties.
function lassob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lassob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lambdaa_Callback(hObject, eventdata, handles)
% hObject    handle to lambdaa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lambdaa as text
%        str2double(get(hObject,'String')) returns contents of lambdaa as a double


% --- Executes during object creation, after setting all properties.
function lambdaa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambdaa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lambdab_Callback(hObject, eventdata, handles)
% hObject    handle to lambdab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lambdab as text
%        str2double(get(hObject,'String')) returns contents of lambdab as a double


% --- Executes during object creation, after setting all properties.
function lambdab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambdab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in displaydonee.
function displaydonee_Callback(hObject, eventdata, handles)
% hObject    handle to displaydonee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of displaydonee



% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Ztrans.
function Ztrans_Callback(hObject, eventdata, handles)
% hObject    handle to Ztrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Ztrans


% --- Executes during object creation, after setting all properties.
function uipanel9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Scalee.
function Scalee_Callback(hObject, eventdata, handles)
% hObject    handle to Scalee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[scalename,pathname]=uigetfile({'*.txt';'*.xls'},'Get Extra');
set(handles.scales,'String',[pathname,filesep,scalename]);
handles.extra=[pathname,filesep,scalename];
guidata(hObject, handles);


function scales_Callback(hObject, eventdata, handles)
% hObject    handle to scales (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scales as text
%        str2double(get(hObject,'String')) returns contents of scales as a double


% --- Executes during object creation, after setting all properties.
function scales_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scales (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ttesta_Callback(hObject, eventdata, handles)
% hObject    handle to Ttesta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ttesta as text
%        str2double(get(hObject,'String')) returns contents of Ttesta as a double


% --- Executes during object creation, after setting all properties.
function Ttesta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ttesta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ttestb_Callback(hObject, eventdata, handles)
% hObject    handle to Ttestb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ttestb as text
%        str2double(get(hObject,'String')) returns contents of Ttestb as a double


% --- Executes during object creation, after setting all properties.
function Ttestb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ttestb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Scalee.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to Scalee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Ztrans.
function Ztrans_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Ztrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
