



function [] = makeDotPlot(data_points, bin_size, ...
    x_pos, x_bnd, x_shift, plotsettings)

%Find the minimum and maximum values 
min_value = min(data_points(:)) - eps; 
max_value = max(data_points(:)); 

%Create the bins 
bins = min_value:bin_size:max_value; 
bins(1,end) = max_value; 
%Get the number of bins 
nb = length(bins)-1; 

%Initialize arrays to store the approximate data value and the number of
%points in that position 
approx_values = zeros(1,nb-1); 
counts = zeros(1,nb-1); 
for b = 1:nb
    %Get the approximate data value 
    approx_values(1,b) = ( bins(b+1) + bins(b) ) / 2; 
    %Get the number of data points in that bin 
    current = data_points(:); 
    current(current > bins(1,b+1) | current <= bins(1,b)) = []; 
    counts(1,b) = length(current);
end 

%Get the maximum count. 
max_c = max(counts); 

%Make sure the x shift will be within the bounds
max_x = x_pos + x_bnd; 
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
hold on; 
%Plot data points 
plot(x,y,'o','MarkerFaceColor', plotsettings.makerfill, ...
    'MarkerEdgeColor',plotsettings.markeredge ); 


%Adjust the x minimum and maximum values
max_x = max(x(:)); 
min_x = min(x(:)); 

%Plot mean & standard deviation or median + iqr depending on what is asked
%plot settings.stats == 1 (median and interquartile range 
if plotsettings.stats == 1
    %Calculate the median and sort  the data
    median_value = median(data_points(:)); 
    sorted_data = sort(data_points(:)); 
    %Compute 25th & 75th percentile 
    q25 = median( sorted_data(sorted_data < median_value) );
    q75 = median( sorted_data(sorted_data > median_value) );
    iqr_value = iqr(data_points(:)); 
    iqr_min = q25-1.5*iqr_value; 
    iqr_max = q75+1.5*iqr_value; 
    
    %Create a box of the interquartile range 
    fill([min_x, max_x, max_x, min_x], ...
    [q25, q25, q75, q75],plotsettings.boxfill, 'FaceAlpha', ... 
    plotsettings.transparency);    
    %Plot the median 
    plot([min_x,max_x], [median_value,median_value],'-', ...
        'color',plotsettings.statcolor,'LineWidth',2); 
    
    %Get the min and max x positions for the plot (1/2 length) 
    max_x = (x_pos + max_x) / 2; 
    min_x = (x_pos + min_x) / 2; 
    
    %Plot min iqr      
    plot([min_x, max_x, x_pos, x_pos], ...
        [iqr_max, iqr_max, iqr_max, q75], ...
        '-', ...
        'color',plotsettings.statcolor,'LineWidth',1); 
    %Plot min and max with iqr      
    plot([x_pos, x_pos, max_x, min_x], ...
        [q25, iqr_min, iqr_min, iqr_min], ...
        '-', ...
        'color',plotsettings.statcolor,'LineWidth',1); 
end 


end

