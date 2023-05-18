function [V_control,distSensores]=calcVelocidadNoRep(meta,pos,vecSensores,knownVObs,unknownVObs,robot)
% Fuerza de atraccion
F_atr = atraccion(meta,pos,robot);
% Distancias obtenidas por los sensores
distSensores = sensor(knownVObs,unknownVObs,pos,robot,vecSensores);
% Velocidad de Control = Fuerza Resultanto = Fuerza Atraccion
V_control = F_atr;
% Condicion de que la Velocidad de Control no supere la velocidad maxima
% del robot
if(norm(V_control)>robot.max_velocidad)
    V_control = V_control/norm(V_control)*robot.max_velocidad;
end
end