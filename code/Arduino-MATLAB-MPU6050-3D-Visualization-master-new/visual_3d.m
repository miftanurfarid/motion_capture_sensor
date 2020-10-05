% clc; close all; clearvars;

% close all serial com
a = instrfind();
fclose(a);

tData = 20; % time in secods

s = serial('COM3','BAUD', 115200);  % Baud rate and COM port
fopen(s);

myaxes = axes('xlim', [-2 2], 'ylim', [-2 10], 'zlim', [-1.5 1.5]);
view(3)
grid on;
axis equal;
hold on;
xlabel('x');
ylabel('y');
zlabel('z');

[xcylinder, ycylinder, zcylinder] = cylinder([0.2 0.2]);
[xcone, ycone, znoce] = cylinder([0.2 0.1]);
[xsphere, ysphere, zsphere] = sphere();

h(1) = surface(xcone, ycone, znoce);

combinedobject = hgtransform('parent',myaxes);
xx = 0.1;
yy = 0;
rotation1 = makehgtform('xrotate', 90 * xx * (pi/180)); % ori: 90
rotation2 = makehgtform('yrotate', 90 * yy * (pi/180)); % ori 90
set(combinedobject, 'matrix', rotation1 * rotation2);

set(h,'parent', combinedobject);
drawnow;

dt = zeros(2,1);
tmp = clock;
dt(1) = round(tmp(6));
while 2 > 1 % dt(2) - dt(1) <= tData
    out = fscanf(s);
    %sprintf(out);
    %disp(out);
    if out(1) == '#'
        parsedData = strsplit(out(1:length(out)-2),{',','=','\n'});
        disp(parsedData);
%         disp(180 * str2double(parsedData(2)));
        rotation1 = makehgtform('xrotate', 90 * str2double(parsedData(2)) * (pi/180)); % ori: 90
        rotation2 = makehgtform('yrotate', 90 * str2double(parsedData(4)) * (pi/180)); % ori 90
        set(combinedobject, 'matrix', rotation1 * rotation2);
        drawnow;
    end
    
    tmp = clock;
    dt(2) = round(tmp(6));
end


