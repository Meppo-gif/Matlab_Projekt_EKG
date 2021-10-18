function varargout = EKG_GUI_KP(varargin)
% EKG_GUI_KP MATLAB code for EKG_GUI_KP.fig
%      EKG_GUI_KP, by itself, creates a new EKG_GUI_KP or raises the existing
%      singleton*.
%
%      H = EKG_GUI_KP returns the handle to a new EKG_GUI_KP or the handle to
%      the existing singleton*.
%
%      EKG_GUI_KP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EKG_GUI_KP.M with the given input arguments.
%
%      EKG_GUI_KP('Property','Value',...) creates a new EKG_GUI_KP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EKG_GUI_KP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EKG_GUI_KP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help EKG_GUI_KP
 
% Last Modified by GUIDE v2.5 12-Apr-2018 14:34:05
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EKG_GUI_KP_OpeningFcn, ...
                   'gui_OutputFcn',  @EKG_GUI_KP_OutputFcn, ...
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
 
 
end
 
% --- Executes just before EKG_GUI_KP is made visible.
function EKG_GUI_KP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EKG_GUI_KP (see VARARGIN)
 
% Choose default command line output for EKG_GUI_KP
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes EKG_GUI_KP wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
 
end
 
% --- Outputs from this function are returned to the command line.
function varargout = EKG_GUI_KP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
 
end
 
% --- Executes on button press in loadData.
function loadData_Callback(hObject, eventdata, handles)
% hObject    handle to loadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global ekg; global I; global II;global III, global aVL; global aVR;global aVF;

 % EINLESEN DER DATEN HIER IN DIESER FUNKTION!!!
 
 % Auslesen der EKG-Daten(ekg.csv) aus dem CSV-Datenformat
  ekg = csvread('ekg.csv');
  %Informationen zu den Files, in welchen Spalten sich die Daten Einthoven I und III befinden:
  %ekg.csv - Spalten 10 und 11
  % Für die Daten Einthoven I habe ich die Spalte 10 genommen
  % Für die Daten Einthoven III habe ich die Spalte 11 genommen
  
  % Weil wir nur einen Ausschnitt betrachten wollen (Messwerte von 2. bis
  % 10. Sekunde sinnvoll), habe ich nur einige Werte genommen
  
I = ekg(1000:5000,10);
III = ekg(1000:5000,11);

  % 1000 = (15000*2)/30 
  % 5000 = (15000*2)/30

II = I + III;

aVR = -(I + II)/2;
aVL = (I - III)/2;
aVF = (II + III)/2
 
end
 
% --- Executes on button press in showData.
function showData_Callback(hObject, eventdata, handles)
% hObject    handle to showData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global ROHDATEN1;global ROHDATEN2; global ROHDATEN3;
 global ROHDATEN4;
 global ROHDATEN5;global ROHDATEN6; global I; global II;global III; global aVL; global aVR;global aVF;

 % ANZEIGEN DER ROHDATEN HIER IN DIESER FUNKTION!!!
 axes(handles.axes1)
 ROHDATEN1 = I;
 plot(ROHDATEN1)
 title('EinthovenI')
 xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
 axes(handles.axes3)
 ROHDATEN2 = II;
 plot(ROHDATEN2)
 title('EinthovenII')
 xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
 axes(handles.axes5)
 ROHDATEN3 = III;
 plot(ROHDATEN3)
 title('EinthovenIII')
 xlabel('Zeit in s'); ylabel('Amplitude in mV');

 axes(handles.axes2)
 %ROHDATEN4 = aVR;
 plot(aVR)
 title('avR')
 xlabel('Zeit in s'); ylabel('Amplitude in mV');

 axes(handles.axes4)
 ROHDATEN5 = aVL;
 plot(ROHDATEN5)
 title('aVL')
 xlabel('Zeit in s'); ylabel('Amplitude in mV');

 axes(handles.axes6)
 ROHDATEN6 = aVF;
 plot(ROHDATEN6)
 title('aVF')
 xlabel('Zeit in s'); ylabel('Amplitude in mV');

end
 
% --- Executes on button press in filtData.
function filtData_Callback(hObject, eventdata, handles)
% hObject    handle to filtData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% FILTERN UND ANZEIGE DER DATEN HIER IN DIESER FUNKTION!!!
global ROHDATEN1;global ROHDATEN2; global ROHDATEN3;global ROHDATEN4;
global ROHDATEN5;global ROHDATEN6;
global F_DATEN1;global F_DATEN2; global F_DATEN3;global F_DATEN4;
global F_DATEN5;global F_DATEN6;
%Filtermaske h
filterlaenge = 15;
h = ones(1,filterlaenge)/filterlaenge;
 
axes(handles.axes1)
F_DATEN1 = conv(ROHDATEN1,h);
plot(F_DATEN1)
title('EinthovenI')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes3)
F_DATEN2 = conv(ROHDATEN2,h);
plot(F_DATEN2)
title('EinthovenII')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes5)
F_DATEN3 = conv(ROHDATEN3,h);
plot(F_DATEN3)
title('EinthovenIII')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes2)
F_DATEN4 = conv(ROHDATEN4,h);
plot(F_DATEN4)
title('aVR')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes4)
F_DATEN5 = conv(ROHDATEN5,h);
plot(F_DATEN5)
title('aVL')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes6)
F_DATEN6 = conv(ROHDATEN6,h);
plot(F_DATEN6)
title('aVF')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
end
 
% --- Executes on button press in dedriftData.
function dedriftData_Callback(hObject, eventdata, handles)
% hObject    handle to dedriftData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% ENTDRIFTEN (Nulllinienfilter) UND ANZEIGE DER DATEN HIER IN DIESER FUNKTION!!!
 global F_DATEN1;global F_DATEN2; global F_DATEN3;global F_DATEN4;
global F_DATEN5;global F_DATEN6;

axes(handles.axes1)
g1_oD = nulllinienfilters(F_DATEN1);
plot(g1_oD)
title('EinthovenI')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes3)
g2_oD = nulllinienfilters(F_DATEN2);
plot(g2_oD)
title('EinthovenII')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes5)
g3_oD = nulllinienfilters(F_DATEN3);
plot(g3_oD)
title('EinthovenIII')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes2)
g4_oD = nulllinienfilters(F_DATEN4);
plot(g4_oD)
title('aVR')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes4)
g5_oD = nulllinienfilters(F_DATEN5);
plot(g5_oD)
title('aVL')
xlabel('Zeit in s'); ylabel('Amplitude in mV');
 
axes(handles.axes6)
g6_oD = nulllinienfilters(F_DATEN6);
plot(g6_oD)
title('aVF')
xlabel('Zeit in s'); ylabel('Amplitude in mV');

end

