%{
The following is a close down script which configures a variety of settings
and file paths to make sure all of the codebase features work correctly.
%}

clc
close all
clear

fprintf("Closing.\n")

try
    if(~exist("prj_path_list","var"))
        prj_path_list = getProjectPaths();
    end
    
    %clears src/temp directory
    warningState = warning('off','all');
    stashASVFiles();
    clearTemp();
    warning(warningState); 

catch exception
    fprintf("Failed to stash asv files and clear temp.");
end

fprintf("Goodbye.\n")