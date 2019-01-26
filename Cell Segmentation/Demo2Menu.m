function varargout = Demo2Menu(varargin)
% DEMO2MENU MATLAB code for Demo2Menu.fig
%      DEMO2MENU, by itself, creates a new DEMO2MENU or raises the existing
%      singleton*.
%
%      H = DEMO2MENU returns the handle to a new DEMO2MENU or the handle to
%      the existing singleton*.
%
%      DEMO2MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO2MENU.M with the given input arguments.
%
%      DEMO2MENU('Property','Value',...) creates a new DEMO2MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo2Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo2Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo2Menu

% Last Modified by GUIDE v2.5 08-Jun-2018 19:07:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo2Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo2Menu_OutputFcn, ...
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


% --- Executes just before Demo2Menu is made visible.
function Demo2Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo2Menu (see VARARGIN)

% Choose default command line output for Demo2Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demo2Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc;

path='case2.tif';
D=im2double(imread(path));
Case=2;
A=D(:,:,1);

axes(handles.axes1);
imshow(A);
colormap gray;


%%%moving average filtering
C=moving_average_filter(A);


%%%%Segment the cell image directly
axes(handles.axes2);
hold on;

%%%obtain the gradient image
A=gradient_image(C);


%%%%obtain the contraint edges
T1=zhenzhou_threshold_selection_Demo1(double(A),9);
% T1=zhenzhou_threshold_selection_updated(double(A),2,27,1);
axes(handles.axes3);
bC=A>T1;
bbC=bwareaopen(bC,100);
imagesc(bbC); colormap gray;


%%%%%Union method   ( CASE 2 )
obC=~bbC;
axes(handles.axes4);
colormap(handles.axes4, 'default');
imagesc(obC);
bobC=bwareaopen(obC,30);
bobC=zhenzhou_clutter_filter(obC,4);

axes(handles.axes5);
imshow(bobC);
colormap gray;


%%%%shape filtering method
axes(handles.axes6);
[Filtered_Seed] = zhenzhou_shape_filtering_Demo1(bobC,Case,15,handles);

%%%%Quantification method by iterative erosion method

axes(handles.axes8);
[rxc1, ryc1] = zhenzhou_iterative_erosion_Demo1(Filtered_Seed,1);
colormap(handles.axes8, 'default');


axes(handles.axes9);
imshow(D);
hold on;

axes(handles.axes9);
plot(double(ryc1),double(rxc1),'g.','MarkerSize',30);


% --- Outputs from this function are returned to the command line.
function varargout = Demo2Menu_OutputFcn(hObject, eventdata, handles) 
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
Demo2Gui1();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui2();

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui3();

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui4();

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui5();

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui6();

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui7();

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui8();

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo2Gui9();
