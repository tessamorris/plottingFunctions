% defaultPlotSettings - Sets the default settings for a plot and checks to
% make sure that the provided settings are correct. Written for usage with
% accompanying plotting functions. 
%
% Usage: 
%   plot_settings = defaultPlotSettings( plot_settings );
%
% Arguments:
%   plot_settings   - structural array that contains plotting descriptions. 
%                       Class Support: STRUCT
%
% Returns:
%   plot_settings.changeXlimits - logical describing if the user wants to
%                                   changed the x-axis limits
%   plot_settings.changeYlimits - logical describing if the user wants to
%                                   changed the y-axis limits
%   plot_settings.setXticks     – logical statement to change location of 
%                                   x-ticks
%
% Optional Arguments / Returns:
% The input can be an empty struct and the following settings will be
% defined: 
%       Default for mean and standard deviation bars: black bars with a 
%       black filled in circle at the mean. The bar width is default set 
%       to 0.25. No title or axis labels will be provided. 
%
% The user can also define any of the following 
%   > Change plot lines 
%       plot_settings.linecolor
%       plot_settings.linetype
%       plot_settings.linewidth
%   > Change marker 
%       plot_settings.marks
%       plot_settings.markercoloredge = default_color; 
%       plot_settings.markercolorfill = default_color; 
%       plot_settings.markersize = default_markersize; 
%  
%   > Change axis limits 
%       plot_settings.xmin - lower limit of xaxis, set by user if desired
%       plot_settings.xmax- upper limit of xaxis, set by user if desired
%       plot_settings.ymin - lower limit of yaxis, set by user if desired
%       plot_settings.ymax- upper limit of yaxis, set by user if desired
%   > Font sizes 
%       plot_settings.font_size – numerical size of numbers in plot

% plot_settings.xtick – positions to place x-ticks 
% plot_settings.changeXticklabel – logical statement to change x tick labels
% plot_settings.xticklabel – labels of x-ticks  
% plot_settings.changeXtickfont – logical to change size of font
% plot_settings.xtickfontsize – font size of x-axis
% plot_settings.setYticks – logical statement to change location of y-ticks
% plot_settings.ytick – positions to place y-ticks 
% plot_settings.changeYticklabel – logical statement to change y tick labels
% plot_settings.yticklabel – labels of y-ticks  
% plot_settings.changeYtickfont – logical to change size of font
% plot_settings.ytickfontsize – font size of y-axis
% plot_settings.addTitle – logical to add title
% plot_settings.title – string describing title 
% plot_settings.titlesize – font size of title 
% plot_settings.addXaxislabel – logical to add x-axis label
% plot_settings.xlabel – string describing x-axis
% plot_settings.xlabelsize – font size of x-axis 
% plot_settings.addYaxislabel – logical to add y-axis label
% plot_settings.ylabel – string describing y-axis
% plot_settings.ylabelsize – font size of y-axis 
%
% Dot plot only 
%plot_settings.num_bins 

% Dependencies: 
%   MATLAB Version >= 9.5 
%
% Tessa Altair Morris
% Advisor: Anna Grosberg, Department of Biomedical Engineering 
% Cardiovascular Modeling Laboratory 
% University of California, Irvine 

function [ plot_settings ] = defaultPlotSettings( plot_settings )

%%%%%%%%%%%%%%%%%%%%% Settings for Plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Default for mean and standard deviation bars: black bars with a black
% filled in circle at the mean. The bar width is default set to 0.25

% Set the spacing of the standard deviation bars
default_sp = 0.25; 
if ~isfield(plot_settings, 'sp')
    plot_settings.sp = default_sp;
end 

% Set the default marker and size if it is not declared. 
default_marker = {'o'}; 
default_markersize = 10; 

if ~isfield(plot_settings, 'marks')
    plot_settings.marks = default_marker; 
else
    % Check to make sure the marker is a string with a cell 
    if isstring(plot_settings.marks)
        plot_settings.marks = {plot_settings.marks}; 
    end 
end

if ~isfield(plot_settings, 'markersize')
    plot_settings.markersize = default_markersize; 
end

% Set the default linewidth 
default_linewidth = 1; 
if ~isfield(plot_settings, 'linewidth')
    plot_settings.linewidth = default_linewidth;
end 

% Set the default line type
default_linetype = {'-'}; 
if ~isfield(plot_settings, 'linetype')
    plot_settings.linetype = default_linetype; 
end 

% Set the default color for all of the plot to be black 
default_color = {'k'}; 

% Set the default color if it is not defined. 
if ~isfield(plot_settings, 'colors')
    plot_settings.colors = default_color; 
end

% Color of the lines
if ~isfield(plot_settings, 'linecolor')
    plot_settings.linecolor = plot_settings.colors; 
end

% Color of the marker edge
if ~isfield(plot_settings, 'markercoloredge')
    plot_settings.markercoloredge = plot_settings.colors; 
end
% Color of the marker fill 
if ~isfield(plot_settings, 'markercolorfill')
    plot_settings.markercolorfill = plot_settings.colors; 
