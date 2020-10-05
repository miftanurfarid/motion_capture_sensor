t = 0:pi/10:pi;
y = 1+cos(0.5*t);
figure(1);
[X,Y,Z] = cylinder(y);
surf(X,Y,Z)
axis square