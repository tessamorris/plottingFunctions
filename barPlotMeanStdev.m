function [] = barPlotMeanStdev( data_vals, plot_settings, data_labels )
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

% Set the 
% Check the plot settings
plot_settings = defaultPlotSettings( plot_settings ); 

% Start counting variables for all of the colors and markers  
lt = 0; % Line type
lc = 0; % Line color 

% Open a figure and hold on
figure; 
hold on; 

% Loop through all of the unique labels, calculate the mean, standard
% deviations
for k = 1:n
    % Save the current unique value 
    cond_des(k,1) = unique_labels(k); 
    
    % Store the temporary data
    temp_data = data_vals(:); 
    temp_data(data_labels ~= unique_labels(k)) = []; 
    % Calculate the mean and standard deviation 
    avg_val(k,1) = mean(temp_data); 
    temp_std = std(temp_data); 
    % Get the bounds of the standard deviation 
    stdev_val(k,1) = avg_val(k,1) - temp_std; 
    stdev_val(k,2) = avg_val(k,1) + temp_std;
    
    %Get the maximum standard deviation 
    max_val = stdev_val(k,2); 

    %Get the x-values for the top bar
    min_x = x(k) - plot_settings.sp; 
    max_x = x(k) + plot_settings.sp; 

    %Get matrices for plotting 
    x_vals = [min_x, max_x, x(k), x(k)]; 
    y_vals = [max_val, max_val, max_val, avg_val(k,1)]; 
    
    % Correct the color tracker
    lc = correctUpperBound( lc + 1, length(plot_settings.linecolor), 1 ); 
    lt = correctUpperBound( lt + 1, length(plot_settings.linetype), 1 ); 
    
    % Plot the standard deviation bars  
    plot( x_vals, y_vals, plot_settings.linetype{lt}, 'color', ...
        plot_settings.linecolor{lc}, ...
        'LineWidth', plot_settings.linewidth );

    % Plot the bar plot 
    barPlot(avg_val(k,1), x(k), plot_settings, k); 
    
end

% Change the plot area
changePlotAppearance( plot_settings ); 


end

