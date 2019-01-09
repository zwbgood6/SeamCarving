% File Name: carv.m
% Author: Wenbo Zhang | University of Pennsylvania
% Date: Oct/18/2018

function [Ic, T] = carv(I, nr, nc)
% Input:
%   I is the image being resized
%   [nr, nc] is the numbers of rows and columns to remove.
% 
% Output: 
% Ic is the resized image
% T is the transport map

% Write Your Code Here

%% Initialize
T = zeros(nr+1,nc+1);
TI = cell(nr+1,nc+1);
T(1,1) = 0;
TI{1,1} = I;

%% Calculate the first row and first column
% Calculate the first column
Irow_temp = I;
for i = 2:nr+1
    eRow = genEngMap(Irow_temp);
    [My, Tby] = cumMinEngHor(eRow);
    [TI{i,1}, Ey] = rmHorSeam(Irow_temp, My, Tby);
    T(i,1) = T(i-1,1) + Ey;
    Irow_temp = TI{i,1}; 
end

% Calculate the first row
Icol_temp = I;
for j = 2:nc+1
    eCol = genEngMap(Icol_temp);
    [Mx, Tbx] = cumMinEngVer(eCol);
    [TI{1,j}, Ex] = rmVerSeam(Icol_temp, Mx, Tbx);
    T(1,j) = T(1,j-1) + Ex;
    Icol_temp = TI{1,j};
end

%% Calculte the elements except the first column and first row
for r = 2:nr+1
    for c = 2:nc+1
        % Calculate the Horizontal Energy
        eCol = genEngMap(TI{r,c-1});
        [Mx, Tbx] = cumMinEngVer(eCol);
        [TI{r,c}, Ex] = rmVerSeam(TI{r,c-1}, Mx, Tbx);
        TIColTemp = TI{r,c};
        
        % Calculate the Vertical Energy
        eRow = genEngMap(TI{r-1,c});
        [My, Tby] = cumMinEngHor(eRow);
        [TI{r,c}, Ey] = rmHorSeam(TI{r-1,c}, My, Tby);
        TIRowTemp = TI{r,c};
        
        % Compare vertical and horizontal path
        HorEnergy = T(r-1,c)+Ey;
        VerEnergy = T(r,c-1)+Ex;
          
        if HorEnergy <= VerEnergy
            T(r,c) = HorEnergy;
            TI{r,c} = TIRowTemp;
        else %HorEnergy > VerEnergy
            T(r,c) = VerEnergy;
            TI{r,c} = TIColTemp;
        end
        
    end
end

%% Final Image
Ic = TI{nr+1,nc+1};

end