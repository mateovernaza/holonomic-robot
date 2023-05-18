function [matAdy,matPesos]=conectividad(nodos,vecsObs,pointsObs)
nNodos = size(nodos,1);
% generar matriz de adyacencia y matriz de pesos
matAdy = zeros(nNodos);
matPesos = zeros(nNodos); 
for i = 1:nNodos-1
    for j = i+1:nNodos
%         revisar si existe colision
        if(~vertColision2(nodos(i,:),nodos(j,:),vecsObs,pointsObs))
%             agregar nodos a matriz de adyacencia y de pesos
            matAdy(i,j) = j;
            matAdy(j,i) = i;
            matPesos(i,j) = norm(nodos(i,:)-nodos(j,:));
            matPesos(j,i) = matPesos(i,j);
        end
    end
end
end