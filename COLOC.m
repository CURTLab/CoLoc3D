% CoLoc3D is the tools for  calibration, registration and co-localization of
% 3D dual-color single molecule localization.
%
% CoLoc3D contains many MatLab functions and scripts that allow calibration, 
% registration and co-localization of dual-color single molecule images 
% (in two channels).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   In this prototype system, the input data structure is limited to specified 
%   matlab format. Data set must be of type structure array named "par". The 
%   structure must contain the fields:
%   par.pkmatrix – array of numerical data with row-measurements and
%   columns- data coordinates.
%   par.pkdesc - contains two cells par.pkdesc.desc, and par.pkdesc.units:
%   par.pkdesc.desc - gives a description of the pkmatrix-columns line 
%   with at least the following string variables:
%   "frame"; "x"; "y"; "z"; "pa"; "paz"; "intensity"  where "pa" is the position accuracy 
%   of xy localization and 
%   "paz" is position accuracy of localization on z-axis. "frame" is frame number.
%   par.pkdesc.units contains a description  of the units of measure 
%   for each column in string format.
%   
%   IMPORT DATA FROM EXCEL
%   In order to enable analysis of data in another format, the system has an interface to Excel
%   that imports and transfers Excel data to the Matlab format described above.  
%   Excel data spreadsheet  must be column-oriented and  must have at least 3 columns 
%   (3D point localizations) with column headers "x", "y", "z".
%   If possible, the following additional columns should contain :
%   - position accuracy (in nm) in x and y with header "pa",
%   - position accuracy (in nm) along the axis z with header "paz",
%   - intensity of the point with the header "intensity",
%   - and the frame number with the "frame" header.
%
%  In the absence of these columns they will be automatically generated 
%  with default values typical for this type of nanoscopic samples.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close all

addpath('source')

Figure_start;

try
	START_CALIBRATION;
catch
	clc
end
