function varargout = Demo1Gui5(varargin)
% DEMO1GUI5 MATLAB code for Demo1Gui5.fig
%      DEMO1GUI5, by itself, creates a new DEMO1GUI5 or raises the existing
%      singleton*.
%
%      H = DEMO1GUI5 returns the handle to a new DEMO1GUI5 or the handle to
%      the existing singleton*.
%
%      DEMO1GUI5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO1GUI5.M with the given input arguments.
%
%      DEMO1GUI5('Property','Value',...) creates a new DEMO1GUI5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo1Gui5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo1Gui5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo1Gui5

% Last Modified by GUIDE v2.5 07-Jun-2018 13:06:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo1Gui5_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo1Gui5_OutputFcn, ...
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


% --- Executes just before Demo1Gui5 is made visible.
function Demo1Gui5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo1Gui5 (see VARARGIN)

% Choose default command line output for Demo1Gui5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

path='case1.jpg';
D=im2double(imread(path));
Case=1;
A=D(:,:,2);
colormap gray;
C=moving_average_filter(A);
T1=zhenzhou_threshold_selection_Demo1_3(double(C),17);
bC1=C>T1;
bC2=bwareaopen(bC1,100);
axes(handles.axes1);
colormap gray;
A=gradient_image(C);
%%%%obtain the contraint edges
T1=zhenzhou_threshold_selection_Demo1_3(double(A),17);
bC=A>T1;
bbC=bwareaopen(bC,100);
%%%%%Union method   ( CASE 1 )
obC=~bbC&~bC2;
bobC=bwareaopen(obC,30);
imagesc(bobC);colormap gray;



picture = imread('Demo1Variables5.png');
axes(handles.axes2);
imshow(picture);

% UIWAIT makes Demo1Gui5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = Demo1Gui5_OutputFcn(hObject, eventdata, handles) 
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
Demo1Gui6();
