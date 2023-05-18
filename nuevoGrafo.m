function[nodosNew,matAdyNew,matPesosNew] = nuevoGrafo(goals,nodos,matAdy,matPesos,vecObs,vertObs,coordIni,grafico)
% Nueva lista de nodos
nodosNew = [coordIni; goals; nodos];
nNodosNew = size(nodosNew,1);
nNodosAgregados = size(goals,1)+1;
% Nueva matriz de adyacencia     
matAdyNew = zeros(nNodosNew);
matAdyNew(nNodosAgregados+1:end,nNodosAgregados+1:end) = matAdy;
% Nueva matriz de pesos
matPesosNew = zeros(nNodosNew);
matPesosNew(nNodosAgregados+1:end,nNodosAgregados+1:end) = matPesos;
% Agregar nuevos nodos de metas a la matriz de adyacencia y a la matriz de
% pesos
for i=1:nNodosAgregados
    for j=i+1:nNodosNew
%         revisar si arista a agregar no tiene colision
        if(~vertColision2(nodosNew(i,:),nodosNew(j,:),vecObs,vertObs))
%             agregar a matriz de adyacencia y matriz de pesos
            matAdyNew(i,j) = j;
            matAdyNew(j,i) = i;
            matPesosNew(i,j) = norm(nodosNew(i,:)-nodosNew(j,:));
            matPesosNew(j,i) = matPesosNew(i,j);
%             plot aristas nuevas
            plot([nodosNew(i,1) nodosNew(j,1)],[nodosNew(i,2) nodosNew(j,2)],'b','Linewidth',0.7)
            pause(grafico.tConectividad)
        end
    end
end
end