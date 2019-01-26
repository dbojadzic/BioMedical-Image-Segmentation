function varargout = Demo3Gui2(varargin)
% DEMO3GUI2 MATLAB code for Demo3Gui2.fig
%      DEMO3GUI2, by itself, creates a new DEMO3GUI2 or raises the existing
%      singleton*.
%
%      H = DEMO3GUI2 returns the handle to a new DEMO3GUI2 or the handle to
%      the existing singleton*.
%
%      DEMO3GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO3GUI2.M with the given input arguments.
%
%      DEMO3GUI2('Property','Value',...) creates a new DEMO3GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo3Gui2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo3Gui2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo3Gui2

% Last Modified by GUIDE v2.5 08-Jun-2018 21:21:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo3Gui2_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo3Gui2_OutputFcn, ...
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


% --- Executes just before Demo3Gui2 is made visible.
function Demo3Gui2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo3Gui2 (see VARARGIN)

% Choose default command line output for Demo3Gui2
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


picture = imread('Demo3Variables1&2.png');
axes(handles.axes2);
imshow(picture);

% UIWAIT makes Demo3Gui2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = Demo3Gui2_OutputFcn(hObject, eventdata, handles) 
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
Demo3Gui3();
