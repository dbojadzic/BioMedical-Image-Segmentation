function varargout = Asbtmi4GUI2(varargin)
% ASBTMI4GUI2 MATLAB code for Asbtmi4GUI2.fig
%      ASBTMI4GUI2, by itself, creates a new ASBTMI4GUI2 or raises the existing
%      singleton*.
%
%      H = ASBTMI4GUI2 returns the handle to a new ASBTMI4GUI2 or the handle to
%      the existing singleton*.
%
%      ASBTMI4GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASBTMI4GUI2.M with the given input arguments.
%
%      ASBTMI4GUI2('Property','Value',...) creates a new ASBTMI4GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Asbtmi4GUI2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Asbtmi4GUI2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Asbtmi4GUI2

% Last Modified by GUIDE v2.5 09-Jun-2018 04:18:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Asbtmi4GUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @Asbtmi4GUI2_OutputFcn, ...
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


% --- Executes just before Asbtmi4GUI2 is made visible.
function Asbtmi4GUI2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Asbtmi4GUI2 (see VARARGIN)

% Choose default command line output for Asbtmi4GUI2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Asbtmi4GUI2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

axes(handles.axes2);
imshow('Variables_A4_2.png');

axes(handles.axes1);
global I;
global path;
str=strcat(path,I);
s=imread(str);

    num_iter = 10;
    delta_t = 1/7;
    kappa = 15;
    option = 2;
    disp('Preprocessing image please wait . . .');
    ad = anisodiff(s,num_iter,delta_t,kappa,option);
    subplot 121, imshow(s,[]),title('Input image'), subplot 122, imshow(ad,[]),title('Fitered image'),
    
 
m = zeros(size(ad,1),size(ad,2));          %-- create initial mask 

m(90:100,110:135) = 1;  % main 2


ad = imresize(ad,.5);  %-- make image smaller 
m = imresize(m,.5);  %     for fast computation
subplot(2,2,1); imshow(ad,[]); title('Input Image');
% bounding box start
subplot(2,2,2); imshow(ad,[]);
hold on
if(strcmp(I,'a1.jpg')||strcmp(I,'a.jpg'))
    rectangle('Position',[40 47 20 22],'EdgeColor','y'); %a1
end;
if(strcmp(I,'b1.jpg')||strcmp(I,'b.jpg'))
    rectangle('Position',[61 49 18 20],'EdgeColor','y');  %b1
end;
if(strcmp(I,'c1.jpg')||strcmp(I,'c.jpg'))
    rectangle('Position',[35 26 34 40],'EdgeColor','y');  %c1
    cd=imcrop(ad,[35 26 34 40]);
end;

hold off
title('Locating Bounding box');
% bounding box end


subplot(2,2,3); title('Segmentation');

seg = svm(ad, m, 50); %-- Run segmentation

subplot(2,2,4); imshow(seg); title('Segmented Tumor');
   

% --- Outputs from this function are returned to the command line.
function varargout = Asbtmi4GUI2_OutputFcn(hObject, eventdata, handles) 
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
MainMenu();
