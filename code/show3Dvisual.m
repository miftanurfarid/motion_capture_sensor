clc;
close all;
clearvars;
closeCOMserial();

s=serial('COM3','BAUD', 115200);  % Baud rate and COM port
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
[xcone, ycone, zcone] = cylinder([0.1 0.15]);
[xsphere, ysphere, zsphere] = sphere();

h(1) = surface(xcone, ycone, zcone);

combinedobject = hgtransform('parent',myaxes);
set(h,'parent', combinedobject);
drawnow;

while 2>1
    out = fscanf(s);
    %sprintf(out);
    %disp(out);
    if out(1)=='#'
        parsedData = strsplit(out(1:length(out)-2),{',','=','\n'});
        disp(parsedData);
        disp(180*str2double(parsedData(2)));
        rotation1 = makehgtform('xrotate', 90 * str2double(parsedData(2))*(pi/180));  % 2
        rotation2 = makehgtform('yrotate', -90 * (str2double(parsedData(4)) - 1)*(pi/180));  % 4
        rotation3 = makehgtform('yrotate', 90 * (str2double(parsedData(6)))*(pi/180));  % 6
        set(combinedobject,'matrix',rotation2);
        drawnow;
    end
    
end