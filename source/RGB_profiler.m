function varargout = RGB_profiler(varargin)
% RGB_PROFILER MATLAB code for RGB_profiler.fig
%      RGB_PROFILER, by itself, creates a new RGB_PROFILER or raises the existing
%      singleton*.
%
%      H = RGB_PROFILER returns the handle to a new RGB_PROFILER or the handle to
%      the existing singleton*.
%
%      RGB_PROFILER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGB_PROFILER.M with the given input arguments.
%
%      RGB_PROFILER('Property','Value',...) creates a new RGB_PROFILER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RGB_profiler_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RGB_profiler_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RGB_profiler

% Last Modified by GUIDE v2.5 17-Dec-2017 22:17:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RGB_profiler_OpeningFcn, ...
                   'gui_OutputFcn',  @RGB_profiler_OutputFcn, ...
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


% --- Executes just before RGB_profiler is made visible.
function RGB_profiler_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RGB_profiler (see VARARGIN)

% Choose default command line output for RGB_profiler
handles.output = hObject;

movegui('center')

set(handles.axes1,'Visible','off');
set(handles.axes2,'Visible','off');
set(handles.axes3,'Visible','off');
set(handles.current,'Enable','off');
set(handles.reset,'Enable','off');
set(handles.calib_value,'Enable','off');
set(handles.selection,'Enable','off');
set(handles.line_width,'Enable','off');
set(handles.erase_line,'Enable','off');
set(handles.save_image_eps,'Enable','off');
set(handles.save_image_tiff,'Enable','off');
set(handles.save_data_csv,'Enable','off');
set(handles.save_graph_eps,'Enable','off');
handles.Xaxis='empty';
handles.pixel_size_value=1;
handles.line_width_value=1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RGB_profiler wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RGB_profiler_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Browse the files from user
[file, path]=uigetfile({'*.tif';'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File');
image=[path file];
handles.file=image;
if (file==0)
    warndlg('You did not selected any compatible file') ; % no file selected
end
[fpath, fname, fext]=fileparts(file);
validex=({'.tif';'.jpg';'.bmp';'.jpeg';'.png'});
found=0;
for x=1:length(validex)
    if strcmpi(fext,validex{x})
        found=1;
        set(handles.axes3,'Visible','on');
        set(handles.current,'Enable','on');
        set(handles.reset,'Enable','on');
        set(handles.calib_value,'Enable','on');
        set(handles.selection,'Enable','on');
        set(handles.line_width,'Enable','on');
        set(handles.save_image_eps,'Enable','on');
        set(handles.save_image_tiff,'Enable','on');

        handles.img=imread(image);
        handles.i=imread(image);
        axes(handles.axes3); cla; imshow(handles.img);
        set(handles.current,'String',file);
        guidata(hObject,handles);
        
        break
        
    end
end
if found==0
    errordlg('Selected file does not match available extensions. Please select file from available extensions [ .jpg, .jpeg, .bmp, .png, .tif, .tiff] ','Image Format Error');
end

% Display image in current axes.

set(handles.axes1,'Visible','on');
set(handles.axes2,'Visible','on');

         
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1); cla; set(handles.axes1,'Visible','off');
axes(handles.axes2); cla; set(handles.axes2,'Visible','off');
axes(handles.axes3); cla; set(handles.axes3,'Visible','off');
delete(findall(findall(gcf,'Type','axe'),'Type','text')); % Otherwise the axis titles stay...

set(handles.current,'String','');
set(handles.current,'Enable','off');
set(handles.calib_value,'Enable','off');
set(handles.selection,'Enable','off');
set(handles.line_width,'Enable','off');
set(handles.save_image_eps,'Enable','off');
set(handles.save_image_tiff,'Enable','off');
set(handles.erase_line,'Enable','off');
set(handles.save_graph_eps,'Enable','off');
set(handles.save_data_csv,'Enable','off');


guidata(hObject,handles);


function current_Callback(hObject, eventdata, handles)
% hObject    handle to current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of current as text
%        str2double(get(hObject,'String')) returns contents of current as a double


