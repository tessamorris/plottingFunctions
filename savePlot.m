% savePlot - Save a plot figure create in matlab as a specificied type.
%
% Usage: 
%
%   savePlot( save_path, save_name, save_extension); 
%
% Arguments:
%   save_path       - Path where image should be saved. This will depend on
%                       the operating system (See examples below)
%                       (Windows: 'C:\Users\You\Documents')
%                       (Mac Example - 'You/Documents/')
%                       Class Support: string
%   save_name       - Name of file without extension 
%                       Class Support: string
%   save_extension  - Extension of image ('.pdf','.tif','.jpeg'); 
%                       Default is '.pdf'
%                       Class Support: string
%
% Dependencies: 
%   MATLAB Version >= 9.5 
%
% Tessa Morris
% Advisor: Anna Grosberg, Department of Biomedical Engineering 
% Cardiovascular Modeling Laboratory 
% University of California, Irvine 

function [] = savePlot( save_path, save_name, save_extension)

% If the extension is not provided, save as pdf
if nargin < 3
    save_extension = '.pdf'; 
end 

% Add the directory "fileHelpers" to the current path in order to append
% the filename if it exists
addpath(fullfile(pwd,'fileHelpers')); 

% Determine if the save name contains the extension 
hasExtension = contains( save_name, save_extension ); 
% Get the filename with extension 
if ~hasExtension
    save_name = strcat(save_name,save_extension); 
end 

% Use appendFilename to add an underscore and number if the file already
% exists
save_name = appendFilename( save_path, save_name );

%Save image
saveas(gcf, fullfile(save_path, save_name) ); 

end

