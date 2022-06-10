% MIT License
% 
% Copyright (c) 2022 Jaroslaw Jacak, 
% Medical Engineering Dept. Upper Austria University od Applied Sciences, Linz, Austria
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

addpath('source')

clc
clear
close all

Data_Load_1;
Data_Load_2;

%close all

alpha=2;

pos1=dat1(:,[xi1,yi1,zi1]);
[klaster1,centroid1,kcentroid1,avg_min_dist1,N1]=cluster_preparation3D(pos1,alpha);

alpha2=5;
close all
pos2=dat2(:,[xi2,yi2,zi2]);
[klaster2,centroid2,kcentroid2,avg_min_dist2,N2]=cluster_preparation3D(pos2,alpha2);

Answer_coll_typ;
