% plotMeanStdev - Plot the mean and standard deviation for one condition or
% a set of different conditions
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

%Find the minimum and maximum values 
min_value = min(data_vals(:)) - eps; 
max_value = max(data_vals(:)); 

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

% Get the bin size
bin_size = bins(2) - bins(1);

% Save the number of bins  
nb = plot_settings.num_bins; 

%Initialize arrays to store the approximate data value and the number of
%points in that position 
approx_values = zeros( nlabel, nb-1 ); 
counts = zeros( nlabel, nb-1 ); 

% Loop through all of the unique labels 
for k = 1:nlabel
    
    % Store the data with the current label
    current_data = data_vals(:); 
    current_data(data_labels ~= unique_labels(k)) = []; 

    % Loop through all of the bin values and store the number of points in
    % that bin 
    for b = 1:nb
        
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
x_shift = 1/max_c; 

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


% Loop through all of the unique labels 
for k = 1:nlabel
    
    %Initialize plotting x and y for the current label. 
    dtot = sum(counts(k,:)); 
    x = zeros(1,dtot); 
    y = zeros(1,dtot);     
    
    % Initialize the end positions 
    end_pos = 0; 
    
    %Get the data points to plot
    for b = 1:nb
        
        % If there is more than one count in the current bin, get the x
        % points 
        if counts(k,b) > 0 
            
        %Calculate the start and end positions 
        start_pos = end_pos + 1; 
        end_pos = start_pos - 1 + counts(1,b);

        %Get the current bin value 
        y(1,start_pos:end_pos) = approx_values(k,b)*ones(counts(k,b),1); 
       
        % Get the current x values
        x(1,start_pos:end_pos) = ...
            xavail(counts(k,b),1):x_shift:xavail(counts(k,b),2); 
        end 
        
        hold on; 
        %Plot data points 
        plot(x,y,'o','MarkerFaceColor', plotsettings.makerfill, ...
            'MarkerEdgeColor',plotsettings.markeredge ); 

    end 
end 


% %Adjust the x minimum and maximum values
% max_x = max(x(:)); 
% min_x = min(x(:)); 
% 
% %Plot mean & standard deviation or median + iqr depending on what is asked
% %plot settings.stats == 1 (median and interquartile range 
% if plotsettings.stats == 1
%     %Calculate the median and sort  the data
%     median_value = median(data_points(:)); 
%     sorted_data = sort(data_points(:)); 
%     %Compute 25th & 75th percentile 
%     q25 = median( sorted_data(sorted_data < median_value) );
%     q75 = median( sorted_data(sorted_data > median_value) );
%     iqr_value = iqr(data_points(:)); 
%     iqr_min = q25-1.5*iqr_value; 
%     iqr_max = q75+1.5*iqr_value; 
%     
%     %Create a box of the interquartile range 
%     fill([min_x, max_x, max_x, min_x], ...
%     [q25, q25, q75, q75],plotsettings.boxfill, 'FaceAlpha', ... 
%     plotsettings.transparency);    
%     %Plot the median 
%     plot([min_x,max_x], [median_value,median_value],'-', ...
%         'color',plotsettings.statcolor,'LineWidth',2); 
%     
%     %Get the min and max x positions for the plot (1/2 length) 
%     max_x = (x_pos + max_x) / 2; 
%     min_x = (x_pos + min_x) / 2; 
%     
%     %Plot min iqr      
%     plot([min_x, max_x, x_pos, x_pos], ...
%         [iqr_max, iqr_max, iqr_max, q75], ...
%         '-', ...
%         'color',plotsettings.statcolor,'LineWidth',1); 
%     %Plot min and max with iqr      
%     plot([x_pos, x_pos, max_x, min_x], ...
%         [q25, iqr_min, iqr_min, iqr_min], ...
%         '-', ...
%         'color',plotsettings.statcolor,'LineWidth',1); 
% end 


end

