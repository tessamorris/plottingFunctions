function [] = barPlot(top_val, x, plot_settings, c)

% If there is only one argument set x to 1:length(top_val)
if nargin == 1
    x = 1:length(top_val); 
end 

% If plot info is not provided create an empty struct 
if nargin < 3 
    plot_settings = struct(); 
end 

if ~isfield(plot_settings, 'bar_transparency')
    % Set the transparency equal to 1 so that the bar is not transparent
    plot_settings.bar_transparency = 1; 
end 

% Make sure that the length of x is the same as the number of values 
if length(top_val) ~= length(x)
    x = 1:length(top_val); 
end 

% Change the x-ticks to only be the x values 
plot_settings.xtick = x; 

% Get the defualt plot settings
plot_settings = defaultPlotSettings( plot_settings ); 

% Set the width of the bar equal to the 
xwidth = plot_settings.box_width; 

% If the count c is not provided, loop through the provided colors 
if nargin < 4 
    lt = 0; % Line type
    lc = 0; % Line color 
    cf = 0; % Marker fill color
else
    % Set the counting variables equal to c if it is within bounds 
    lc = correctUpperBound( c, length(plot_settings.bordercolor) );
    lt = correctUpperBound( c, length(plot_settings.bordertype) );
    cf = correctUpperBound( c, length(plot_settings.colorfill) ); 
end 

% Loop through all of the top values 
for k = 1:length(top_val)
    % Set the bounds of the box 
    minx = x(k)-(xwidth/2);
    miny = 0; 
    maxx = x(k)+(xwidth/2);
    maxy = top_val(k); 

    if nargin < 4 
        % Correct the color/marker indices tracker. 
        lc = correctUpperBound( lc + 1, ...
            length(plot_settings.bordercolor), 1 );
        lt = correctUpperBound( lt + 1, ...
            length(plot_settings.bordertype), 1 );
        cf = correctUpperBound( cf + 1, ...
            length(plot_settings.colorfill), 1 ); 
    end 
    hold on; 
    
    % Create a fill 
    fill([minx, maxx, maxx, minx], ...
        [miny,miny,maxy,maxy],  plot_settings.colorfill{cf}, ...
        'FaceAlpha', plot_settings.filltransparency,...
        'linestyle', plot_settings.bordertype{lt},...
        'EdgeColor', plot_settings.bordercolor{lc},...
        'LineWidth', plot_settings.borderwidth)
end 

% Change the plot area
changePlotAppearance( plot_settings ); 

end 

