function [vecSensores]=genVecSensores(robot)
% Vectores de las medidas tomadas por el sensores IR
% vecLidar = [cos(2pi/cantMedidas) sen(2pi/cantMedidas)] * Distancia Maxima
vecSensores = zeros(size(robot.n_sensores,1),2);
for i = 0:robot.n_sensores-1
    vecSensores(i+1,:) = [cos(2*pi/robot.n_sensores*i)*robot.rango_sensor sin(2*pi/robot.n_sensores*i)*robot.rango_sensor];
end
end