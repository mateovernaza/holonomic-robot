function [distancias]=sensor(knownObs,unknownObs,pos,robot,vecLidar)
distancias = zeros(size(vecLidar,1),1) + robot.rango_sensor;
for i=1:size(distancias,1)
    for j=1:size(knownObs,1)
       %     Producto cruz vecLidar X vecAristaObstaculo
       rXs = vecLidar(i,1)*knownObs(j,2) - vecLidar(i,2)*knownObs(j,1);
       %     Vector desde punto inicial vecAristaObstaculo (q) hacia punto
       %     incial vecLidar (p->pos)
       qp = knownObs(j,3:4) - pos;
       %     Proporcion en la que los vectores se cruzan de acuerdo a
       %     vecLidar
       t = (qp(1)*knownObs(j,2)-qp(2)*knownObs(j,1))/rXs;
       %     Proporcion en la que los vectores se cruzan de acuerdo a
       %     vecAristaObstaculo
       u = (qp(1)*vecLidar(i,2)-qp(2)*vecLidar(i,1))/rXs;
       %     Chequeo de interseccion de vector de lidar con algun vertice
       %     de algun obstaculo
       if(rXs~=0 && t>=0 && t<=1 && u>=0 && u<=1 && distancias(i)>robot.rango_sensor*t) 
           distancias(i) = robot.rango_sensor*t;
       end
    end
    for j=1:size(unknownObs,1)
        %     Producto cruz vecLidar X vecAristaObstaculo no conocido
       rXs = vecLidar(i,1)*unknownObs(j,2) - vecLidar(i,2)*unknownObs(j,1);
       %     Vector desde punto inicial vecAristaObstaculo no conocido (q) hacia punto
       %     incial vecLidar (p->pos)
       qp = unknownObs(j,3:4) - pos;
       %     Proporcion en la que los vectores se cruzan de acuerdo a
       %     vecLidar
       t = (qp(1)*unknownObs(j,2)-qp(2)*unknownObs(j,1))/rXs;
       %     Proporcion en la que los vectores se cruzan de acuerdo a
       %     vecAristaObstaculo
       u = (qp(1)*vecLidar(i,2)-qp(2)*vecLidar(i,1))/rXs;
       %     Chequeo de interseccion de vector de lidar con algun vertice
       %     de algun obstaculo
       if(rXs~=0 && t>=0 && t<=1 && u>=0 && u<=1 && distancias(i)>robot.rango_sensor*t) 
           distancias(i) = robot.rango_sensor*t;
       end
    end
end
end