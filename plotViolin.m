% Arguments:
%   data_vals       - Data to plot the mean and standard deviation of 
%                       Class Support: Nx1 (or 1xN) real numerical  
%
%   plot_info       - (OPTIONAL) Structural array containing plot settings
%                       Class Support: STRUCT
%       
%   data_labels     - (OPTIONAL) Numerical labels for data that will be 
%                       plotted along the x-axis. 
%                       Class Support: Nx1 (or 1xN) real numerical  
% Returns:
%   avg_val         - Average value 
%                       Class Support: number of unique labels x 1 vector
%   stdev_val       - Average minus (:,1) or plus (:,2) the standard 
%                       devation
%                       Class Support: number of unique labels x 2 vector
%   cond_des        - Label associated with data (1 if no labels provided)


function [outputArg1,outputArg2] = plotViolin(data_vals, plot_settings, data_labels)

 % >> VIOLIN PLOTS 
            % Hoffmann H, 2015: violin.m - Simple violin plot using matlab
            % default kernel density estimation. 
            % INRES (University of Bonn), Katzenburgweg 5, 53115 Germany.
            % hhoffmann@uni-bonn.de
            % Calculate the kernel density 
            [pf, u] = ksdensity(data_values); 
            
            %Normal kernel density 
            pf = pf/max(pf)*0.3; 
            
            %Plot the violin fill 
            fill([pf'+x0;flipud(x0-pf')],[u';flipud(u')],...
                colors{c}, 'FaceAlpha', 0.3,'linestyle','none');
            
            %Plot the mean 
            plot([interp1(u', pf'+x0, mean_condition(k,1)), ...
                interp1(flipud(u'), flipud(x0-pf'), ...
                mean_condition(k,1)) ],...
                [mean_condition(k,1) mean_condition(k,1)],...
                '-','color',colors{c},'LineWidth',2);

            %Plot the median 
            plot([interp1(u', pf'+x0, median_condition(k,1)), ...
                interp1(flipud(u'), flipud(x0-pf'), ...
                median_condition(k,1)) ],...
                [median_condition(k,1) median_condition(k,1)],...
                '-','color','k','LineWidth',2);

            %Plot upper and lower median 
            for s=1:2
                plot([interp1(u', pf'+x0, extra_medians(k,s)), ...
                interp1(flipud(u'), flipud(x0-pf'), ...
                extra_medians(k,s)) ],...
                [extra_medians(k,s) extra_medians(k,s)],...
                ':','color','k','LineWidth',2);
            end 
            
            %Save the mins and max lengths
            bnds(k,1) = min(data_values); 
            bnds(k,2) = max(data_values); 
            
            %Increate the count 
            k = k+1; 
            %Increase start and stop 
            p = p+1.5;
            
            if g== 1 && n == floor(ncs/2) 
                %Put axis in the middle of all the CS if there is an odd
                %number 
                if mod(ncs,2) == 0 
                    filter_x(1,f) = x0 + 1/2;
                else 
                    filter_x(1,f) = x0; 
                end 
                f = f+1; 
            end 
            
            if n == ncs
                p = p+1; 
            end 
    
        end
        
    end
    end

end

