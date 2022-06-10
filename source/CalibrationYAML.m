classdef CalibrationYAML < handle
%CalibrationYAML  Class for loading calibration yaml files
%
%   Usage:
%   >> cali = CalibrationYAML;
%   >> cali.loadCalibration(filePath);
%   >> z = cali.MinZ:10:cali.MaxZ;
%   >> plot(z, cali.sigmaX(z), z, cali.sigmaY(z));
%
%   Properties:
%   * Parameters: Map containing all yaml parameters
%   * PixelSize: PixelSize of fitted data in nm
%   * Theta: Average rotation of the fitted PSF
%   * Focus: Focus plane axial position of calibration in nm
%   * MinZ: Lowes axial position used for the calibration
%   * MaxZ: Highest axial position used for the calibration
%   * Knots: Row data (:,3) where 
%            * column 1: sigmaX in µm
%            * column 2: sigmaY in µm
%            * column 3: z in nm
%
%   Methods:
%   * loadCalibration(filePath): load and process a calibration yaml file
%   * sigmaX(y), sigmaY(y): return an array of sigmas in µm from the 
%                           given y data in nm
%   * sigmaXInPixel(y), sigmaYInPixel(y): return an array of sigmas in 
%                                         pixels from the given y data in nm
   properties
       Parameters containers.Map
       PixelSize(1,1) double {mustBeReal, mustBeFinite} = 1.0
       Theta(1,1) double {mustBeReal, mustBeFinite} = 0.0
       Focus(1,1) double {mustBeReal, mustBeFinite} = 0.0
       MinZ(1,1) double {mustBeReal, mustBeFinite} = 0.0
       MaxZ(1,1) double {mustBeReal, mustBeFinite} = 0.0
       Knots(:,3) double {mustBeReal, mustBeFinite}
   end
   
   properties (Access = private, Hidden = true)
       FSigmaX
       FSigmaY
   end
       
   methods
       function obj = CalibrationYAML()
            obj.Parameters = containers.Map;
       end    
       function r = loadCalibration(obj, fileName)
            fid = fopen(fileName, 'r');
            if fid == -1
               warning('Could not open file!');
               r = 0;
               return
            end
            
            data = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
            fclose(fid);

            str = data{1}{1};

            startRegEx = '!!([\w\.]+)';
            paramRegEx = '(\w*):\s*([\-]*[0-9+][.\w]*[-\w]*)';
            knotRegEx = 'knot(\d*)[xyz]';

            matchIndex = regexp(str,startRegEx,'match');
            if strcmp(matchIndex, '!!at.calibration.bspline') == 0
               warning('yaml is not a bspline!');
               r = 0;
               return
            end
            
            [tokens,~] = regexp(str,paramRegEx,'tokens','match');

            maxIndex = 0;
            
            obj.Parameters = containers.Map;

            for k=1:length(tokens)
                key = tokens{k}{1};
                val = str2double(tokens{k}{2});
                obj.Parameters(key) = val;

                matchKnot = regexp(key,knotRegEx,'tokens');

                if ~isempty(matchKnot)
                    index = str2num(matchKnot{1}{1});
                    maxIndex = max(maxIndex, index);
                end
            end
            
            obj.PixelSize = obj.Parameters('pixelSize');
            obj.Theta = obj.Parameters('theta');
            
            obj.Knots = zeros(maxIndex+1, 3);
            for i = 0:maxIndex
                str = compose('knot%dx',i);
                obj.Knots(i+1,1) = obj.Parameters(str{1});
                str = compose('knot%dy',i);
                obj.Knots(i+1,2) = obj.Parameters(str{1});
                str = compose('knot%dz',i);
                obj.Knots(i+1,3) = obj.Parameters(str{1});
            end
            
            obj.MinZ = obj.Knots(1,3);
            obj.MaxZ = obj.Knots(end,3);
            obj.Focus = (obj.MaxZ - obj.MinZ)/2.0;
            
            fitWithSpline(obj);
            
            r = 1;
       end
       function y = sigmaX(obj, x)
           if isempty(obj.Knots)
               y = [];
               warning('Data is not loaded!');
           else
               y = ppval(obj.FSigmaX, x);
           end
       end
       function y = sigmaY(obj, x)
           if isempty(obj.Knots)
               y = [];
               warning('Data is not loaded!');
           else
               y = ppval(obj.FSigmaY, x);
           end
       end
       function y = sigmaXInPixel(obj, x)
           if isempty(obj.Knots)
               y = [];
               warning('Data is not loaded!');
           else
               y = ppval(obj.FSigmaX, x) .* (1000.0 / obj.PixelSize);
           end
       end
       function y = sigmaYInPixel(obj, x)
           if isempty(obj.Knots)
               y = [];
               warning('Data is not loaded!');
           else
               y = ppval(obj.FSigmaY, x) .* (1000.0 / obj.PixelSize);
           end
       end
   end
   methods (Access = private)
       function r = fitWithSpline(obj)
           if isempty(obj.Knots)
               r = 0;
               warning('Data is not loaded!');
               return;
           end
           
           obj.FSigmaX = spline(obj.Knots(:,3), obj.Knots(:,1));
           obj.FSigmaY = spline(obj.Knots(:,3), obj.Knots(:,2));
           
           gs = GlobalSearch;
           problem = createOptimProblem('fmincon','objective', ...
           @(x) abs(ppval(obj.FSigmaX, x) - ppval(obj.FSigmaY, x)), 'x0', ...
            (obj.MaxZ-obj.MinZ)/2, 'lb', obj.MinZ, 'ub', obj.MaxZ);
           obj.Focus = run(gs,problem);
           r = 1;
       end
       function r = fitWithSmoothingSpline(obj)
           if isempty(obj.Knots)
               r = 0;
               warning('Data is not loaded!');
               return;
           end
           
           obj.FSigmaX = fit(obj.Knots(:,3), obj.Knots(:,1), 'smoothingspline');
           obj.FSigmaY = fit(obj.Knots(:,3), obj.Knots(:,2), 'smoothingspline');
            
           gs = GlobalSearch;
           problem = createOptimProblem('fmincon','objective', ...
           @(x) abs(obj.FSigmaX(x)-obj.FSigmaY(y)), 'x0', ...
            (obj.MaxZ-obj.MinZ)/2, 'lb', obj.MinZ, 'ub', obj.MaxZ);
           obj.Focus = run(gs,problem);
           r = 1;
       end
   end
end
    