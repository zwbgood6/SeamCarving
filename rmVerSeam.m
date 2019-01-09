% File Name: rmVerSeam.m
% Author: Wenbo Zhang | University of Pennsylvania
% Date: Oct/18/2018

function [Ix, E] = rmVerSeam(I, Mx, Tbx)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Output:
%   Ix is the image removed one column.
%   E is the cost of seam removal

% Write Your Code Here
% Initialize
n = size(I,1);
m = size(I,2);
E = min(Mx(n,:));
[~,a] = find(Mx(n,:) == E);
a = min(a);
temp = Tbx(n,a);
IxTemp = I;
Ix = uint8(zeros(n,m-1,3));

% Give the value 2 to the element on the seam
for searchTime = 1:n-1

    if temp == 0
        temp = Tbx(n-1,a);
        Tbx(n-1,a) = 2;
        a = a;
        n = n-1;
        continue
    elseif temp == 1
        temp = Tbx(n-1,a+1);
        Tbx(n-1,a+1) = 2;
        a = a+1;
        n = n-1;
        continue
    elseif temp == -1
        temp = Tbx(n-1,a-1);
        Tbx(n-1,a-1) = 2;
        a = a-1;
        n = n-1;
        continue
    end
    
end
clear temp;
Tbx(size(I,1),a) = 2;

% Delete the element, which has value 2 in the path matrix
[~,y] = find(Tbx == 2);
for x = 1:size(I,1)
  
   seamRowIdx = y(x,1);
   IxTemp(x,seamRowIdx:m-1,:) = IxTemp(x,seamRowIdx+1:m,:);
     
end

n = size(I,1);
Ix(:,:,1) = uint8(IxTemp(1:n,1:m-1,1));
Ix(:,:,2) = uint8(IxTemp(1:n,1:m-1,2));
Ix(:,:,3) = uint8(IxTemp(1:n,1:m-1,3));

end