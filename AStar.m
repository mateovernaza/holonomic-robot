% Algoritmo A* para busqueda en grafos
function [camino,costoTotal] = AStar(pesosMat, nodos, nIni, nFin)
% Se calcula el costo heuristico, en este caso es la distancia euclidiana
% hacia la meta o nodo final
heuristica = zeros(size(pesosMat,1),1);
for i=1:size(pesosMat,1)
    heuristica(i) = sqrt((nodos(i,1)-nodos(nFin,1))^2+(nodos(i,2)-nodos(nFin,2))^2);
end
% Se crea lista de nodos revisados y la lista de nodos no revisados
% inicializado con el nodo inicial
nodosRevisados = [];
nodosNoRevisados = [nIni];
% Se inicializa la lista de costos minimos encontrados hasta el momento
% para cada nodo, al comienzo todos menos el nodo inicial tienen un costo
% infinito
minCost(1:size(nodos,1)) = inf;
minCost(nIni) = 0;
% Se crea la lista que almacena cual es el padre de cada nodo en el arbol
arbol = zeros(size(nodos,1),1);
% Se crea una lista de costos estimados que inicialmente es infinita
costoEstimado(1:size(nodos,1)) = inf;
% Se ejecuta el programa hasta que la lista de revisados este vacia
while ~isempty(nodosNoRevisados)
%     Se elige el nodo en la primera posicion de los nodos no revisados
%     para analizarlo
    current = nodosNoRevisados(1);
%     Se agrega el nodo a la lista de revisados
    nodosRevisados = [nodosRevisados, current];
%     Se borra el nodo de la lista de no revisados
    nodosNoRevisados = nodosNoRevisados(nodosNoRevisados~=current);
%     Si el nodo que se esta analizando es igual al nodo final se termina
%     el algoritmo
    if(current == nFin)
        break
    end
%     Se analiza todo vecino del nodo que se esta evaluando
    for vecino=1:size(pesosMat,1)
%         Se chequea cual nodo es vecino y si no esta en los nodos
%         revisados
        if((pesosMat(current,vecino)~=0||(nodos(current,1)==nodos(vecino,1)&&nodos(current,2)==nodos(vecino,2)))&& ~ismember(vecino,nodosRevisados))
%             Se almacena un costo temporal que es el costo en ir al nodo
%             vecino desde el camino mas corto hasta el nodo actual
            costoTemporal = minCost(current)+pesosMat(current,vecino);
%             Si este camino es mas barato que el camino anteriormente
%             almacenado se reemplaza como el mejor camino hasta el nodo
%             vecino
            if(costoTemporal < minCost(vecino))
%                 Se actualiza el nuevo mejor costo para llegar al nodo
%                 vecino
                minCost(vecino) = costoTemporal;
%                 Se actualiza el arbol donde se especifica que el padre
%                 del nodo vecino es el nodo actualmente analizado
                arbol(vecino) = current;
%                 Se agrega el nodo vecino a nodos no revisados para ser
%                 eventualmente revisado, pero se lo agrega de acuerdo al
%                 costo estimado que tienen para llegar al nodo final
%                 mediante el costo heuristico. Se ordena de menor a mayor,
                costoEstimado(vecino) = minCost(vecino)+heuristica(vecino);
                if(isempty(nodosNoRevisados))
                    nodosNoRevisados = vecino;
                else
                    pos = 1;
%                     Se busca la posicion en la que el nodo vecino se
%                     inserta en la lista de no revisados
                    while pos <= size(nodosNoRevisados,2) && costoEstimado(vecino) > costoEstimado(nodosNoRevisados(pos))
                        pos = pos + 1;
                    end
                    nodosNoRevisados = [nodosNoRevisados(1:pos-1), vecino, nodosNoRevisados(pos:end)];
                end
            end
        end
    end
end
% Recursividad para hallar el camino a partir del arbol
camino = nFin;
while(camino(1) ~= nIni)
    if arbol(camino(1)) == 0
        error('No se encontraron caminos')
    else 
        camino = [arbol(camino(1)); camino];
    end
end
% se retorna el camino de nodos para llegar a la meta y el costo total
camino(camino==nIni) = [];
costoTotal = minCost(nFin);
end