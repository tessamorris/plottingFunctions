% makeDotPlot - plot the data points 
%
% Usage: 
%   data_vals = [1,2,3,4,1,2,4]; makeDotPlot( data_vals ); 
%
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
%
% Dependencies: 
%   MATLAB Version >= 9.5 
%   changePlotAppearance.m
%   correctUpperBound.m
%   defaultPlotSettings.m
%
% Tessa Altair Morris
% Advisor: Anna Grosberg, Department of Biomedical Engineering 
% Cardiovascular Modeling Laboratory 
% University of California, Irvine 

% function [] = makeDotPlot(data_points, bin_size, ...
%     x_pos, x_bnd, x_shift, plotsettings)
function [ bin_size ] = makeDotPlot( data_vals, plot_settings, data_labels )

% If plot info is not provided create an empty struct 
if nargin == 1
    plot_settings = struct(); 
end 

% If the data labels are not provided create an array of all ones the same
% size as data_vals
if nargin < 3
    data_labels = ones(size(data_vals)); 
end 

% Get the actual min and max values 
data_min = min(data_vals(:)); 
data_max = max(data_vals(:)); 

% Find the minimum bin value
notGreater = true; 
k = 0; 
while notGreater
    % Get the minimum value 
    min_value = data_min - k*eps;
    if data_min > min_value
        notGreater = false; 
    else
        k = k+1; 
    end 
end 

% Find the maximum bin value
notLess = true; 
k = 0; 
while notLess
    % Get the minimum value 
    max_value = data_max + k*eps; 
    if data_max < max_value
        notLess = false; 
    else
        k = k+1; 
    end 
end

% Get the number of unique sorting data 
unique_labels = unique(data_labels); 

%Number of unique data labels  
nlabel = length(unique_labels); 

% Set the x-limits 
plot_settings.xmin = 0;
plot_settings.xmax = nlabel+1; 

% Check the plot settings
plot_settings = defaultPlotSettings( plot_settings ); 

% Create the bins 
bins = linspace(min_value, max_value, plot_settings.num_bins); 
bins(1) = min_value; 
bins(end) = max_value; 

% Get the bin size
bin_size = bins(2) - bins(1);

% Save the number of bins  
nb = plot_settings.num_bins; 
%Initialize arrays to store the approximate data value and the number of
%points in that position 
approx_values = zeros( 1, nb-1 ); 
counts = zeros( nlabel, nb-1 ); 

% Loop through all of the unique labels 
for k = 1:nlabel
    
    % Store the data with the current label
    current_data = data_vals(:); 
    current_data(data_labels ~= unique_labels(k)) = []; 

    % Loop through all of the bin values and store the number of points in
    % that bin 
    for b = 1:(nb-1)
        
        % If this is the first iteration, store the average value of the
        % bin
        if k == 1 
            approx_values(1,b) = ( bins(b+1) + bins(b) ) / 2; 
        end 
    
        % Store the current data  
        current = current_data; 
        
        % Remove all points that are not in the current bin 
        current(current > bins(1,b+1) | current <= bins(1,b)) = []; 
        counts(k,b) = length(current);

    end 

end 

% Get the maximum count. 
max_c = max(counts(:)); 

% Calculate the shift between points 
x_shift = round(1/max_c,3); 

% Calculate ideal shift 
if nlabel > 3
    ideal_shift = 0.025*plot_settings.markersize; 
elseif nlabel == 3
    ideal_shift = 0.02*plot_settings.markersize; 
else
    ideal_shift = 0.01*plot_settings.markersize;     
end

% Set the shift to be whichever shift is smaller
x_shift = min([x_shift, ideal_shift]); 

% Initialize the matrix to store the x positions for each count 
xavail = ones(max_c,2); 

% Set the x position to be 1 
x_pos = 1; 

%Get the minimum and maximum x values for each count 
for k = 2:max_c
    % If there are two points, calculate their positions by adding and
    % subtracting half of the x_shift, otherwise add/subtract the x-shift
    % to the closest even/odd value 
    if k == 2
        xavail(k,1) = x_pos - x_shift/2; 
        xavail(k,2) = x_pos + x_shift/2; 
    else
        %Get the current mimum and maximum value 
        xavail(k,1) = xavail(k-2,1) - x_shift; 
        xavail(k,2) = xavail(k-2,2) + x_shift; 
    
    end 
end 

% Start counting variables for all of the colors and markers  
mc = 0; % Marker fill color
me = 0; % Marker edge color
m = 0;  % Marker style 

% Loop through all of the unique labels 
for k = 1:nlabel
    
    
    %Initialize plotting x and y for the current label. 
    dtot = sum(counts(k,:)); 
    x = zeros(1,dtot); 
    y = zeros(1,dtot);     

    % Initialize the end positions 
    end_pos = 0; 
    
    % Correct the color/marker indices tracker. 
    mc = correctUpperBound( mc + 1, ...
        length(plot_settings.markercolorfill), 1 ); 
    me = correctUpperBound( me + 1, ...
        length(plot_settings.markercoloredge), 1 ); 
    m = correctUpperBound( m + 1, length(plot_settings.marks), 1 ); 
    
    %Get the data points to plot
    for b = 1:(nb-1)
 
        % If there is more than one count in the current bin, get the x
        % points 
        if counts(k,b) > 0 
            
            %Calculate the start and end positions 
            start_pos = end_pos + 1; 
            end_pos = start_pos - 1 + counts(k,b);

            %Get the current bin value 
            y(1,start_pos:end_pos) = ...
                approx_values(1,b)*ones(counts(k,b),1); 
            
            % Get the current x values
            x(1,start_pos:end_pos) = ...
                ((k-1)+xavail(counts(k,b),1)):x_shift:...
                ((k-1)+xavail(counts(k,b),2)); 
        
        end 
       
    end 
    
    hold on; 
    plot(x,y, plot_settings.marks{m},...
        'MarkerSize', plot_settings.markersize,...
        'MarkerEdgeColor', plot_settings.markercoloredge{me},...
        'MarkerFaceColor', plot_settings.markercolorfill{mc});  
    clear x y 

end

% Change the plot area
changePlotAppearance( plot_settings ); 

end

