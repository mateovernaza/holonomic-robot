function [contCamino,contGoals,pos,infr,h,dir, v]=siguienteGoal(nodosNew,contCamino,camino,pos,contGoals,goalsOrder,posProd,prodPedidos,robot,vecSensores,knownVObs,unknownVObs,infr,h,dir,grafico, v)
% se calcula la distancia hacia la meta actual
dGoalActual = norm(nodosNew(camino(contCamino),:)-pos);
% si la distancia es menor a condicion establecida
if(dGoalActual<robot.dist_final)
%     si el nodo actual es un nodo de la meta del producto pedido
    if(camino(contCamino) == goalsOrder(contGoals))
%         equivalente de movimiento de mecanismo de agarre al nivel del producto
        str = strcat('Mecanismo Nivel'," ",num2str(posProd(goalsOrder(contGoals)-1,4)),'\n');
        fprintf(str)
        pause(4)
%         movimiento del robot hacia posicion para agarrar al producto, no
%         se considera fuerza de repulsion ya que el robot se acerca mucho
%         a estantes
        [pos,infr,h,dir] = movObtenerProd(posProd(prodPedidos(goalsOrder(contGoals)-1),1:2),pos,vecSensores,knownVObs,unknownVObs,robot,infr,h,dir,grafico);
%         se aumenta contador de metas de productos pedidos
        contGoals = contGoals + 1;
    end
%     se aumenta contador de camino de trayectoria general
    contCamino = contCamino + 1;
end
end