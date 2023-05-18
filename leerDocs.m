function [entorno,grownObs,grownLimites,vecsObs,pointsObs,nodos,matAdy,matPesos,posPrev,posProd,productos]=leerDocs(robot,entorno,productos)
% guardar variables en documentos
fileID = fopen('docs/limites.txt','w');
fprintf(fileID,'%f %f %f %f\n',entorno.limites');
fclose(fileID);     
% generacion de posiciones previas a agarrar productos [posPrev]=[x y direccion] y 
% posiciones para agarrar los productos [posProd]=[x y direccion nivel]
[posPrev,posProd,productos] = genPosProductos(robot,productos);
% agrandar obstaculosCon y limites del entorno
grownObs = [entorno.obstaculosCon(:,1)-robot.offset entorno.obstaculosCon(:,2)+robot.offset entorno.obstaculosCon(:,3)-robot.offset entorno.obstaculosCon(:,4)+robot.offset];
grownLimites = [entorno.limites(1)+robot.offset entorno.limites(2)-robot.offset entorno.limites(3)+robot.offset entorno.limites(4)-robot.offset];
% Generacion de aristas de obstaculosCon
[vecsObs,pointsObs] = genAristasObs(grownObs,grownLimites);
% guardar variables en documentos
fileID = fopen('docs/vecsObstaculos.txt','w');
fprintf(fileID,'%f %f\n',vecsObs');
fclose(fileID);     
fileID = fopen('docs/pointsObstaculos.txt','w');
fprintf(fileID,'%f %f\n',pointsObs');
fclose(fileID);              
% generar nodos de grafo de visibilidad
[nodos]=genNodos(pointsObs,entorno.limites);
% guardar variable en documento
fileID = fopen('docs/nodos.txt','w');
fprintf(fileID,'%f %f\n',nodos');
fclose(fileID);
% generar grafo de visibilidad analizando conectividad entre nodos
[matAdy,matPesos] = conectividad(nodos,vecsObs,pointsObs);
% guardar variables en documentos
str = '';
for i=1:size(matAdy,1)
    if(i ~= size(matAdy))
        str = strcat(str,'%f'," ");
    else
        str = strcat(str,'%f');
    end
end
str = strcat(str,'\n');
fileID = fopen('docs/matPesos.txt','w');
fprintf(fileID,str,matPesos');
fclose(fileID);
end