% --- Executes during object creation, after setting all properties.
function current_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function calib_value_Callback(hObject, eventdata, handles)
% hObject    handle to calib_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of calib_value as text
%        str2double(get(hObject,'String')) returns contents of calib_value as a double
handles.pixel_size_value = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function calib_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calib_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selection.
function selection_Callback(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[user_coord_x, user_coord_y] = getpts;
[cx,cy,complete_array,~,~] = improfile(handles.img, user_coord_x, user_coord_y);
complete_array = squeeze(complete_array); % Remove singleton dimensions
line_length=size(cx,1); % Compute the number of pixel values measured (=~ distance)

max_red = max(max(complete_array(:,1)));
min_red = min(min(complete_array(:,1)));
normalised_complete_array(:,1) = (complete_array(:,1) - min_red)/(max_red - min_red);

max_green = max(max(complete_array(:,2)));
min_green = min(min(complete_array(:,2)));
normalised_complete_array(:,2) = (complete_array(:,2) - min_green)/(max_green - min_green);

max_blue = max(max(complete_array(:,3)));
min_blue = min(min(complete_array(:,3)));
normalised_complete_array(:,3) = (complete_array(:,3) - min_blue)/(max_blue - min_blue);

hold on;
    axes(handles.axes3); cla; imshow(handles.img);
    plot(handles.axes3, user_coord_x, user_coord_y, 'k+-', 'LineWidth', 1.5, 'MarkerEdgeColor', 'b', 'MarkerSize', 10);
    text(handles.axes3, user_coord_x(1)+2, user_coord_y(1), 'Beginning', 'FontSize', 12, 'Color', 'w');
    text(handles.axes3, user_coord_x(end)+2, user_coord_y(end), 'End', 'FontSize', 12, 'Color', 'w');
hold off

Xaxis_values = handles.pixel_size_value*(colon(0,line_length-1));

handles.Xaxis_values = Xaxis_values;
handles.normalised_dataset = normalised_complete_array;
handles.raw_dataset = complete_array;
handles.cx = cx;
handles.cy = cy;
handles.user_coord_x = user_coord_x;
handles.user_coord_y = user_coord_y;
handles.complete_array = complete_array;
handles.normalised_complete_array = normalised_complete_array;

axes(handles.axes1);
hold on
plot(Xaxis_values,complete_array(:,1), 'r-');
plot(Xaxis_values,complete_array(:,2), 'g-');
plot(Xaxis_values,complete_array(:,3), 'b-');
title('RGB profile','FontWeight','bold');
ylabel('Raw intensity');
if handles.pixel_size_value==1
    xlabel('Distance (px)');
else
    xlabel('Distance (\mum)');
end
box on; grid on;
hold off

axes(handles.axes2);
hold on
plot(Xaxis_values,normalised_complete_array(:,1), 'r-');
plot(Xaxis_values,normalised_complete_array(:,2), 'g-');
plot(Xaxis_values,normalised_complete_array(:,3), 'b-');
title('Normalised RGB profile','FontWeight','bold');
ylabel('Normalised intensity');
if handles.pixel_size_value==1
    xlabel('Distance (px)');
else
    xlabel('Distance (\mum)');
end
ylim([0 1]); box on; grid on;
hold off

set(handles.erase_line,'Enable','on');
set(handles.save_graph_eps,'Enable','on');
set(handles.save_data_csv,'Enable','on');

guidata(hObject, handles);


% --- Executes on button press in erase_line.
function erase_line_Callback(hObject, eventdata, handles)
% hObject    handle to erase_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla; %set(handles.axes1,'Visible','off');
axes(handles.axes2); cla; %set(handles.axes2,'Visible','off');
axes(handles.axes3); cla; imshow(handles.img);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in save_image_eps.
function save_image_eps_Callback(hObject, eventdata, handles)
% hObject    handle to save_image_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path]= uiputfile('*.eps','Save Image as');
h=figure;
imshow(handles.img);
hold on
    plot(handles.user_coord_x, handles.user_coord_y, 'k+-', 'LineWidth', 1.5, 'MarkerEdgeColor', 'b', 'MarkerSize', 10);
    text(handles.user_coord_x(1)+2, handles.user_coord_y(1), 'Beginning', 'FontSize', 12, 'Color', 'w');
    text(handles.user_coord_x(end)+2, handles.user_coord_y(end), 'End', 'FontSize', 12, 'Color', 'w');
