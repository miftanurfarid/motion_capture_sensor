load dataPengukuran.mat;
Y_Rad = (-90) * (data(:,2) - 1)*(pi/180);
Y_Deg = rad2deg(Y_Rad);
plot(Y_Deg, 'linewidth', 2);
xlabel('samples');
ylabel('angle (\circ)');
title('forearm');
grid on;
print('forearm_data','-depsc')
print('forearm_data','-dpng')