function varargout = Figure_Viewer_compact(varargin)
% FIGURE_VIEWER MATLAB code for Figure_Viewer_compact.fig
%      FIGURE_VIEWER, by itself, creates a new FIGURE_VIEWER or raises the existing
%      singleton*.
%
%      H = FIGURE_VIEWER returns the handle to a new FIGURE_VIEWER or the handle to
%      the existing singleton*.
%
%      FIGURE_VIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGURE_VIEWER.M with the given input arguments.
%
%      FIGURE_VIEWER('Property','Value',...) creates a new FIGURE_VIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Figure_Viewer_compact_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Figure_Viewer_compact_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Figure_Viewer_compact

% Last Modified by GUIDE v2.5 20-Jul-2018 11:04:10


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Figure_Viewer_compact_OpeningFcn, ...
    'gui_OutputFcn',  @Figure_Viewer_compact_OutputFcn, ...
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



% --- Executes just before Figure_Viewer_compact is made visible.
function Figure_Viewer_compact_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Figure_Viewer_compact (see VARARGIN)

% Choose default command line output for Figure_Viewer_compact
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(hObject,'toolbar','figure','Units','Pixel')
child=hObject.Children;
for ii=1:length(child)
    child(ii).Units='Normalized';
    cpos{ii}=child(ii).Position;
end
SS=get(0,'ScreenSize');
set(hObject,'Position',SS.*[0.0194    0.0867    0.8712    0.7956])
global panhand;
panhand=findobj(hObject.Children,'Tag','axpan');
for ii=1:length(child)
    child(ii).Units='Normalized';
    child(ii).Position=cpos{ii};
end
lw=findobj(hObject.Children,'Tag','LineW');
lw.Units='Normalized';
pos=lw.Position;
panhand.Position=[0.0036    0.0182    1-1.2*pos(3)    0.9000];


% UIWAIT makes Figure_Viewer_compact wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Figure_Viewer_compact_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in IsBold.
function IsBold_Callback(hObject, eventdata, handles)
% hObject    handle to IsBold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IsBold
global panhand
child=panhand.Children;
if hObject.Value
    for ii=1:length(child)
        if strcmp(child(ii).Type,'axes')
            child(ii).FontWeight='bold';
        end
    end
else
    for ii=1:length(child)
        if strcmp(child(ii).Type,'axes')
            child(ii).FontWeight='normal';
        end
    end
end


% --- Executes on selection change in FontList.
function FontList_Callback(hObject, eventdata, handles)
% hObject    handle to FontList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FontList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FontList
global panhand
child=panhand.Children;
contents = cellstr(get(hObject,'String'));
set(child,'FontName',contents{get(hObject,'Value')})

% --- Executes during object creation, after setting all properties.
function FontList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FontList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject,'String',listfonts);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function FontSize_Callback(hObject, eventdata, handles)
% hObject    handle to FontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject,'Value');
global panhand
child=panhand.Children;

for ii=1:length(child)
    type=child(ii).Type;
    if strcmp(type,'legend')
        lval=child(ii).FontSize;
    end
    if strcmp(type,'axes')
        child(ii).FontSize=val;
        child2=child(ii).Children;
        h2=findobj(child2,'Type','text');
        for ii=1:length(h2)
            h2(ii).FontSize=.9*val;
        end
    end
    if strcmp(type,'legend')
        child(ii).FontSize=lval;
    end
end



% --- Executes during object creation, after setting all properties.
function FontSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Value',8);
stp=.5/(36-5);
set(hObject,'Max',36,'Min',5,'SliderStep',[stp stp]);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function LineW_Callback(hObject, eventdata, handles)
% hObject    handle to LineW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
lw=get(hObject,'Value');
global panhand;
child=panhand.Children;
for jj=1:length(child)
    if strcmp(child(jj).Type,'axes')
        child2=child(jj).Children;
        for ii=1:length(child2)
            if strcmp(child2(ii).Type,'line')
                child2(ii).LineWidth=lw;
            end
        end
    end
end


% --- Executes during object creation, after setting all properties.
function LineW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LineW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject,'Value',1);
set(hObject,'Max',5,'Min',.1)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function LFontSize_Callback(hObject, eventdata, handles)
% hObject    handle to LFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val=get(hObject,'Value');
global panhand;
child=panhand.Children;
for ii=1:length(child)
    if strcmp(child(ii).Type,'legend')
        child(ii).FontSize=val;
    end
end

% --- Executes during object creation, after setting all properties.
function LFontSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFontSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
set(hObject,'Value',8);
stp=.5/(36-5);
set(hObject,'Max',36,'Min',5,'SliderStep',[stp stp]);
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveButton.
function SaveButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global panhand
global fextension
ff=findobj(panhand.Parent.Children,'Tag','ftype');
ff=ff.String;
if strcmp(fextension,ff{1})
    errordlg('Please Choose a File Type','Extension Error','OK')
    return
