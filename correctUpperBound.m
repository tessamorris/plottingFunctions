function [num] = correctUpperBound(num,upperbound,num_def)
% Check to see if the number is greater than the upperbound. If it is, set
% it to be the default number 
if num > upperbound
    num = num_def; 
end 
end

