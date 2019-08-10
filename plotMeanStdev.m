% plotMeanStdev - Plot the mean and standard deviation for one condition or
% a set of different conditions
%
% Usage: 
%   settings = additionalUserInput(settings)
%
% Arguments:
%   data_vals       - Data to plot the mean and standard deviation of 
%                       Class Support: Nx1 (or 1xN) real numerical  
%
%   plot_info       - (OPTIONAL) Structural array containing plot settings
%                       Class Support: STRUCT
%       plot_info.colors
% 
%       plot_info.marks
%       plot_info.xtick
%       plot_info.xticklabel
%       plot_info.fontsize 
%       
%   data_labels     - (OPTIONAL) Numerical labels for data that will be 
%                       plotted along the x-axis. 
%                       Class Support: Nx1 (or 1xN) real numerical  
% Returns:
%   settings - zlineDetection parameters appended with additional 
%               parameters 
%               Class Support: STRUCT
%
% Dependencies: 
%   MATLAB Version >= 9.5 
%
% Tessa Morris
% Advisor: Anna Grosberg, Department of Biomedical Engineering 
% Cardiovascular Modeling Laboratory 
% University of California, Irvine 

function [] = plotMeanStdev( data_vals, plot_settings, data_labels )

% If plot info is not provided create an empty struct 
if nargin == 1
    plot_settings = struct(); 
end 

% If the data labels are not provided create an array of all ones the same
% size as data_vals
if nargin < 3
    data_labels = ones(size(data_vals)); 
end 

% Get the number of unique sorting data 
sort_unique = unique(data_labels); 

%Number of unique_data 
n = length(sort_unique); 

% Store the average and standard devation 
cond_des = zeros(n,1); 
avg_val = zeros(n,1); 
stdev_val = zeros(n,2); 

% Set the x-limits 
plot_settings.xmin = 0;
plot_settings.xmax = n+1; 

% Get the x axis 
x = 1:n; 

% Set the x-ticks to only be where there is data
plot_settings.xtick = x; 

% Check the plot settings
plot_settings = defaultPlotSettings( plot_settings ); 

% Start counting variables for all of the colors and markers  
lt = 0; % Line type
lc = 0; % Line color 
mc = 0; % Marker fill color
me = 0; % Marker edge color
m = 0;  % Marker style 

% Open a figure and hold on
figure; 
hold on; 

% Loop through all of the unique values, calculate the meean, standard
% deviations
for k = 1:n
    % Save the current unique value 
    cond_des(k,1) = sort_unique(k); 
    
    % Store the temporary data
    temp_data = data_vals(:); 
    temp_data(data_labels ~= sort_unique(k)) = []; 
    % Calculate the mean and standard deviation 
    avg_val(k,1) = mean(temp_data); 
    temp_std = std(temp_data); 
    % Get the bounds of the standard deviation 
    stdev_val(k,1) = avg_val(k,1) - temp_std; 
    stdev_val(k,2) = avg_val(k,1) + temp_std;
    
    %Get the minimum and max values 
    min_val = stdev_val(k,1);
    max_val = stdev_val(k,2); 

    %Add top bar 
    min_x = x(k) - plot_settings.sp; 
    max_x = x(k) + plot_settings.sp; 

    %Get matrices for plotting 
    x_vals = [min_x, max_x, x(k), x(k),...
        min_x, x(k), max_x]; 
    y_vals = [max_val, max_val, max_val, min_val, min_val, min_val,...
        min_val]; 
    
    % Correct the color/marker indices tracker. 
    lc = correctUpperBound( lc + 1, length(plot_settings.linecolor), 1 ); 
    mc = correctUpperBound( mc + 1, ...
        length(plot_settings.markercolorfill), 1 ); 
    me = correctUpperBound( me + 1, ...
        length(plot_settings.markercoloredge), 1 ); 
    m = correctUpperBound( m + 1, length(plot_settings.marks), 1 ); 
    lt = correctUpperBound( lt + 1, length(plot_settings.linetype), 1 ); 
    
    % Plot the standard deviation bars  
    plot( x_vals, y_vals, plot_settings.linetype{lt}, 'color', ...
        plot_settings.linecolor{lc}, ...
        'LineWidth', plot_settings.linewidth );

    % Plot the mean 
    plot(x(k), avg_val(k,1), plot_settings.marks{m},...
        'MarkerEdgeColor', plot_settings.markercoloredge{me},...
        'MarkerFaceColor', plot_settings.markercolorfill{mc}); 
    
end

% Change the plot area
changePlotAppearance( plot_settings ); 

end
