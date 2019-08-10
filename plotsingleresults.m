x = 1; xwidth = 0.5; c = 'k';
plotOOP(OOP,x,xwidth, c)
hold on 
plotOOP(OOPa,2,xwidth, c)


p1 = actin_explore.prefilt_skel; 
p2 = actin_explore.final_skels{1}; 
p1_seg = getRectSection(p1, rect_segment{1}, false); 
p2_seg = getRectSection(p2, rect_segment{1}, false); 

frac = sum(p2_seg)/sum(p1_seg); 
plotOOP(frac,3,xwidth,'b')
%Change the x axis labels
set(gca,'XTick',[1,2,3]) 
set(gca,'XTickLabel',{'Z-line OOP','Actin OOP', 'Z-line Fraction'})
%Change the font size
set(gca, 'fontsize',12,'FontWeight', 'bold');

ylabel('Orientational Order','FontSize',...
    14, 'FontWeight', 'bold');