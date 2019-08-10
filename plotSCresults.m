


function [] = ...
    plotSCresults( sorting_data, data_vals, plot_info )

% Get the number of unique sorting data 
sort_unique = unique(sorting_data); 

%Number of unique_data 
n = length(sort_unique); 

% Store the average and standard devation 
cond_des = zeros(n,1); 
avg_val = zeros(n,1); 
stdev_val = zeros(n,2); 

% Open a figure and hold on
figure; 
hold on; 

% Get the x axis 
sp = 0.25; 
x = 1:n; 

% Make sure there are enough colors for all of the unique values 
colors = plot_info.colors;
c = 0; 
mark = plot_info.marks; 
m = 0; 
% Loop through all of the unique values, calculate the meean, standard
% deviations
for k = 1:n
    % Save the current unique value 
    cond_des(k,1) = sort_unique(k); 
    
    % Store the temporary data
    temp_data = data_vals(:); 
    temp_data(sorting_data ~= sort_unique(k)) = []; 
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
    min_x = x(k) - sp; 
    max_x = x(k) + sp; 

    %Get matrices for plotting 
    x_vals = [min_x, max_x, x(k), x(k),...
        min_x, x(k), max_x]; 
    y_vals = [max_val, max_val, max_val, min_val, min_val, min_val,...
        min_val]; 
    
    % Change/ correct the color 
    if c < length(colors)-1
        c = c + 1; 
    else
        c = 1; 
    end
        % Change/ correct the marker 
    if m < length(mark)-1
        m = m + 1; 
    else
        m = 1; 
    end
    
    % Plot the standard deviation bars  
    plot(x_vals, y_vals,'-','color',colors{c},'LineWidth',1);

    % Plot the mean 
    plot(x(k), avg_val(k,1), mark{m},'MarkerEdgeColor',colors{c},...
    'MarkerFaceColor',colors{c}); 
    
end

% Change the xlim 
xlim([0,n+1]); 
% Change the ylim

%Change the x axis ticks
if ~isnan(plot_info.xtick)
    set(gca,'XTick',plot_info.xtick)
end 

%Change the font size
set(gca, 'fontsize',12,'FontWeight', 'bold');


% Change the x tick labels 
if ~isnan(plot_info.xticklabel)
    set(gca,'XTickLabel',plot_info.xticklabel,'fontsize',12,...
        'FontWeight', 'bold'); 
end 
    
%Change the y labels 
if ~isnan(plot_info.xlabel)
    xlabel(plot_info.xlabel,'FontSize', 14, 'FontWeight', 'bold');
end 
% Change the y label
if ~isnan(plot_info.ylabel)
    ylabel(plot_info.ylabel,'FontSize',14, 'FontWeight', 'bold');
end 

% Change the title 
if ~isnan(plot_info.title)
    title(plot_info.title,...
            'FontSize', 14, 'FontWeight', 'bold'); 
end 
    

end