hold off
set(h,'PaperPositionMode','auto');
save=[path file];
print(h,'-depsc','-loose',save);
close(h);


% --- Executes on button press in save_image_tiff.
function save_image_tiff_Callback(hObject, eventdata, handles)
% hObject    handle to save_image_tiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path]= uiputfile('*.tif','Save Image as');
save=[path file]; imwrite(handles.img,save,'tif');


% --- Executes on button press in save_graph_eps.
function save_graph_eps_Callback(hObject, eventdata, handles)
% hObject    handle to save_graph_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path]= uiputfile('*.eps','Save graph panels as');
h=figure;

Xaxis_values = handles.Xaxis_values;
normalised_complete_array = handles.normalised_dataset;
complete_array = handles.raw_dataset;

subplot(2,1,1);
hold on
plot(Xaxis_values,complete_array(:,1), 'r-');
plot(Xaxis_values,complete_array(:,2), 'g-');
plot(Xaxis_values,complete_array(:,3), 'b-');
title('RGB profile','FontWeight','bold');
ylabel('Raw intensity');
if handles.pixel_size_value==1
    xlabel('Distance (px)');
else
    xlabel('Distance (\mum)');
end
box on; grid on;
hold off

subplot(2,1,2);
hold on
plot(Xaxis_values,normalised_complete_array(:,1), 'r-');
plot(Xaxis_values,normalised_complete_array(:,2), 'g-');
plot(Xaxis_values,normalised_complete_array(:,3), 'b-');
title('Normalised RGB profile','FontWeight','bold');
ylabel('Normalised intensity');
if handles.pixel_size_value==1
    xlabel('Distance (px)');
else
    xlabel('Distance (\mum)');
end
ylim([0 1]); box on; grid on;
hold off

set(h,'PaperPositionMode','auto');
save=[path file];
print(h,'-depsc','-loose',save);
close(h);


% --- Executes on button press in save_data_csv.
function save_data_csv_Callback(hObject, eventdata, handles)
% hObject    handle to save_data_csv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pwd;
currentFolder = pwd;
full_array = horzcat(handles.Xaxis_values',handles.complete_array,handles.normalised_complete_array);
data_format_title = '%s,%s,%s,%s,%s,%s,%s,\r';
column_headers = cell(7,1);
column_headers{1} = 'Position';
column_headers{2} = 'Raw red channel';
column_headers{3} = 'Raw green channel';
column_headers{4} = 'Raw blue channel';
column_headers{5} = 'Normalised red channel';
column_headers{6} = 'Normalised green channel';
column_headers{7} = 'Normalised blue channel';
data_format_numbers = '%6.4f,%3.0f,%3.0f,%3.0f,%6.4f,%6.4f,%6.4f,\r';
[file,path]= uiputfile('*.csv','Save csv file as');
cd(path);
disp('file');
[ncolumns,~]= size(column_headers);
file_edited = fopen(file,'w');
for column=1:ncolumns
    fprintf(file_edited, data_format_title, column_headers{column,:});
end
fclose(file_edited);
clear ncolumns column file_edited
file_edited = fopen(file,'a');
fprintf(file_edited, '\r \n');
fclose(file_edited);
clear file_edited
file_edited = fopen(file,'a');
fprintf(file_edited, data_format_numbers, full_array');
fclose(file_edited);
clear row file_edited full_array
cd(currentFolder);


function line_width_Callback(hObject, eventdata, handles)
% hObject    handle to line_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of line_width as text
%        str2double(get(hObject,'String')) returns contents of line_width as a double


%handles.line_width_value = line_width_value;


% In progress
% Draft: get the coordinate of every point on the line back and then draw a
% perpendicular line with length = 2 X width indicated in this field,
% centered on the pixel crossing with the original line profile. Averaging
% the RGB values along this line and save it as the average value for the
% point on the line profile (possibly using improfile again. I'm assuming
% that I will use the coordinates of the points (from the clicks) selected
% by the user, fit a line using polyfit() and then compute the perpendicular
% using a fixed length.


% --- Executes during object creation, after setting all properties.
function line_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to line_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end