end
savfig=figure(98);
clf(savfig)
child=panhand.Children;
dim=getpixelposition(panhand);
copyobj(child,savfig)
set(savfig,'Position',dim)
direct=findobj(panhand.Parent.Children,'Tag','SaveDirectory');
name=findobj(panhand.Parent.Children,'Tag','SaveName');
if strcmpi(direct.String,'pwd')||strcmpi(direct.String,'cd')
    direct.String=pwd;
end
tst=find(direct.String=='\');
if isempty(tst)
    sla='/';
else
    sla='\';
end
fname=[direct.String sla name.String];
saveas(savfig,fname,fextension)

function SaveName_Callback(hObject, eventdata, handles)
% hObject    handle to SaveName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveName as text
%        str2double(get(hObject,'String')) returns contents of SaveName as a double


% --- Executes during object creation, after setting all properties.
function SaveName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SaveDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveDirectory as text
%        str2double(get(hObject,'String')) returns contents of SaveDirectory as a double

% --- Executes during object creation, after setting all properties.
function SaveDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ftype.
function ftype_Callback(hObject, eventdata, handles)
% hObject    handle to ftype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ftype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ftype
contents = cellstr(get(hObject,'String'));
global fextension;
fextension=contents{get(hObject,'Value')};

% --- Executes during object creation, after setting all properties.
function ftype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ftype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global fextension
fextension=hObject.String;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject,'String',{'File Types...','jpg','png','epsc','fig'})
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function createfig2(figdata)
fig=figdata{1};



function figname_Callback(hObject, eventdata, handles)
% hObject    handle to figname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of figname as text
%        str2double(get(hObject,'String')) returns contents of figname as a double


% --- Executes during object creation, after setting all properties.
function figname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function figdire_Callback(hObject, eventdata, handles)
% hObject    handle to figdire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of figdire as text
%        str2double(get(hObject,'String')) returns contents of figdire as a double


% --- Executes during object creation, after setting all properties.
function figdire_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figdire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importbutton.
function importbutton_Callback(hObject, eventdata, handles)
% hObject    handle to importbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global panhand;
delete(panhand.Children)
kk=figure(99);
clf(kk)
kk.Name='Loaded Figure';
kk.NumberTitle='off';
par=get(hObject,'Parent');
handles=par.Children;
direct=findobj(handles,'Tag','figdire');
if strcmpi(direct.String,'pwd')||strcmpi(direct.String,'cd')
    direct.String=pwd;
end
name=findobj(handles,'Tag','figname');
str=name.String;
if ~strcmp(str(end-3:end),'.fig')
    name.String=[name.String '.fig'];
end
tst=find(direct.String=='\');
if isempty(tst)
    sla='/';
else
    sla='\';
end
fstr=[direct.String sla name.String];
if logical(exist(fstr))
    ff=openfig(fstr);
else
    errordlg('That Figure Does not Exist','Figure Name Error','OK')
    return
end
ff.Visible='off';
child=ff.Children;
copyobj(child,kk)
copyobj(child,panhand)
az=findobj(handles,'Tag','AZ');
el=findobj(handles,'Tag','EL');
ax=findobj(child,'Type','axes');
V=ax(1).View;
az.String=num2str(V(1));
el.String=num2str(V(2));

function panelhandle(hObject)
par=get(hObject,'Parent');
child=get(par,'Children');
k=findobj(child,'Type','uipanel');
% for ii=1:length(child)
%     child(ii)
%     if strcmp(child(ii).Type,'uipanel')
%         idx=ii;
%     end
% end
global panhand;
%panhand=child(idx);
panhand=k;



function AZ_Callback(hObject, eventdata, handles)
% hObject    handle to AZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AZ as text
%        str2double(get(hObject,'String')) returns contents of AZ as a double


% --- Executes during object creation, after setting all properties.
function AZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EL_Callback(hObject, eventdata, handles)
% hObject    handle to EL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EL as text
%        str2double(get(hObject,'String')) returns contents of EL as a double


% --- Executes during object creation, after setting all properties.
function EL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in View.
function View_Callback(hObject, eventdata, handles)
% hObject    handle to View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global panhand
child=panhand.Children;
ax=findobj(child,'Type','axes');
par=get(hObject,'Parent');
az=findobj(par.Children,'Tag','AZ');
az=str2num(az.String);
el=findobj(par.Children,'Tag','EL');
el=str2num(el.String);
if ~isempty(el)&&~isempty(az)
    for ii=1:length(ax)
        ax(ii).View=[az,el];
    end
end
% --- Executes on button press in lbox.
function lbox_Callback(hObject, eventdata, handles)
% hObject    handle to lbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lbox
if get(hObject,'Value')
    bxval='on';
else
    bxval='off';
end
par=get(hObject,'Parent');
lobj=findobj(par.Children,'Type','legend');
lobj.Box=bxval;
