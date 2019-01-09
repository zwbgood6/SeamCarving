% File Name: rmHorSeam.m
% Author: Wenbo Zhang | University of Pennsylvania
% Date: Oct/18/2018

function [Iy, E] = rmHorSeam(I, My, Tby)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Output:
%   Iy is the image removed one row.
%   E is the cost of seam removal

% Write Your Code Here

% Initialize
n = size(I,1);
m = size(I,2);
E = min(My(:,m));
[a,~] = find(My(:,m) == E);
a = min(a);
temp = Tby(a,m);
IyTemp = I;
Iy = uint8(zeros(n-1,m,3));

% Give the value 2 to the element on the seam
for searchTime = 1:m-1

    if temp == 0
        temp = Tby(a,m-1);
        Tby(a,m-1) = 2;
        a = a;
        m = m-1;
        continue
    elseif temp == 1
        temp = Tby(a+1,m-1);
        Tby(a+1,m-1) = 2;
        a = a+1;
        m = m-1;
        continue
    elseif temp == -1
        temp = Tby(a-1,m-1);
        Tby(a-1,m-1) = 2;
        a = a-1;
        m = m-1;
        continue
    end
    
end
clear temp;
Tby(a,size(I,2)) = 2;

% Delete the element, which has value 2 in the path matrix
[x,~] = find(Tby == 2);
for y = 1:size(I,2)
  
   seamRowIdx = x(y,1);
   IyTemp(seamRowIdx:n-1,y,:) = IyTemp(seamRowIdx+1:n,y,:);
     
end

m = size(I,2);
Iy(:,:,1) = uint8(IyTemp(1:n-1,1:m,1));
Iy(:,:,2) = uint8(IyTemp(1:n-1,1:m,2));
Iy(:,:,3) = uint8(IyTemp(1:n-1,1:m,3));

end