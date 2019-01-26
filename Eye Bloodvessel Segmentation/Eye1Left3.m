function varargout = Eye1Left3(varargin)
% EYE1LEFT3 MATLAB code for Eye1Left3.fig
%      EYE1LEFT3, by itself, creates a new EYE1LEFT3 or raises the existing
%      singleton*.
%
%      H = EYE1LEFT3 returns the handle to a new EYE1LEFT3 or the handle to
%      the existing singleton*.
%
%      EYE1LEFT3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EYE1LEFT3.M with the given input arguments.
%
%      EYE1LEFT3('Property','Value',...) creates a new EYE1LEFT3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Eye1Left3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Eye1Left3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Eye1Left3

% Last Modified by GUIDE v2.5 08-Jun-2018 23:57:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Eye1Left3_OpeningFcn, ...
                   'gui_OutputFcn',  @Eye1Left3_OutputFcn, ...
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


% --- Executes just before Eye1Left3 is made visible.
function Eye1Left3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Eye1Left3 (see VARARGIN)

% Choose default command line output for Eye1Left3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Eye1Left3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Read Image
global path;
path= varargin{1};
I = imread(path);
% Resize image for easier computation
B = imresize(I, [584 565]);
% Read image
im = im2double(B);
% Convert RGB to Gray via PCA
lab = rgb2lab(im);
f = 0;
wlab = reshape(bsxfun(@times,cat(3,1-f,f/2,f/2),lab),[],3);
[C,S] = pca(wlab);
S = reshape(S,size(lab));
S = S(:,:,1);
gray = (S-min(S(:)))./(max(S(:))-min(S(:)));
%% Contrast Enhancment of gray image using CLAHE
J = adapthisteq(gray,'numTiles',[8 8],'nBins',128);
%% Background Exclusion
% Apply Average Filter
h = fspecial('average', [9 9]);
JF = imfilter(J, h);
axes(handles.axes1);
% Take the difference between the gray image and Average Filter
Z = imsubtract(JF, J);
%% Threshold using the IsoData Method
level=isodata(Z); % this is our threshold level
%level = graythresh(Z)
%% Convert to Binary
BW = im2bw(Z, level-.008);
%% Remove small pixels
BW2 = bwareaopen(BW, 100);
%% Overlay
BW2 = imcomplement(BW2);
out = imoverlay(B, BW2, [0 0 0]);
imshow(out);

picture1 = imread('Image3.png');
axes(handles.axes2);
imshow(picture1);



% --- Outputs from this function are returned to the command line.
function varargout = Eye1Left3_OutputFcn(hObject, eventdata, handles) 
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
