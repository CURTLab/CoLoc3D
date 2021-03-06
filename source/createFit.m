function [fitresult, gof] = createFit(uu, ww)
%CREATEFIT(UU,WW)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input: uu
%      Y Output: ww
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 18-Jun-2022 14:32:44


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( uu, ww );

% Set up fittype and options.
ft = fittype( 'fourier8' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00313532200957065];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
%h = plot( fitresult, xData, yData );
h= plot( fitresult);
legend( h, 'ww vs. uu', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'uu', 'Interpreter', 'none' );
ylabel( 'ww', 'Interpreter', 'none' );
grid on


