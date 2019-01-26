function varargout = Asbtmi4GUI1(varargin)
% ASBTMI4GUI1 MATLAB code for Asbtmi4GUI1.fig
%      ASBTMI4GUI1, by itself, creates a new ASBTMI4GUI1 or raises the existing
%      singleton*.
%
%      H = ASBTMI4GUI1 returns the handle to a new ASBTMI4GUI1 or the handle to
%      the existing singleton*.
%
%      ASBTMI4GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASBTMI4GUI1.M with the given input arguments.
%
%      ASBTMI4GUI1('Property','Value',...) creates a new ASBTMI4GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Asbtmi4GUI1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Asbtmi4GUI1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Asbtmi4GUI1

% Last Modified by GUIDE v2.5 09-Jun-2018 04:16:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Asbtmi4GUI1_OpeningFcn, ...
                   'gui_OutputFcn',  @Asbtmi4GUI1_OutputFcn, ...
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


% --- Executes just before Asbtmi4GUI1 is made visible.
function Asbtmi4GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Asbtmi4GUI1 (see VARARGIN)

% Choose default command line output for Asbtmi4GUI1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Asbtmi4GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

axes(handles.axes2);
imshow('Variables_A4_1.png');

axes(handles.axes1);
global I;
global path;
[I,path]=uigetfile('*.jpg','select a input image');
str=strcat(path,I);
s=imread(str);

    num_iter = 10;
    delta_t = 1/7;
    kappa = 15;
    option = 2;
    disp('Preprocessing image please wait . . .');
    ad = anisodiff(s,num_iter,delta_t,kappa,option);
    subplot 121, imshow(s,[]),title('Input image'), subplot 122, imshow(ad,[]),title('Fitered image'),
   

% --- Outputs from this function are returned to the command line.
function varargout = Asbtmi4GUI1_OutputFcn(hObject, eventdata, handles) 
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
Asbtmi4GUI2();
