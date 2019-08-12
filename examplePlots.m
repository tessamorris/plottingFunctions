%% BAR PLOT EXAMPLES

% Create a bar plots
figure; 
y = 2; 
barPlot(y); 

% Create a bar plot with multiple points and different colors 
figure; 
y = [2,3,4]; 
plot_settings.colorfill = {'r','g','b'}; 
barPlot(y, [], plot_settings); 

% Create a bar plot with multiple points, different colors, and titles
figure; 
y = [2,3,4]; 
plot_settings.title = 'Bar Plot #3';
plot_settings.ylabel = 'Y-values'; 
plot_settings.xlabel = 'X-values'; 
plot_settings.colorfill = {'r','g','b'}; 
barPlot(y, [], plot_settings); 


% Create a bar plot with multiple points, different colors, and titles, and
% change the x-labels
figure; 
y = [2,3,4]; 
plot_settings.xticklabel = {'one','two','three'}; 
plot_settings.title = 'Bar Plot #4';
plot_settings.ylabel = 'Y-values'; 
plot_settings.xlabel = 'X-values'; 
plot_settings.colorfill = {'r','g','b'}; 
barPlot(y, [], plot_settings); 

% Create a bar plot with multiple points, different colors, and titles, and
% change the x-labels & rotation 
figure; 
y = [2,3,4]; 
plot_settings.xticklabel = {'one','two','three'}; 
plot_settings.xtickrotation = 90; 
plot_settings.title = 'Bar Plot #5';
plot_settings.ylabel = 'Y-values'; 
plot_settings.xlabel = 'X-values'; 
plot_settings.colorfill = {'r','g','b'}; 
barPlot(y, [], plot_settings); 

%% Mean and standard deviation of data in a bar plot 
figure; 
data_vals = [2,3,4]; 
barPlotMeanStdev(data_vals);
 
%% Mean as a point plus/minus standard deviation of data as bars 
figure; 
data_vals = [2,3,4]; 
plotMeanStdev(data_vals);

%% Plot points in dot plot
figure; 
clear plot_settings
plot_settings.title = 'Dot Plot 1'; 
data_vals = [1,2:0.1:3,4,6,20]; 
makeDotPlot(data_vals, plot_settings);

figure; 
clear plot_settings
plot_settings.title = 'Dot Plot 2'; 
data_vals = [1,2:0.1:3,4,6]; 
makeDotPlot(data_vals, plot_settings);

%% Plot bar plots and dot plots 
figure; 
data_vals = [1,2:0.1:3,4,6,20]; 
barPlotMeanStdev(data_vals);
hold on; 
plot_settings.colors = {'b'}; 
makeDotPlot(data_vals, plot_settings); 

clear plot_settings

%% Plot bar plots and dot plots with multiple data sets 
figure; 

% Get the first set and labels 
data_vals1 = [1,2:0.1:3,4,6,20]; 
labels1 = ones(size(data_vals1)); 
% Get the second set and labels 
data_vals2 = [1,2:0.1:3,4,6]; 
labels2 = 2*ones(size(data_vals2)); 
% Combine the data values and labels 
data_vals = [data_vals1, data_vals2]; 
data_labels = [labels1,labels2]; 


% Set the bar colors to be red and then blue 
plot_settings.colorfill = {'r','b'}; 
barPlotMeanStdev(data_vals, plot_settings, data_labels);
hold on; 
% Set the dot plot colors to be green
plot_settings.colors = {'g'}; 
makeDotPlot(data_vals, plot_settings, data_labels);

clear plot_settings