%% EXAMPLE 1: Simple bar that goes from 0 to y

% Open a figure 
figure; 
% Set y 
y = 2; 
% Call the bar plot function 
barPlot(y); 

%% EXAMPLE 2: Create a bar plot that will have three bars (0 to y1, 0 to
% y2, and 0 to y3)

% Open a figure 
figure; 
% Set y 
y = [2,3,4]; 
% Call the bar plot function 
barPlot( y ); 

%% EXAMPLE 3: Create a bar plot that will have three bars (0 to y1, 0 to
% y2, and 0 to y3) labeled 1,2,3 and change the colors of the bars to be
% red, green, and then blue 

% Open a figure 
figure; 
% Set y 
y = [2,3,4]; 
% Set the labels for y 
ylabels = [1,2,3]; 
% Set the bar colors to be red, then green, then blue 
plot_settings.colorfill = {'r','g','b'}; 
% Call the bar plot function 
barPlot(y, ylabels, plot_settings); 
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings

%% EXAMPLE 4: Create a bar plot that will have three bars (0 to y1, 0 to
% y2, and 0 to y3) labeled 1,2,3 and change the colors of the bars to be
% red, green, and then blue. Add a title and axis labels 

% Open a figure 
figure; 
% Set y 
y = [2,3,4]; 
% Set the labels for y 
ylabels = [1,2,3]; 
% Set the bar colors to be red, then green, then blue 
plot_settings.colorfill = {'r','g','b'}; 
% Change the title 
plot_settings.title = 'Bar Plot Ex #4';
% Change the y axis label 
plot_settings.ylabel = 'Y-values'; 
% Change the x axis label 
plot_settings.xlabel = 'X-values'; 
% Call the bar plot function 
barPlot(y, ylabels, plot_settings); 
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings

%% EXAMPLE 5: Create a bar plot that will have three bars (0 to y1, 0 to
% y2, and 0 to y3) labeled 1,2,3 and change the colors of the bars to be
% red, green, and then blue. Add a title and axis labels. Change the names
% of the x-axis ticks to one, two, three 

% Open a figure 
figure; 
% Set y 
y = [2,3,4]; 
% Set the labels for y 
ylabels = [1,2,3]; 
% Set the bar colors to be red, then green, then blue 
plot_settings.colorfill = {'r','g','b'}; 
% Change the title 
plot_settings.title = 'Bar Plot Ex #5';
% Change the y axis label 
plot_settings.ylabel = 'Y-values'; 
% Change the x axis label 
plot_settings.xlabel = 'X-values'; 
% Change the names of the x-ticks
plot_settings.xticklabel = {'one','two','three'}; 
% Call the bar plot function 
barPlot(y, ylabels, plot_settings); 
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings

%% EXAMPLE 6: Create a bar plot that will have three bars (0 to y1, 0 to
% y2, and 0 to y3) labeled 1,2,3 and change the colors of the bars to be
% red, green, and then blue. Add a title and axis labels. Change the names
% of the x-axis ticks to one, two, three and rotate the labels 90 degrees

% Open a figure 
figure; 
% Set y 
y = [2,3,4]; 
% Set the labels for y 
ylabels = [1,2,3]; 
% Set the bar colors to be red, then green, then blue 
plot_settings.colorfill = {'r','g','b'}; 
% Change the title 
plot_settings.title = 'Bar Plot Ex #6';
% Change the y axis label 
plot_settings.ylabel = 'Y-values'; 
% Change the x axis label 
plot_settings.xlabel = 'X-values'; 
% Change the names of the x-ticks
plot_settings.xticklabel = {'one','two','three'}; 
% Change the rotation to 90 degrees
plot_settings.xtickrotation = 90; 
% Call the bar plot function 
barPlot(y, ylabels, plot_settings); 
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings


%% EXAMPLE 7: Mean and standard deviation of data in a bar plot for one 
% set of data 

% Open a figure 
figure; 
% Provide raw data
data_vals = [1,2:0.1:3,4,6,20]; 
% Change the title 
plot_settings.title = 'Bar Plot of Mean and Standard Deviation';
% Plot the mean and standard deviation 
barPlotMeanStdev(data_vals, plot_settings);
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings
 
%% EXAMPLE 8: Mean as a point plus/minus standard deviation of data as bars 
% for one set of data 

% Open a figure 
figure; 
% Provide raw data
data_vals = [1,2:0.1:3,4,6,20]; 
% Change the title 
plot_settings.title = 'Plot of Mean and Standard Deviation';
% Plot the mean and standard deviation 
plotMeanStdev(data_vals, plot_settings);
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings

%% EXAMPLE 9: Classic box plot i.e. median as a line and the box indicates  
% theinterquartile range 

% Open a figure 
figure; 
% Provide raw data
data_vals = [1,2:0.1:3,4,6,20]; 
% Change the title 
plot_settings.title = 'Median and IQR';
% Plot the mean and standard deviation 
boxPlot( data_vals, plot_settings ); 
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings

%% EXAMPLE 10: Mean as a line and standard deviation as a shaded box 

