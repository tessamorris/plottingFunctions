function [] = addSTDbar(x_pos, mean_val, std_val, plot_names)
%Plot stdev as a colored line data must be in the format number of
%conditions x data points 

%Add colors 
colors = {[0.1098,0.4588,0.7373],[0.3686,0.0314,...
    0.6471],[0.0745,0.9686,0.6863],...
    [0.8000,0.0392,0.3529],[0.0392,0.6706,0.8000],...
    [0.9569,0.6784,0.2588],[0.0235,0.6000,0.0588],...
    [0.6275,0.6275,0.6275],[1,0.6,1],[0.2789,0.4479,0.6535],...
    [0.9569,0.9059,0.3529],[0.0824,0.4000,0.9490],...
    [0.9882,0.2980,0.2353]};
%Open a figure and hold on 
figure; 
hold on; 
%Get the number of data points
ndata = size(mean_val,2); 
%Get the number of conditions 
ncond = size(mean_val,1); 

%Sort the x_positions 
xp_sort = sort(unique(x_pos(:))); 
spacing = zeros(length(xp_sort)-1,1); 
%Get average spacing 
for k = 1:length(xp_sort(:))-1
    %Take difference 
    spacing(k,1) = abs(xp_sort(k) - xp_sort(k+1)); 
end 

%Set the minimum spacing 
min_space = min(spacing(:)); 
f = 0.1; 
sp = min_space*f; 
%Tiny value between range 
t = 0.0001; 

%Start color value 
c = 0; 
%Loop through all of the conditions 
for nc = 1:ncond
    %Increase color 
    if c > length(colors)-1 || nc == 1
        c = 1; 
    else
        c = c+1; 
    end 
            
    %Plot all of the 
    plot(x_pos(nc,:),mean_val(nc,:), '-o', 'LineWidth',1,...
                'MarkerEdgeColor',colors{c},...
                'MarkerFaceColor',colors{c},...
                'MarkerSize',2, 'color',colors{c}); 
    hold on; 
            
    for d = 1:ndata
        %Get the minimum and max values 
        min_val = mean_val(nc,d)-std_val(nc,d);
        max_val = mean_val(nc,d)+std_val(nc,d); 
        
        %Add top bar 
        min_x = x_pos(nc,d) - sp; 
        max_x = x_pos(nc,d) + sp; 
        
        %Get matrices for plotting 
        x_vals = [min_x, max_x, x_pos(nc,d), x_pos(nc,d),...
            min_x, x_pos(nc,d), max_x]; 
        y_vals = [max_val, max_val, max_val, min_val, min_val, min_val,...
            min_val]; 
        
        %Plot the standard deviation bars  
        plot(x_vals, y_vals,'-','color',colors{c},'LineWidth',1);
        
    end 
end 

%Save data as pdf if requested by user.
if nargin == 4
    %Set the font size 
    set(gca, 'fontsize',12,'FontWeight', 'bold');


    %Change the x and y labels 
    xlabel(plot_names.x,'FontSize', 14, 'FontWeight', 'bold');
    ylabel(plot_names.y,'FontSize',...
        14, 'FontWeight', 'bold');

    %Append file when necessary 
    temp_title = plot_names.title; 
    title(temp_title, 'FontSize', 14, 'FontWeight', 'bold'); 
    new_filename = appendFilename( plot_names.path, ...
        strcat(plot_names.savename,'.pdf'));
    %Save file
    saveas(gcf, fullfile(plot_names.path, ...
        new_filename), 'pdf'); 
end 
end

