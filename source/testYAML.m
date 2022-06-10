%clear all;
%clear classes;

filePath = fullpath;

cali = CalibrationYAML;
%loadCalibration(cali, filePath);
ret = cali.loadCalibration(filePath);

figure;
hold on;
grid on;

plot(cali.Knots(:,3), cali.Knots(:,1), 'or');
plot(cali.Knots(:,3), cali.Knots(:,2), 'ob');

z = cali.MinZ:10:cali.MaxZ;
plot(z, cali.sigmaX(z),'r');
plot(z, cali.sigmaY(z),'b');

xlabel('z in nm');
ylabel('sigma in µm');

fy = cali.sigmaX(cali.Focus);
text(cali.Focus, fy, '\leftarrow Focus');
clc
clear('fy','ret','z')