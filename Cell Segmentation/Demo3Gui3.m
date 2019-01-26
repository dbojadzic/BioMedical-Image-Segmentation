function varargout = Demo3Gui3(varargin)
% DEMO3GUI3 MATLAB code for Demo3Gui3.fig
%      DEMO3GUI3, by itself, creates a new DEMO3GUI3 or raises the existing
%      singleton*.
%
%      H = DEMO3GUI3 returns the handle to a new DEMO3GUI3 or the handle to
%      the existing singleton*.
%
%      DEMO3GUI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO3GUI3.M with the given input arguments.
%
%      DEMO3GUI3('Property','Value',...) creates a new DEMO3GUI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo3Gui3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo3Gui3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo3Gui3

% Last Modified by GUIDE v2.5 08-Jun-2018 21:23:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo3Gui3_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo3Gui3_OutputFcn, ...
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


% --- Executes just before Demo3Gui3 is made visible.
function Demo3Gui3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo3Gui3 (see VARARGIN)

% Choose default command line output for Demo3Gui3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

path='case3.jpg';
D=im2double(imread(path));
Case=3;
A=D(:,:,2);
axes(handles.axes1);
colormap gray;
imshow(A);

%%%moving average filtering
C=moving_average_filter(A);
%%%%Segment the cell image directly
T1=zhenzhou_threshold_selection_Demo1_2(double(C),27);

picture = imread('Demo3Variables3.png');
axes(handles.axes2);
imshow(picture);

% UIWAIT makes Demo3Gui3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = Demo3Gui3_OutputFcn(hObject, eventdata, handles) 
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
Demo3Gui4();
