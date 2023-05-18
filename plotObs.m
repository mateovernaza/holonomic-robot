function []=plotObs(pointsObs,grownObs,grownLimites,grafico)
pause(grafico.tIni)
% plot obstaculos
Plot = [pointsObs(:,1) pointsObs(:,1) pointsObs(:,2) pointsObs(:,2) pointsObs(:,1) pointsObs(:,3) pointsObs(:,4) pointsObs(:,4) pointsObs(:,3) pointsObs(:,3)];
for i = 1:size(Plot,1)
    plot(Plot(i,1:5), Plot(i,6:10), 'black', 'LineWidth', 2)
    fill([pointsObs(i,1) pointsObs(i,1:2) pointsObs(i,2)],[pointsObs(i,3:4) pointsObs(i,4) pointsObs(i,3)],[0.5 0.5 0.5])
end
pause(grafico.tObs)
% Plot obstaculos con offset
Plot = [grownObs(:,1) grownObs(:,1) grownObs(:,2) grownObs(:,2) grownObs(:,1) grownObs(:,3) grownObs(:,4) grownObs(:,4) grownObs(:,3) grownObs(:,3)];
for i = 1:size(Plot,1)
    plot(Plot(i,1:5), Plot(i,6:10), 'black', 'LineWidth', 2, 'LineStyle',':')
end
% Plot limites con offset
Plot = [grownLimites(1,1) grownLimites(1,1) grownLimites(1,2) grownLimites(1,2) grownLimites(1,1) grownLimites(1,3) grownLimites(1,4) grownLimites(1,4) grownLimites(1,3) grownLimites(1,3)];
for i = 1:size(Plot,1)
    plot(Plot(i,1:5), Plot(i,6:10), 'black', 'LineWidth', 2, 'LineStyle',':')
end
pause(grafico.tObs)
end