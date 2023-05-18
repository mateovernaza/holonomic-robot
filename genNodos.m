% Generacion de nodos en esquinas de obstaculos y limites
function [nodos]=genNodos(pointsObs,limites)
nObs = size(pointsObs,1)/6;
nodos = zeros(nObs*4,2);
% generacion de nodos
for i = 1:nObs
    for j = 1:4
        nodos(j+(i-1)*4,:) = [pointsObs(j+(i-1)*6,1),pointsObs(j+(i-1)*6,2)];
    end
end
j = 1;
% eliminar nodos que se encuentran afuera de los limites del entorno
while j<= size(nodos,1)
    if(nodos(j,1)<limites(1)||nodos(j,1)>limites(2)||nodos(j,2)<limites(3)||nodos(j,2)>limites(4))
        nodos(j,:) = [];
    else
        j = j + 1;
    end
end
end