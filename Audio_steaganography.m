function varargout = Audio_steaganography(varargin)
% AUDIO_STEAGANOGRAPHY M-file for Audio_steaganography.fig
%      AUDIO_STEAGANOGRAPHY, by itself, creates a new AUDIO_STEAGANOGRAPHY or raises the existing
%      singleton*.
%
%      H = AUDIO_STEAGANOGRAPHY returns the handle to a new AUDIO_STEAGANOGRAPHY or the handle to
%      the existing singleton*.
%
%      AUDIO_STEAGANOGRAPHY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIO_STEAGANOGRAPHY.M with the given input arguments.
%
%      AUDIO_STEAGANOGRAPHY('Property','Value',...) creates a new AUDIO_STEAGANOGRAPHY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Audio_steaganography_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Audio_steaganography_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Audio_steaganography_OpeningFcn, ...
                   'gui_OutputFcn',  @Audio_steaganography_OutputFcn, ...
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


% --- Executes just before Audio_steaganography is made visible.
function Audio_steaganography_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Audio_steaganography (see VARARGIN)

% Choose default command line output for Audio_steaganography
handles.output = hObject;

a=ones(300,512);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Audio_steaganography wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Audio_steaganography_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in playaudio.
function playaudio_Callback(hObject, eventdata, handles)
% hObject    handle to playaudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


a=handles.a;
sound(a,44100);


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


exit;


% --- Executes on button press in inputaudio.
function inputaudio_Callback(hObject, eventdata, handles)
% hObject    handle to inputaudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.wav', 'Pick an audio');
if isequal(filename,0) || isequal(pathname,0) %checks if file is selected or not
    warndlg('Audio is not selected');   % warning dialogue box
else                                      % executes if the file is selected
    a=audioread(filename);
    axes(handles.axes1);                   % plots on axes-1 of gui
    plot(a);
%     disp(a);
    handles.filename=filename;  % handles are used to transfer the data of gui objects between callbacks of different buttons
    handles.a=a;
    guidata(hObject, handles);  % saving the changes made
    helpdlg('Input audio is Selected'); % Dialogue box
end



% --- Executes on button press in input text.
function secretdata_Callback(hObject, eventdata, handles)
% hObject    handle to secretdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.txt', 'Pick any txt file'); % select a .txt file
if isequal(filename,0) || isequal(pathname,0) % checks if file is selected or not
	warndlg('text file is not selected');  % warning dialogue box
else  % executes if file is selected
    fid = fopen(filename,'r'); % opens file in read mode
	F = fread(fid);  % reads the data in binary format
	s = char(F');  % conversion from binary to character array
	fclose(fid);  % close the file
end   % pasing the contents and preserve the changes
handles.s=s;
handles.F=F;
guidata(hObject, handles);
helpdlg('Text File is Selected'); % dialogue box


% --- Executes on button press in embedding.
function embedding_Callback(hObject, eventdata, handles)     
% hObject    handle to embedding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;  % input audio
s=handles.s;  % text file
F=handles.F;  % text file in binary
Q_SIZE = 3;
c=round(a*(10^Q_SIZE)); %scaled by a factor of 1000 and rounded to the nearest decimal 
i=1;
ii=51; % for wav file first 50 are header
while i <=length(s)
	if c(ii,1)<0  % check if sample is less than 0
        sbit1 = -1; % finding value of sbit
    else
        sbit1 =  1; % finding value of sbit
	end
    iii = ii+2;   % considering alternate samples and repeating the same procedure
	if c(iii,1)<0
        sbit2 = -1;
    else
        sbit2 =  1;
	end
	c(ii,1) = abs(c(ii,1)); % converting samples to absolute values
	c(iii,1) = abs(c(iii,1)); % converting samples to absolute values
	[c(ii,1),c(iii,1)]=Enc_Char(c(ii,1),c(iii,1),F(i)); % calling the encoding function with the input samples
	c(ii,1) = sbit1*c(ii,1); % multiplying samples with sbit values computed before
    c(iii,1) = sbit2*c(iii,1);  % multiplying samples with sbit values computed before
    i=i+1; % incrementing the variables
    ii = iii+2; % incrementing the variables
end
            n  = length(F);  % Input Text Length
			d=c/(10^Q_SIZE); %for  encoding it was multiplyed by 10^3, for plotting dividing by 10^3
            axes(handles.axes2); % plotting on axes2 of gui
            plot(d);
			audiowrite('Embedded.WAV',d,44100); %creates new file called embedded containing the stego audio with fs=44100
			helpdlg('Embedding process completed'); % dialogue box
 % 4bit password
pass=passkey; % calls passkey function
s2 = char(pass); % contains character array
ss = length(s2); % contains length
if  ss==4        % check if 4 bits or not
    helpdlg('Password Sucessesfully added'); 
else
    errordlg('Enter the Valid password');
end
num = dec2bin(s2,8); % converting from decimal to binary
disp(num);
% pass the handles and preserve the changes
handles.pass = num;
handles.d=d;
handles.n = n;
guidata(hObject, handles);


% --- Executes on button press in extraction.
function extraction_Callback(hObject, eventdata, handles)
% hObject    handle to extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=handles.n; % length of text file 
pass=handles.pass; % password
pass1=passkey; % password eneterd by user for extraction 
s2 = char(pass1);
ss = length(s2);
if  ss==4
    helpdlg('Password Sucessesfully added');
else
    errordlg('Enter the Valid password');
end
pass1 = dec2bin(s2,8); %conversion to binary
temp=0;
% checking if the passwords match
for i=1:4 % i=4 because password is 4 bits
    for j=1:8 % j=8 because 8bits in binary
        if pass(i,j)==pass1(i,j) % comparing
            temp=temp+1; % if same then increment
        else
            temp = 0;
        end
    end
end

if temp == 32
	% if temp=32 then password match because 8x4=32
else
    errordlg('Password missmached');
	exit;
end
 % read the stego audio and repeat the same steps                   
a=audioread('Embedded.wav');
Q_SIZE = 3;
c=round(a*(10^Q_SIZE));

i = 1;
TXT_LENGTH = n;
ii=51;
while i <= TXT_LENGTH
c(ii,1) = abs(c(ii,1));
iii = ii+2;
c(iii,1) = abs(c(iii,1));
s(i)=Dec_Char(c(ii,1),c(iii,1));
i = i+1;
ii = iii+2;
end
% writing the output of extraction function in output.txt
fid = fopen('output.txt','wb');
fwrite(fid,char(s'),'char');
fclose(fid);
helpdlg('Extraction process completed');



% --- Executes on button press in viewoutput.
function viewoutput_Callback(hObject, eventdata, handles)
% hObject    handle to viewoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


open 'output.txt'; % opens the output file


% --- Executes on button press in playaudio1.
function playaudio1_Callback(hObject, eventdata, handles)
% hObject    handle to playaudio1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

d = handles.d;
sound(d,44100);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','blue');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','blue');
end


% --- Executes on button press in validation.
function validation_Callback(hObject, eventdata, handles)
% hObject    handle to validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inpaud = handles.a; % input audio
embaud = handles.d; % stego audio

[Y,Z]=psnr(inpaud,embaud); %calls the psnr function
set(handles.edit1,'string',Y);
set(handles.edit2,'string',Z);
