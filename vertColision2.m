% Adaptacion de algoritmo de Ronald Goldman para deteccion de interseccion de dos segmentos de linea
function [check]=vertColision2(nodo1,nodo2,vecObs,vertObs)
% generacion de vector de arista a analizar
vecVertice = [nodo2(1)-nodo1(1),nodo2(2)-nodo1(2)];
nObs = size(vecObs,1)/6;
for i=1:nObs
%     generacion de vectores y puntos de obstaculo, 1 vector por cada arista del obstaculo 
%     y dos vectores diagonales que atraviesan el obstaculo para analizar si arista
%     de grafo no se cruza dentro del obstaculo
    vecs = vecObs(i*6-5:i*6,:);
    verts = vertObs(i*6-5:i*6,:);
%     deteccion de colision
    countCheck = 0;
    for j = 1:size(vecs,1)
%         verificacion de arista de grafo no cruza por dentro de obstaculos
        if(((vecs(j,1)==nodo1(1)&&vecs(j,2)==nodo1(2))||(vecs(j,1)==nodo2(1)&&vecs(j,2)==nodo2(2))) && (nodo1(1)~=nodo2(1)&&nodo1(2)~=nodo2(2)))
            countCheck = countCheck + 1;
        end
%         algoritmo de Ronald Goldman para deteccion de interseccion
        a = verts(j,:)-nodo1;
        b = modCross(vecVertice,vecs(j,:));
        t = modCross(a,vecs(j,:))/b;
        u = modCross(a,vecVertice)/b;
        if(b~=0 && t>0 && t<1 && u>0 && u<1)
            check = true;
            return
        end
    end
    if(countCheck>=2)
        check = true;
        return
    end
end
check = false;
end