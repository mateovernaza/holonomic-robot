function [V_control,distSensores]=calcVelocidad(camino,nodosNew,contCamino,pos,vecSensores,knownVObs,unknownVObs,robot)
% Fuerza de atraccion
F_atr = atraccion(nodosNew(camino(contCamino),:),pos,robot);
% Se calcula distancias obtenidas de sensores -> equivalente a medicion de
% sensoresr
distSensores = sensor(knownVObs,unknownVObs,pos,robot,vecSensores);
% Fuerza de repulsion
F_rep = repulsion(distSensores,-vecSensores,robot);
% Velocidad de Control = Fuerza Resultante = Fuerza Atraccion + Fuerza
V_control = F_atr + F_rep;
% Condicion de que la Velocidad de Control no supere la velocidad maxima
% del robot
if(norm(V_control)>robot.max_velocidad)
    V_control = V_control/norm(V_control)*robot.max_velocidad;
end
end