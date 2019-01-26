function varargout = Demo1Menu(varargin)
% DEMO1MENU MATLAB code for Demo1Menu.fig
%      DEMO1MENU, by itself, creates a new DEMO1MENU or raises the existing
%      singleton*.
%
%      H = DEMO1MENU returns the handle to a new DEMO1MENU or the handle to
%      the existing singleton*.
%
%      DEMO1MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO1MENU.M with the given input arguments.
%
%      DEMO1MENU('Property','Value',...) creates a new DEMO1MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo1Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo1Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo1Menu

% Last Modified by GUIDE v2.5 06-Jun-2018 22:31:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo1Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo1Menu_OutputFcn, ...
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


% --- Executes just before Demo1Menu is made visible.
function Demo1Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo1Menu (see VARARGIN)

% Choose default command line output for Demo1Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demo1Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc;

path='case1.jpg';
%path='t4.jpg';
D=im2double(imread(path));
Case=1;
A=D(:,:,2);

axes(handles.axes1);
imshow(A);
colormap gray;


%%%moving average filtering
C=moving_average_filter(A);


%%%%Segment the cell image directly
axes(handles.axes2);
hold on;
T1=zhenzhou_threshold_selection_Demo1(double(C),17);


bC1=C>T1;

bC2=bwareaopen(bC1,100);
axes(handles.axes3);
imshow(bC2);
colormap gray;

%%%obtain the gradient image
A=gradient_image(C);


%%%%obtain the contraint edges
axes(handles.axes4);
T1=zhenzhou_threshold_selection_Demo1(double(A),17);
% T1=zhenzhou_threshold_selection_updated(double(A),2,27,1);
bC=A>T1;
bbC=bwareaopen(bC,100);


%%%%%Union method   ( CASE 1 )
obC=~bbC&~bC2;
bobC=bwareaopen(obC,30);
axes(handles.axes5);
imshow(bobC);
colormap gray;


%%%%shape filtering method
axes(handles.axes6);
[Filtered_Seed] = zhenzhou_shape_filtering_Demo1(bobC,Case,10,handles);

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
function varargout = Demo1Menu_OutputFcn(hObject, eventdata, handles) 
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
Demo1Gui1();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui2();

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui3();

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui4();

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui5();

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui6();

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui7();

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui8();

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo1Gui9();