% Open a figure 
figure; 
% Provide raw data
data_vals = [1,2:0.1:3,4,6,20]; 
% Change the title 
plot_settings.title = 'Mean and Shaded Standard Deviation';
% Set the type of box plot equal to mean
plot_settings.typeMean = true; 
% Plot the mean and standard deviation 
boxPlot( data_vals, plot_settings ); 
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings


%% EXAMPLE 11: Plot points in dot plot for one set of data 

% Open a figure 
figure; 
% Provide raw data
data_vals = [1,2:0.1:3,4,6,20]; 
% Change the title 
plot_settings.title = 'Dot plot';
% Plot the mean and standard deviation 
makeDotPlot(data_vals, plot_settings);
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings


%% EXAMPLE 12: Plot points in dot plot for one set of data on top of the
% bar plot of mean and median

% Open a figure 
figure; 
% Provide raw data
data_vals = [1,2:0.1:3,4,6,20]; 
% Change the title 
plot_settings.title = 'Dot plot on Bar Plot';
% Call the bar plot function 
barPlotMeanStdev(data_vals);
% Make sure to hold on so it will plot on the same plot  
hold on; 
% Set the color of the dots to be blue 
plot_settings.colors = {'b'}; 
% Plot the mean and standard deviation 
makeDotPlot(data_vals, plot_settings);
% Clear the plot_settings so that the settings do not carry over into the
% next exmple
clear plot_settings

%% EXAMPLE 13: Plot bar plots and dot plots with multiple data sets 

% Open a figure 
figure; 
% Create the first set of data and its labels 
data_vals1 = [1,2:0.1:3,4,6,20]; 
labels1 = ones(size(data_vals1)); 
% Create the second set of data and its labels 
data_vals2 = [3,4:0.2:6,7,9]; 
labels2 = 2*ones(size(data_vals2)); 
% Combine the data values and labels 
data_vals = [data_vals1, data_vals2]; 
data_labels = [labels1,labels2]; 
% Set the bar colors to be red and then blue 
plot_settings.colorfill = {'r','b'}; 
% Change the title 
plot_settings.title = 'Dot plot on Bar Plot';
% Create the bar plot
barPlotMeanStdev(data_vals, plot_settings, data_labels);
% Make sure to hold on so it will plot on the same plot  
hold on; 
% Set the dot plot colors to be red and then blue
plot_settings.colors = {'b','r'}; 
makeDotPlot(data_vals, plot_settings, data_labels);

clear plot_settings

%% EXAMPLE 14: Plot mean as a line and shaded standard deviation with 
% dot plots with multiple data sets 

% Open a figure 
figure; 
% Create the first set of data and its labels 
data_vals1 = [1,2:0.1:3,4,6,20]; 
labels1 = ones(size(data_vals1)); 
% Create the second set of data and its labels 
data_vals2 = [3,4:0.2:6,7,9]; 
labels2 = 2*ones(size(data_vals2)); 
% Combine the data values and labels 
data_vals = [data_vals1, data_vals2]; 
data_labels = [labels1,labels2]; 
% Set the bar colors to be red and then blue 
plot_settings.colorfill = {'r','b'}; 
% Set the type of box plot equal to mean
plot_settings.typeMean = true; 
% Change the title 
plot_settings.title = 'Dot plot on Mean+/- Std.Dev';
% Plot the mean and standard deviation 
boxPlot( data_vals, plot_settings, data_labels ); 
% Make sure to hold on so it will plot on the same plot  
hold on; 
% Set the dot plot colors to be red and then blue
plot_settings.colors = {'b','r'}; 
makeDotPlot(data_vals, plot_settings, data_labels);

clear plot_settings

%% EXAMPLE 15: Plot mean as a line and shaded standard deviation with 
% dot plots with multiple data sets adjusting the thickness of the mean
% line 

% Open a figure 
figure; 
% Create the first set of data and its labels 
data_vals1 = [1,2:0.1:3,4,6,20]; 
labels1 = ones(size(data_vals1)); 
% Create the second set of data and its labels 
data_vals2 = [3,4:0.2:6,7,9]; 
labels2 = 2*ones(size(data_vals2)); 
% Combine the data values and labels 
data_vals = [data_vals1, data_vals2]; 
data_labels = [labels1,labels2]; 
% Set the bar colors to be red and then blue 
plot_settings.colorfill = {'r','b'}; 
% Set the type of box plot equal to mean
plot_settings.typeMean = true; 
% Set the color of the mean lines to be the same as the shaded regions
plot_settings.linecolor = {'r','b'}; 
% Set the thickness of the mean line 
plot_settings.linewidth = 3; 
% Change the title 
plot_settings.title = 'Dot plot on Mean+/- Std.Dev';
% Plot the mean and standard deviation 
boxPlot( data_vals, plot_settings, data_labels ); 
% Make sure to hold on so it will plot on the same plot  
hold on; 
% Set the dot plot colors to be red and then blue
plot_settings.colors = {'b','r'}; 
makeDotPlot(data_vals, plot_settings, data_labels);

clear plot_settings

%% Violin plot 