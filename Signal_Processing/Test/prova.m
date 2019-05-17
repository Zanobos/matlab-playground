function varargout = prova(varargin)
% PROVA MATLAB code for prova.fig
%      PROVA, by itself, creates a new PROVA or raises the existing
%      singleton*.
%
%      H = PROVA returns the handle to a new PROVA or the handle to
%      the existing singleton*.
%
%      PROVA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROVA.M with the given input arguments.
%
%      PROVA('Property','Value',...) creates a new PROVA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prova_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prova_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prova

% Last Modified by GUIDE v2.5 22-Oct-2015 18:44:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prova_OpeningFcn, ...
                   'gui_OutputFcn',  @prova_OutputFcn, ...
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


% --- Executes just before prova is made visible.
function prova_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prova (see VARARGIN)

% Choose default command line output for prova
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prova wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prova_OutputFcn(hObject, eventdata, handles) 
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
a = rand(1)*10
%to command window