%{
The following is a start up script with configures a variety of settings
and file paths to make sure all of the codebase features work correctly.
%}

clc
close all

%% Add files to search path

%Get the current project 
try
    prj = currentProject;
catch
    error("Incorrect procedure. Open the project first and then run the startup script.")
end

%Get all relevant paths to the project
root_path = prj.RootFolder;
src_path = fullfile(root_path,'src');
temp_path = fullfile(src_path,'temp');
inits_path = fullfile(src_path,'inits');
user_data_path = temp_path;
startup_path = fullfile(root_path,'project_startup');%add all necessary paths to the project path so it can see them
addpath(root_path);
addpath(startup_path);
addpath(closedown_path);
closedown_path = fullfile(root_path,'project_closedown');
cache_path = fullfile(root_path,'codegen','slprj_and_caches');
asv_path = fullfile(root_path,'codegen','autosaves');
test_path = fullfile(root_path,'src/tests/');