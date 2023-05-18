function [Fatr] = atraccion(goal,pos,robot)
% calculo de fuerza de atraccion
F = robot.max_velocidad*(1-exp(-(norm(goal-pos)/robot.c_atraccion)));
if(norm(goal-pos)~=0)
    Fatr = F*((goal-pos)/norm(goal-pos));
end
end