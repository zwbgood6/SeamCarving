% File Name: cumMinEngVer.m
% Author: Wenbo Zhang | University of Pennsylvania
% Date: Oct/18/2018

function [Mx, Tbx] = cumMinEngVer(e)
% Input:
%   e is the energy map

% Output:
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Write Your Code Here
% Define go down -> 0, go downleft -> 1, go downright -> -1

% Initialize
n = size(e,1);
m = size(e,2);
Mx = zeros(n,m);
Tbx = zeros(n,m);
Mx(1,:) = e(1,:);


for i = 2:n 
    
    j = 1;
    minMx = min(Mx(i-1,j),Mx(i-1,j+1));
    Mx(i,j) = e(i,j) + minMx;             
    if minMx == Mx(i-1,j)
         Tbx(i,j) = 0;
    else
         Tbx(i,j) = 1; 
    end 
    
    j = m;
    minMx = min(Mx(i-1,j-1),Mx(i-1,j));
    Mx(i,j) = e(i,j) + minMx;         
    if minMx == Mx(i-1,j-1)
         Tbx(i,j) = -1;
    else
         Tbx(i,j) = 0;
    end
           
    for j = 2:m-1                                   
         minMx = min(min(Mx(i-1,j-1),Mx(i-1,j)),Mx(i-1,j+1));
         Mx(i,j) = e(i,j) + minMx;           
         if minMx == Mx(i-1,j-1)
             Tbx(i,j) = -1;
         elseif minMx == Mx(i-1,j)
             Tbx(i,j) = 0;
         else
             Tbx(i,j) = 1;
         end
    end
                
    
end



end
