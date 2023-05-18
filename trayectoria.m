function [camino,goalsOrder]=trayectoria(goals,matPesosNew,nodosNew,grafico)
nGoals = size(goals,1);
% nodo inicial de trayectoria
Ini = 1;
% camino comienza en nodo 1
camino = [1];
goalsNoRevisados = 2:nGoals+1;
goalsOrder = [];
% bucle analiza todas las metas
while ~isempty(goalsNoRevisados)
%     comienza con un costo infinito a la meta mas cercana
    costo = inf;
%     se analiza todas las metas para obtener el costo mas bajo
    for i=1:nGoals
        % Algoritmo de Busqueda A*
        [caminoTemp,costoTemp] = AStar(matPesosNew, nodosNew, Ini, goalsNoRevisados(i));
%         si el costo calculado para la meta actual es mejor que el costo anterior
%         se reemplaza como la mejor meta para ir
        if(costoTemp < costo)
            costo = costoTemp;
            goalTemp = goalsNoRevisados(i);
            caminoTempM = caminoTemp;
        end
    end
%     se agrega el mejor camino encontrado
    camino = [camino; caminoTempM];
%     se elimina la mejor meta de la lista de no revisados
    goalsNoRevisados(goalsNoRevisados==goalTemp)=[];
%     se agrega la meta en la lista que indica el orden de las metas a visitar
    goalsOrder = [goalsOrder, goalTemp];
%     nodo inicial se convierte en la ultima meta
    Ini = goalTemp;
    nGoals = nGoals - 1;
end 
% calculo de camino para regresar a las coordenadas iniciales del robot
[caminoTemp,costoTemp] = AStar(matPesosNew, nodosNew, Ini, 1);
camino = [camino; caminoTemp];
goalsOrder = [goalsOrder, 1];
% plot trayectoria para visitar todas las metas a los productos pedidos
for i=1:size(camino,1)-1
    plot([nodosNew(camino(i),1) nodosNew(camino(i+1),1)],[nodosNew(camino(i),2) nodosNew(camino(i+1),2)],'red','Linewidth',2)
    pause(grafico.tPath) 
end
end