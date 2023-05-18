function [knownVObs,unknownVObs]=obstDesconocidos(pointsObs,unknownObs)
% Generacion de vectores de los obstaculos conocidos
% knownVObs = [vecX1 vecY1 pXini1 pYini1
%              vecX2 vecY2 pXini2 pYini2
%              vecX3 vecY3 pXini3 pYini3
%              vecX4 vecY4 pXini4 pYini4];
knownVObs = zeros(size(pointsObs,1)*4,4);
for i=1:size(pointsObs,1)
    knownVObs(i*4-3:i*4,:) = [0 pointsObs(i,4)-pointsObs(i,3) pointsObs(i,1) pointsObs(i,3)
                 pointsObs(i,2)-pointsObs(i,1) 0 pointsObs(i,1) pointsObs(i,4)
                 0 pointsObs(i,3)-pointsObs(i,4) pointsObs(i,2) pointsObs(i,4)
                 pointsObs(i,1)-pointsObs(i,2) 0 pointsObs(i,2) pointsObs(i,3)];
end
% Generacion de vectores de los obstaculos no conocidos
% Plot obstaculos
if(~isempty(unknownObs))
    Plot = [unknownObs(:,1) unknownObs(:,1) unknownObs(:,2) unknownObs(:,2) unknownObs(:,1) unknownObs(:,3) unknownObs(:,4) unknownObs(:,4) unknownObs(:,3) unknownObs(:,3)];
    for i = 1:size(Plot,1)
        plot(Plot(i,1:5), Plot(i,6:10), 'Color',[0.5 0.5 0], 'LineWidth', 2)
        fill([pointsObs(i,1) pointsObs(i,1:2) pointsObs(i,2)],[pointsObs(i,3:4) pointsObs(i,4) pointsObs(i,3)],[0.5 0.5 0.5])
    end
    % unknownVObs = [vecX1 vecY1 pXini1 pYini1
    %                vecX2 vecY2 pXini2 pYini2
    %                vecX3 vecY3 pXini3 pYini3
    %                vecX4 vecY4 pXini4 pYini4];
end
unknownVObs = zeros(size(unknownObs,1)*4,4);
for i=1:size(unknownObs,1)
    unknownVObs(i*4-3:i*4,:) = [0 unknownObs(i,4)-unknownObs(i,3) unknownObs(i,1) unknownObs(i,3)
                                unknownObs(i,2)-unknownObs(i,1) 0 unknownObs(i,1) unknownObs(i,4)
                                0 unknownObs(i,3)-unknownObs(i,4) unknownObs(i,2) unknownObs(i,4)
                                unknownObs(i,1)-unknownObs(i,2) 0 unknownObs(i,2) unknownObs(i,3)];
end
end