% File Name: cumMinEngHor.m
% Author: Wenbo Zhang | University of Pennsylvania
% Date: Oct/18/2018

function [My, Tby] = cumMinEngHor(e)
% Input:
%   e is the energy map.

% Output:
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Write Your Code Here

% Define go right -> 0, go upright -> 1, go bottomright -> -1

% Initialize
n = size(e,1);
m = size(e,2);
My = zeros(n,m);
Tby = zeros(n,m);
My(:,1) = e(:,1);


for j = 2:m 
    
    i = 1;
    minMy = min(My(i,j-1),My(i+1,j-1));
    My(i,j) = e(i,j) + minMy;             
    if minMy == My(i,j-1)
         Tby(i,j) = 0;
    else
         Tby(i,j) = 1; 
    end 
    
    i = n;
    minMy = min(My(i-1,j-1),My(i,j-1));
    My(i,j) = e(i,j) + minMy;         
    if minMy == My(i-1,j-1)
         Tby(i,j) = -1;
    else
         Tby(i,j) = 0;
    end
           
    for i = 2:n-1                                   
         minMy = min(min(My(i-1,j-1),My(i,j-1)),My(i+1,j-1));
         My(i,j) = e(i,j) + minMy;           
         if minMy == My(i-1,j-1)
             Tby(i,j) = -1;
         elseif minMy == My(i,j-1)
             Tby(i,j) = 0;
         else
             Tby(i,j) = 1;
         end
    end
                
    
end



end