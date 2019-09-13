% positions = [-3,-2,-1,0,1,2,3]
% rates = [30, 30, 75, 20, 10, 20, 20];  
% bar(positions, rates, 'BarWidth', 1, 'HandleVisibility','off', 'FaceColor', 'w');
% xlim=get(gca,'xlim');
% hold on
plot(xlim,[20 20], '--k')

plot(xlim,[100 100], 'k')
ylim([0 125]);
legend('Spontaneous Firing Rate', 'Maximum Firing Rate');
set(gca, 'FontName', 'Serif');
title('Firing Characteristic of Ganglion Cells');
ylabel('Firing Rate (Hz)');
xlabel('Cell Location');