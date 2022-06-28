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
    properties(SetAccess=private, GetAccess=public)
        Parameters containers.Map
        Type(1,1) = CalibrationType.Unknown
        Knots(:,3) double {mustBeReal, mustBeFinite}
    end
    properties
        PixelSize(1,1) double {mustBeReal, mustBeFinite} = 1.0
        Theta(1,1) double {mustBeReal, mustBeFinite} = 0.0
        Focus(1,1) double {mustBeReal, mustBeFinite} = 0.0
        MinZ(1,1) double {mustBeReal, mustBeFinite} = 0.0
        MaxZ(1,1) double {mustBeReal, mustBeFinite} = 0.0
        FSigmaX
        FSigmaY
    end
    
    properties (Access = private, Hidden = true)
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
            
            data = textscan(fid, '%s', 'whitespace', '');
            fclose(fid);
            
            str = data{1}{1};
            
            startRegEx = '!!([\w\.]+)';
            paramRegEx = '(\w*):\s*([\-]*[0-9+][.\w]*[-\w]*)';
            knotRegEx = 'knot(\d*)[xyz]';
            
            matchIndex = regexp(str,startRegEx,'tokens');
            type = matchIndex{1}{1};
            
            if strcmp(type, 'at.calibration.bspline') == 1
                obj.Type = CalibrationType.BSpline;
            elseif strcmp(type, 'cz.cuni.lf1.lge.ThunderSTORM.calibration.DaostormCalibration') == 1
                obj.Type = CalibrationType.Daostorm;
            else
                obj.Type = CalibrationType.Unknown;
                warning(['YAML type "' type '" not supported!']);
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
                    index = str2double(matchKnot{1}{1});
                    maxIndex = max(maxIndex, index);
                end
            end
            
            % process bspline calibration
            if obj.Type == CalibrationType.BSpline
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
            elseif obj.Type == CalibrationType.Daostorm
                obj.Theta = obj.Parameters('angle');
                a1 = obj.Parameters('a1');
                b1 = obj.Parameters('b1');
                c1 = obj.Parameters('c1');
                d1 = obj.Parameters('d1');
                w01 = obj.Parameters('w01');
                a2 = obj.Parameters('a2');
                b2 = obj.Parameters('b2');
                c2 = obj.Parameters('c2');
                d2 = obj.Parameters('d2');
                w02 = obj.Parameters('w02');
                
                %dd = 250;
                %obj.MinZ = min(c1-dd, c2-dd);
                %obj.MaxZ = max(c1+dd, c2+dd);
                obj.MinZ = 0;
                obj.MaxZ = 1500;
                
                p1x = (w01^2/d1^4)*(-a1*(c1^3)*d1 + b1*(c1^4) + (c1^2)*(d1^2) + d1^4);
                p2x = (w01^2/d1^4)*(3*a1*(c1^2)*d1 - 4*b1*c1^3 - 2*c1*d1^2);
                p3x = (w01^2/d1^4)*(-3*a1*c1*d1 + 6*b1*c1^2 + d1^2);
                p4x = (w01^2/d1^4)*(a1*d1-4*b1*c1);
                p5x = (w01^2/d1^4)*(b1);
                
                obj.FSigmaX = mkpp([obj.MinZ obj.MaxZ], [p5x p4x p3x p2x p1x]);
                
                p1y = (w02^2/d2^4)*(-a2*(c2^3)*d2 + b2*(c2^4) + (c2^2)*(d2^2) + d2^4);
                p2y = (w02^2/d2^4)*(3*a2*(c2^2)*d2 - 4*b2*c2^3 - 2*c2*d2^2);
                p3y = (w02^2/d2^4)*(-3*a2*c2*d2 + 6*b2*c2^2 + d2^2);
                p4y = (w02^2/d2^4)*(a2*d2-4*b2*c2);
                p5y = (w02^2/d2^4)*(b2);
                obj.FSigmaY = mkpp([obj.MinZ obj.MaxZ], [p5y p4y p3y p2y p1y]);
                
                gs = GlobalSearch;
                problem = createOptimProblem('fmincon','objective', ...
                    @(x) abs(ppval(obj.FSigmaX, x) - ppval(obj.FSigmaY, x)), 'x0', ...
                    (obj.MaxZ-obj.MinZ)/2, 'lb', obj.MinZ, 'ub', obj.MaxZ);
                obj.Focus = run(gs,problem);
            end
            
            r = 1;
        end
        function y = sigmaX(obj, x)
            if isempty(obj.FSigmaX)
                y = [];
                warning('Data is not loaded!');
            else
                y = ppval(obj.FSigmaX, x);
                if obj.Type == CalibrationType.Daostorm
                   y = sqrt(y) * 0.5; 
                end
            end
        end
        function y = sigmaY(obj, x)
            if isempty(obj.FSigmaY)
                y = [];
                warning('Data is not loaded!');
            else
                y = ppval(obj.FSigmaY, x);
                if obj.Type == CalibrationType.Daostorm
                   y = sqrt(y) * 0.5; 
                end
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
