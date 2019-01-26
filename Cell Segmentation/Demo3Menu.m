function varargout = Demo3Menu(varargin)
% DEMO3MENU MATLAB code for Demo3Menu.fig
%      DEMO3MENU, by itself, creates a new DEMO3MENU or raises the existing
%      singleton*.
%
%      H = DEMO3MENU returns the handle to a new DEMO3MENU or the handle to
%      the existing singleton*.
%
%      DEMO3MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO3MENU.M with the given input arguments.
%
%      DEMO3MENU('Property','Value',...) creates a new DEMO3MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo3Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo3Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo3Menu

% Last Modified by GUIDE v2.5 08-Jun-2018 20:06:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo3Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo3Menu_OutputFcn, ...
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


% --- Executes just before Demo3Menu is made visible.
function Demo3Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo3Menu (see VARARGIN)

% Choose default command line output for Demo3Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demo3Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc;

path='case3.jpg';
D=im2double(imread(path));
Case=3;
A=D(:,:,2);
axes(handles.axes1);
imshow(A);
colormap (handles.axes1, 'default');

colormap gray;
axes(handles.axes2);
imshow(A);


%%%moving average filtering
C=moving_average_filter(A);


%%%%Segment the cell image directly
axes(handles.axes3);
hold on;
T1=zhenzhou_threshold_selection_Demo1(double(C),27);
% T1=zhenzhou_threshold_selection_updated(double(A),2,27,1);


axes(handles.axes4);
bC1=C>T1;
bC2=bwareaopen(bC1,100);
imagesc(bC2); colormap gray;


%%%%%Union method   ( CASE 3)
bC2(745:end,654:end)=0; %%%remove the text manually
obC=bC2;
axes(handles.axes5);
imagesc(obC);colormap gray;



%%%%shape filtering method
axes(handles.axes6);
[Filtered_Seed] = zhenzhou_shape_filtering_Demo1(obC,Case,16,handles);

%%%%Quantification method by iterative erosion method

axes(handles.axes8);
[rxc1, ryc1] = zhenzhou_iterative_erosion_Demo1(Filtered_Seed,1);
colormap(handles.axes8, 'default');


axes(handles.axes9);
imshow(D);
hold on;

axes(handles.axes9);
plot(double(ryc1),double(rxc1),'ro','MarkerSize',10,'LineWidth',2);


% --- Outputs from this function are returned to the command line.
function varargout = Demo3Menu_OutputFcn(hObject, eventdata, handles) 
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
Demo3Gui1();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui2();

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui3();

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui4();

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui5();

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui6();

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui7();

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui8();

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Demo3Gui9();
