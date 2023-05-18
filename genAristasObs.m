function [vecsObs,pointsObs]=genAristasObs(grownObs,grownLimites)
% Generacion vectores y puntos de obstaculos
nGrownObs = size(grownObs,1);
for i=1:nGrownObs
    vecsObs(i*6-5:i*6,:) = [0,grownObs(i,4)-grownObs(i,3)
                         grownObs(i,2)-grownObs(i,1),0
                         0,grownObs(i,3)-grownObs(i,4)
                         grownObs(i,1)-grownObs(i,2),0
                         grownObs(i,2)-grownObs(i,1),grownObs(i,4)-grownObs(i,3)
                         grownObs(i,1)-grownObs(i,2),grownObs(i,4)-grownObs(i,3)];   
    pointsObs(i*6-5:i*6,:) = [grownObs(i,1),grownObs(i,3)
                     grownObs(i,1),grownObs(i,4)
                     grownObs(i,2),grownObs(i,4)
                     grownObs(i,2),grownObs(i,3)
                     grownObs(i,1),grownObs(i,3)
                     grownObs(i,2),grownObs(i,3)];
end
vecsObs((i+1)*6-5:(i+1)*6,:) = [0,grownLimites(4)-grownLimites(3)
                                grownLimites(2)-grownLimites(1),0
                                0,grownLimites(3)-grownLimites(4)
                                grownLimites(1)-grownLimites(2),0
                                0,0
                                0,0];
pointsObs((i+1)*6-5:(i+1)*6,:) = [grownLimites(1),grownLimites(3)
                 grownLimites(1),grownLimites(4)
                 grownLimites(2),grownLimites(4)
                 grownLimites(2),grownLimites(3)
                 grownLimites(1),grownLimites(3)
                 grownLimites(2),grownLimites(3)];    
end