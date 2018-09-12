function varargout = ui(varargin)
% UI MATLAB code for ui.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui

% Last Modified by GUIDE v2.5 07-Mar-2016 11:33:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
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


% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui (see VARARGIN)

% Choose default command line output for ui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.stp, 'Enable', 'off');
set(handles.str, 'Enable', 'off');
set(handles.sync, 'Enable', 'off');

% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in ld.
function ld_Callback(hObject, eventdata, handles)
% hObject    handle to ld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname pname] = uigetfile({'*.bmp';'*.png'}, 'Select CNC design')
if fname ~= 0
    img = imread(fullfile(pname,fname));
    assignin('base','ima',img);
    a = figure;
    assignin('base','flg',1);
    assignin('base','cnton',0);
    assignin('base','ys', 0);
    assignin('base','xs', 0);
    assignin('base', 'hfig',a);
    imm = insertShape(img, 'FilledCircle', [6 6 3], 'Color', 'red');
    imshow(imm);
    title('Move drill to the red dot and press Sync');
    set(handles.sync, 'Enable', 'on');
end
% --- Executes on button press in str.
function str_Callback(hObject, eventdata, handles)
% hObject    handle to str (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in xp.
function xp_Callback(hObject, eventdata, handles)
% hObject    handle to xp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode = get(hObject,'String');
a = evalin('base','ser');
if strcmp(mode, 'Stop')
    fprintf(a,'h');
    set(handles.xn,'Enable', 'on');
    set(handles.yp,'Enable', 'on');
    set(handles.yn,'Enable', 'on');
    set(hObject,'String','+Ve');
else
    if get(handles.SS,'value')
        fprintf(a,'3');
        fprintf(a,'b');
    else
        fprintf(a,'e');
        set(handles.xn,'Enable', 'off');
        set(handles.yp,'Enable', 'off');
        set(handles.yn,'Enable', 'off');
        set(hObject,'String','Stop');
    end
end
cnton = evalin('base', 'cnton');
if cnton == 1
    xs = evalin('base','xs');
    xs=xs+1
    assignin('base','xs',xs);
end


% --- Executes on button press in xn.
function xn_Callback(hObject, eventdata, handles)
% hObject    handle to xn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode = get(hObject,'String');
a = evalin('base','ser');
if strcmp(mode, 'Stop')
    fprintf(a,'h');
    set(handles.xp,'Enable', 'on');
    set(handles.yp,'Enable', 'on');
    set(handles.yn,'Enable', 'on');
    set(hObject,'String','-Ve');
else
    if get(handles.SS,'value')
        fprintf(a,'4');
        fprintf(a,'b');
    else
        fprintf(a,'f');
        set(handles.xp,'Enable', 'off');
        set(handles.yp,'Enable', 'off');
        set(handles.yn,'Enable', 'off');
        set(hObject,'String','Stop');
    end
end
cnton = evalin('base', 'cnton');
if cnton == 1
    xs = evalin('base','xs');
    xs=xs-1
    assignin('base','xs',xs);
end


% --- Executes on button press in yp.
function yp_Callback(hObject, eventdata, handles)
% hObject    handle to yp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode = get(hObject,'String');
a = evalin('base','ser');
if strcmp(mode, 'Stop')
    fprintf(a,'h');
    set(handles.xn,'Enable', 'on');
    set(handles.xp,'Enable', 'on');
    set(handles.yn,'Enable', 'on');
    set(hObject,'String','+Ve');
else
    if get(handles.SS,'value')
        fprintf(a,'1');
        fprintf(a,'a');
    else
        fprintf(a,'c');
        set(handles.xn,'Enable', 'off');
        set(handles.xp,'Enable', 'off');
        set(handles.yn,'Enable', 'off');
        set(hObject,'String','Stop');
    end
end
cnton = evalin('base', 'cnton');
if cnton == 1
    ys = evalin('base','ys');
    ys=ys+1
    assignin('base','ys',ys);
end

% --- Executes on button press in yn.
function yn_Callback(hObject, eventdata, handles)
% hObject    handle to yn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode = get(hObject,'String');
a = evalin('base','ser');
if strcmp(mode, 'Stop')
    fprintf(a,'h');
    set(handles.xn,'Enable', 'on');
    set(handles.yp,'Enable', 'on');
    set(handles.xp,'Enable', 'on');
    set(hObject,'String','-Ve');
else
    if get(handles.SS,'value')
        fprintf(a,'2');
        fprintf(a,'a');
    else
        fprintf(a,'d');
        set(handles.xn,'Enable', 'off');
        set(handles.yp,'Enable', 'off');
        set(handles.xp,'Enable', 'off');
        set(hObject,'String','Stop');
    end
end
cnton = evalin('base', 'cnton');
if cnton == 1
    ys = evalin('base','ys');
    ys=ys-1
    assignin('base','ys',ys);
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dr.
function dr_Callback(hObject, eventdata, handles)
% hObject    handle to dr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = evalin('base','ser');
fprintf(a,'9');
switch get(handles.popupmenu1,'Value')
    case 1
        fprintf(a,'1t');
    case 2
        fprintf(a,'2t');
    case 3
        fprintf(a,'3t');
    otherwise
end

% --- Executes on button press in stp.
function stp_Callback(hObject, eventdata, handles)
% hObject    handle to stp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base', 'flg',0);
g = evalin('base', 'hfig');
close(g);

% --- Executes on button press in sync.
function sync_Callback(hObject, eventdata, handles)
% hObject    handle to sync (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = evalin('base','cnton');
if a == 0
    assignin('base','cnton',1);
    im = evalin('base','ima');
    hfig = evalin('base','hfig');
    close(hfig);
    hfig=figure;
    assignin('base','hfig',hfig);
    [m n] = size(im);
    imm = insertShape(im,'FilledCircle',[n-6 m-6 3],'Color','red');
    imshow(imm);
    title('Now move drill again to the red dot and press Sync');
else
    
    assignin('base','cnton',0);
    set(handles.sync,'Enable','off');
    assignin('base','ready',1);
    %auto
end



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SS.
function SS_Callback(hObject, eventdata, handles)
% hObject    handle to SS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SS


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function port_Callback(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of port as text
%        str2double(get(hObject,'String')) returns contents of port as a double


% --- Executes during object creation, after setting all properties.
function port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in init.
function init_Callback(hObject, eventdata, handles)
% hObject    handle to init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = serial(get(handles.port,'String'));
assignin('base', 'ser', a);
b = evalin('base','ser');
fopen(b);
set(handles.pushbutton15,'Enable','on');
set(hObject, 'Enable','off');

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.init,'Enable','on');
set(hObject, 'Enable', 'off');
a = evalin('base','ser');
fclose(a);


% --- Executes on button press in pbup.
function pbup_Callback(hObject, eventdata, handles)
% hObject    handle to pbup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ser = evalin('base','ser');
fprintf(ser,'w');


% --- Executes on button press in pbd.
function pbd_Callback(hObject, eventdata, handles)
% hObject    handle to pbd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ser = evalin('base','ser');
fprintf(ser,'q');