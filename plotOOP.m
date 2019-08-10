function [] = plotOOP(OOP,x,xwidth, c)


minx = x-(xwidth/2);
miny = 0; 
maxx = x+(xwidth/2);
maxy = OOP; 


fill([minx, maxx, maxx, minx], ...
    [miny,miny,maxy,maxy], ...
    c, 'FaceAlpha', 1);
end