end

% Color of the box (for bar plot and mean,median plots)
if ~isfield(plot_settings, 'colorfill')
    plot_settings.colorfill = plot_settings.colors; 
end


% Dot plot only; number of bins 
default_binnum = 20; 
if ~isfield(plot_settings, 'num_bins')
    plot_settings.num_bins = default_binnum; 
end 

% Bar plot, box plot, and mean plot 
default_boxwidth = 0.9; 
if ~isfield(plot_settings,'box_width')
    plot_settings.box_width = default_boxwidth; 
end 

% Set the default transparency of a box to 0.3
default_transparency = 0.4; 
if ~isfield(plot_settings,'bar_transparency')
    plot_settings.bar_transparency = default_transparency;
end 
%%%%%%%%%%%%%%%%%%%%%% Formatting the Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Default font sizes for the axes and label
default_fontsize = 12; 
default_axisfontsize = 14; 

% If it is not a field, set it to be the default. 
if ~isfield(plot_settings, 'font_size')
    plot_settings.font_size = default_fontsize; 
end

% Check if the x ticks are set to anything.  
if ~isfield(plot_settings, 'xtick')
    plot_settings.setXticks = false; 
else
    plot_settings.setXticks = true; 
end

% Check if the x tick labels are changed, must also declare where the
% x-ticks are located. If it has the same number of points then it can be
% declared. 
if ~isfield(plot_settings, 'xticklabel')
    plot_settings.changeXticklabel = false; 
else
    % Set the change label to false unless the x ticks have also been
    % changed and they are the smae length
    plot_settings.changeXticklabel = false; 
    if isfield(plot_settings, 'xtick')
        if length(plot_settings.xticklabel) == length(plot_settings.xtick)
            plot_settings.changeXticklabel = true;        
        end 
    end 
    
end

% Check if the x tick rotation is changed 
if ~isfield(plot_settings, 'xtickrotation')
    plot_settings.changeXtickRotation = false; 
else
    plot_settings.changeXtickRotation = true; 
end

% Check if the x tick font size is changed
if ~isfield(plot_settings, 'xtickfontsize')
    plot_settings.changeXtickfont = false; 
else
    plot_settings.changeXtickfont = true; 
end

% Check if the y ticks are set to anything.  
if ~isfield(plot_settings, 'ytick')
    plot_settings.setYticks = false; 
else
    plot_settings.setYticks = true; 
end
 
% Check if the y tick labels are changed, must also declare where the
% y-ticks are located. If it has the same number of points then it can be
% declared. 
if ~isfield(plot_settings, 'yticklabel') && ...
        ~isfield(plot_settings, 'ytick')
    plot_settings.changeYticklabel = false; 
else
    if length(plot_settings.yticklabel) == length(plot_settings.ytick)
        plot_settings.changeYticklabel = true;
    else
        plot_settings.changeYticklabel = false; 
    end 
    
end
 
% Check if the y tick rotation is changed 
if ~isfield(plot_settings, 'ytickrotation')
    plot_settings.changeYtickRotation = false; 
else
    plot_settings.changeYtickRotation = true; 
end

% Check if the y tick font size is changed
if ~isfield(plot_settings, 'ytickfontsize')
    plot_settings.changeYtickfont = false; 
else
    plot_settings.changeYtickfont = true; 
end

% Check to see if there is a provided title and if so whether its font size
% is set 
if ~isfield(plot_settings, 'title')
    plot_settings.addTitle = false; 
else
    plot_settings.addTitle = true; 
    % Set the font size if it has not already been set
    if ~isfield(plot_settings, 'titlesize')
        plot_settings.titlesize = default_axisfontsize; 
    end 
end

% Check to see if there is a provided x-axis label and if so whether its 
% font size is set 
if ~isfield(plot_settings, 'xlabel')
    plot_settings.addXaxislabel = false; 
else
    plot_settings.addXaxislabel = true; 
    % Set the font size if it has not already been set
    if ~isfield(plot_settings, 'xlabelsize')
        plot_settings.xlabelsize = default_axisfontsize; 
    end 
end

% Check to see if there is a provided y-axis label and if so whether its 
% font size is set 
if ~isfield(plot_settings, 'ylabel')
    plot_settings.addYaxislabel = false; 
else
    plot_settings.addYaxislabel = true; 
    % Set the font size if it has not already been set
    if ~isfield(plot_settings, 'ylabelsize')
        plot_settings.ylabelsize = default_axisfontsize; 
    end 
end

% Change the x-axis limits 
if isfield(plot_settings, 'xmin') && isfield(plot_settings, 'xmax') 
    plot_settings.changeXlimits = true; 
else
    plot_settings.changeXlimits = false; 
end 

% Change the y-axis limits 
if isfield(plot_settings, 'ymin') && isfield(plot_settings, 'ymax') 
    plot_settings.changeYlimits = true; 
else
    plot_settings.changeYlimits = false; 
end 
end

