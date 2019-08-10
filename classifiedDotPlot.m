function [] = classifiedDotPlot(data_points, bin_size, ...
    x_pos, x_bnd, x_shift, plotsettings, labels, unique_labels)

%Find the minimum and maximum values 
min_value = min(data_points(:)) - eps; 
max_value = max(data_points(:)) + eps; 

%Create the bins 
bins = min_value:bin_size:max_value; 
bins(end) = max_value; 
%Get the number of bins 
nb = length(bins)-1; 

data_points = data_points(:); 

%Sort the labels 
sorted_labels = zeros(1,length(data_points)); 
%Start a counter 
c = 1; 

%Initialize arrays to store the approximate data value and the number of
%points in that position 
approx_values = zeros(1,nb-1); 
counts = zeros(1,nb-1); 
for b = 1:nb
    %Get the approximate data value 
    approx_values(1,b) = ( bins(b+1) + bins(b) ) / 2; 
    %Get the number of data points in that bin 
    current_data = data_points(:); 
    %Get the labels of those data points
    current_labels = labels(:); 
    %Remove labels of data points not within that bin 
    current_labels(current_data > bins(1,b+1) | ...
        current_data <= bins(1,b)) = []; 
    %Remove data points not within that bin 
    current_data(current_data > bins(1,b+1) | ...
        current_data <= bins(1,b)) = []; 
    %Save the number of points 
    counts(1,b) = length(current_data);
    %Save the sorted labels
    sorted_labels(1,c:(c+counts(1,b)-1)) = current_labels; 
    c = c + counts(1,b); 
end 

%Get the maximum count. 
max_c = max(counts); 

%Make sure the x shift will be within the bounds
max_x = x_pos + x_bnd; 
min_x = x_pos - x_bnd; 

if mod(max_c,2) == 0
    xavailmax = x_pos + x_shift/2 + (max_c-2)/2*x_shift; 
else 
    xavailmax = x_pos + ceil(max_c/3)*x_shift; 
end 

while max_x < xavailmax
    
    x_shift = x_shift - 0.001; 
    if mod(max_c,2) == 0
        xavailmax = x_pos + x_shift/2 + (max_c-2)/2*x_shift; 
    else 
        xavailmax = x_pos + ceil(max_c/3)*x_shift; 
    end 

end 

xavail = zeros(max_c,2); 

%Get the x values (:,1) odd (:,2) even
for k = 1:max_c
    
    % Initialization for even cases 
    if k < 3
        x0_even = x_pos; 
        s_even = x_shift/2; 
    else
        x0_even = xavail(k-2,2); 
        s_even = x_shift; 
    end 
    %Initialize for odd case
    x0_odd = x_pos; 
    if k == 1
        s_odd = 0; 
    else
        %Get the values 
        s_odd = ceil(k/3)*x_shift; 
    end
   
    %Set the x_shift to be negative if k is even
    if mod(k,2) ~= 0
        s_even = -s_even; 
    else
        s_odd = -s_odd;
    end 
    
    %Get the current even x_value
    xavail(k,2) = x0_even + s_even; 
    xavail(k,1) = x0_odd + s_odd; 
end 

%Initialize plotting x and y 
dtot = sum(counts); 
x = zeros(1,dtot); 
y = zeros(1,dtot); 

%Initialize the end position 
end_pos = 0; 
%Get the data points to plot
for b = 1:nb
    %Reset the x/odd matrix
    t = 1; 
   
    if counts(1,b) > 0 
        %Calculate the start and end positions 
        start_pos = end_pos + 1; 
        end_pos = start_pos - 1 + counts(1,b);

        %Get the current y_values 
        y(1,start_pos:end_pos) = approx_values(1,b)*ones(counts(1,b),1); 
        if mod(counts(1,b),2) == 0
            t = 2; 
        end 
        x(1,start_pos:end_pos) =  xavail(1:counts(1,b),t); 
    end 
end  

%Hold on
hold on; 

%Save options for colors 
colors = {[0.1098,0.4588,0.7373],[0.3686,0.0314,...
    0.6471],[0.0745,0.9686,0.6863],...
    [0.8000,0.0392,0.3529],[0.0392,0.6706,0.8000],...
    [0.9569,0.6784,0.2588],[0.0235,0.6000,0.0588],...
    [0.6275,0.6275,0.6275],[1,0.6,1],[0.2789,0.4479,0.6535],...
    [0.9569,0.9059,0.3529],[0.0824,0.4000,0.9490],...
    [0.9882,0.2980,0.2353]};
markers = {'o','s','^','d','+','*'};


%unique_labels = unique(sorted_labels); 
%Plot the labeled data 
for u = 1:length(unique_labels)   
    currentx = x; 
    currentx(sorted_labels ~= unique_labels(u)) = []; 
    currenty = y; 
    currenty(sorted_labels ~= unique_labels(u)) = []; 
    %Plot data points 
    plot(currentx,currenty,markers{u},'MarkerFaceColor', colors{u}, ...
        'MarkerEdgeColor', colors{u}); 
    
    %Check if the mean pm standard deviation should be plotted.
    pltstats = plotsettings.statlabels;
    pltstats(pltstats ~= unique_labels(u)) = []; 
    if ~isempty(pltstats)
        %Isolate the current label 
        current_datapoints = data_points(:); 
        current_labels = labels(:); 
        current_datapoints(current_labels ~= unique_labels(u)) = []; 
        %Store the declare plotsettings color
        old_color = plotsettings.statcolor; 
        plotsettings.statcolor = colors{u}; 
        
        %Plot statistics for the current point 
        plotSummaryStatistics(current_datapoints(:), min_x, max_x, x_pos,...
            plotsettings); 
        
        %Reset the old stat color 
        plotsettings.statcolor  = old_color; 
    end 
    
end

%Plot mean & standard deviation or median + iqr depending on what is asked
%plot settings.stats == 1 (median and interquartile range 
plotSummaryStatistics(data_points(:), min_x, max_x, x_pos,...
    plotsettings); 


end

