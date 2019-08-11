function [] = barPlot(mean_val, x, plot_settings)

% Set the transparency equal to 1 so that the bar is not transparent
plot_settings.bar_transparency = 1; 

% Get the defualt plot settings
plot_settings = defaultPlotSettings( plot_settings ); 

% Set the width of the bar equal to the 
xwidth = plot_settings.box_width; 

% Set the bounds of the box 
minx = x-(xwidth/2);
miny = 0; 
maxx = x+(xwidth/2);
maxy = mean_val; 

c = 1; 
plot_settings.colorfill{c} = 'r'; 
% Create a fill 
fill([minx, maxx, maxx, minx], ...
    [miny,miny,maxy,maxy],  plot_settings.colorfill{c}, ...
    'FaceAlpha', plot_settings.bar_transparency,...
    'linestyle', plot_settings.linetype{c},...
    'EdgeColor', plot_settings.linecolor{c},...
    'LineWidth', plot_settings.linewidth)
end 

