function varargout = Demo2Gui4(varargin)
% DEMO2GUI4 MATLAB code for Demo2Gui4.fig
%      DEMO2GUI4, by itself, creates a new DEMO2GUI4 or raises the existing
%      singleton*.
%
%      H = DEMO2GUI4 returns the handle to a new DEMO2GUI4 or the handle to
%      the existing singleton*.
%
%      DEMO2GUI4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO2GUI4.M with the given input arguments.
%
%      DEMO2GUI4('Property','Value',...) creates a new DEMO2GUI4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo2Gui4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo2Gui4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo2Gui4

% Last Modified by GUIDE v2.5 08-Jun-2018 19:40:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo2Gui4_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo2Gui4_OutputFcn, ...
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


% --- Executes just before Demo2Gui4 is made visible.
function Demo2Gui4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo2Gui4 (see VARARGIN)

% Choose default command line output for Demo2Gui4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

path='case2.tif';
D=im2double(imread(path));
Case=2;
A=D(:,:,1);
axes(handles.axes1);
%%%moving average filtering
C=moving_average_filter(A);
%%%obtain the gradient image
A=gradient_image(C);
%%%%obtain the contraint edges
T1=zhenzhou_threshold_selection_Demo1_3(double(A),9);
bC=A>T1;
bbC=bwareaopen(bC,100);

%%%%%Union method   ( CASE 2 )
obC=~bbC;
imagesc(obC);




picture = imread('Demo2Variables4.png');
axes(handles.axes2);
imshow(picture);

% UIWAIT makes Demo2Gui4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = Demo2Gui4_OutputFcn(hObject, eventdata, handles) 
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
Demo2Gui5();
