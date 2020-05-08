% Arguments:
%   data_vals       - Data to plot the mean and standard deviation of 
%                       Class Support: Nx1 (or 1xN) real numerical  
%
%   plot_info       - (OPTIONAL) Structural array containing plot settings
%                       Class Support: STRUCT
%       
%   data_labels     - (OPTIONAL) Numerical labels for data that will be 
%                       plotted along the x-axis. 
%                       Class Support: Nx1 (or 1xN) real numerical  
% Returns:
%   avg_val         - Average value 
%                       Class Support: number of unique labels x 1 vector
%   stdev_val       - Average minus (:,1) or plus (:,2) the standard 
%                       devation
%                       Class Support: number of unique labels x 2 vector
%   cond_des        - Label associated with data (1 if no labels provided)

function [cond_des, main_output, secondary_output, type] = ...
    plotViolin(data_vals, plot_settings, data_labels)

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
unique_labels = unique(data_labels); 

%Number of unique_data 
n = length(unique_labels); 

% Set the x-limits 
plot_settings.xmin = 0;
plot_settings.xmax = n+1; 

% Get the x axis 
x = 1:n; 

% Set the x-ticks to only be where there is data
plot_settings.xtick = x; 

% If the type of plot was not provided set it to be a 
if ~isfield(plot_settings, 'typeMean')
    plot_settings.typeMean = false; 
end 

% Check the plot settings
plot_settings = defaultPlotSettings( plot_settings ); 

% Initialize array to store conditions 
cond_des = zeros(n,1); 

% Determine if the mean or median should be displayed
if plot_settings.typeMean 
    % Store the average and standard devation
    avg_val = zeros(n,1); 
    stdev_val = zeros(n,2); 
    type = 'Mean';
else
    % Store the average and standard devation
    median_val = zeros(n,1); 
    iqr_val = zeros(n,2); 
    type = 'Median';
end 


% Start counting variables for all of the colors and markers  
lt = 0;     % Line type for mean/median 
blc = 0;    % Line color for box 
lc = 0;     % Line color for mean/median 
cf = 0;     % Color fill for box 
bt = 0;     % Border type 
mc = 0; % Marker fill color
me = 0; % Marker edge color
m = 0;  % Marker style 

% Open a figure and hold on
hold on; 

% Loop through all of the unique labels, calculate the mean, standard
% deviations or the median and interquartile range 
for k = 1:n
    
    x0 = x(k); 
    % Save the current unique value 
    cond_des(k,1) = unique_labels(k); 
    
    % Store the temporary data
    temp_data = data_vals(:); 
    temp_data(data_labels ~= unique_labels(k)) = [];
    
    if plot_settings.typeMean 
        if k == 1
            disp('Plotting the Mean +/ StDev'); 
        end 
        
        % Calculate the mean and standard deviation 
        avg_val(k,1) = mean(temp_data); 
        temp_std = std(temp_data); 
        % Get the bounds of the standard deviation 
        stdev_val(k,1) = avg_val(k,1) - temp_std; 
        stdev_val(k,2) = avg_val(k,1) + temp_std;

        %Get the minimum and max values 
        min_val = stdev_val(k,1);
        max_val = stdev_val(k,2); 
        
        % Store the value 
        val = avg_val(k,1); 
    else
        if k == 1
            disp('Plotting the Median and IQR'); 
        end 
        
        % Calculate the median and interquartile range
        median_val(k,1) = median(temp_data); 
        
        % Sort the data 
        sorted_data = sort(temp_data); 
        %Compute 25th & 75th percentile 
        q25 = median( sorted_data(sorted_data < median_val(k,1)) );
        q75 = median( sorted_data(sorted_data > median_val(k,1)) );
        % Calculate the interquartile range 
        iqr_value = iqr( temp_data ); 
        % Get the values at the interquartile range 
        iqr_val(k,1) = q25-1.5*iqr_value; 
        iqr_val(k,2) = q75+1.5*iqr_value; 
    
        %Get the minimum and max values 
        min_val = iqr_val(k,1);
        max_val = iqr_val(k,2); 
        
        % Store the value 
        val = median_val(k,1); 
    end 
    
    % Correct the color/marker indices tracker. 
    blc = correctUpperBound( blc + 1, length(plot_settings.bordercolor), 1); 
    cf = correctUpperBound( cf + 1, length(plot_settings.colorfill), 1 ); 
    lt = correctUpperBound( lt + 1, length(plot_settings.linetype), 1 ); 
    lc = correctUpperBound( lc + 1, length(plot_settings.linecolor), 1);
    bt = correctUpperBound( bt + 1, length(plot_settings.bordertype), 1);
    % Correct the color/marker indices tracker. 
    mc = correctUpperBound( mc + 1, ...
        length(plot_settings.markercolorfill), 1 ); 
    me = correctUpperBound( me + 1, ...
        length(plot_settings.markercoloredge), 1 ); 
    m = correctUpperBound( m + 1, length(plot_settings.marks), 1 ); 
    
    % Hoffmann H, 2015: violin.m - Simple violin plot using matlab
    % default kernel density estimation. 
    % INRES (University of Bonn), Katzenburgweg 5, 53115 Germany.
    % hhoffmann@uni-bonn.de
    % Calculate the kernel density 
    [pf, u] = ksdensity(data_vals); 

    %Normal kernel density 
    pf = pf/max(pf)*0.3; 

    %Plot the violin fill 
    fill([pf'+x0;flipud(x0-pf')],[u';flipud(u')],  ...
        plot_settings.colorfill{cf}, ...
        'FaceAlpha', plot_settings.filltransparency,...
        'linestyle', plot_settings.bordertype{bt},...
        'EdgeColor', plot_settings.bordercolor{blc},...
        'LineWidth', plot_settings.borderwidth)

    %Plot the median  or mean 
    plot(x0,val, plot_settings.marks{m},...
        'MarkerSize', plot_settings.markersize,...
        'MarkerEdgeColor', plot_settings.markercoloredge{me},...
        'MarkerFaceColor', plot_settings.markercolorfill{mc});
    % Plot the IQR or the standard deviation 
    plot([x0, x0], [min_val, max_val],...
        plot_settings.linetype{lt}, ...
        'color',plot_settings.linecolor{lc},...
        'LineWidth', plot_settings.linewidth); 
    
end

% Change the plot area
changePlotAppearance( plot_settings ); 

if plot_settings.typeMean 
    % Store the average and standard devation
    main_output = avg_val; 
    secondary_output = stdev_val; 
else
    % Store the average and standard devation
    main_output = median_val; 
    secondary_output = iqr_val; 
end 
end 