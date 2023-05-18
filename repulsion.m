function [Frep] = repulsion(sensor,vecSensor,robot)
% calculo de fuerza de repulsion
Frep = [0 0];
for i=1:size(sensor,1)
    if(sensor(i)<robot.rango_sensor)
        F = robot.c_repulsion/2*(1/(sensor(i)-robot.radio_robot))^2;
        Frep = Frep + vecSensor(i,:)/norm(vecSensor(i,:))*F;
    end
end
end