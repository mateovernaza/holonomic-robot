function [posPrev,posProd,productos] = genPosProductos(robot,productos)
% generar posicion previa para agarrar producto [posPrev]=[x y direccion]
% y posicion para agarrar producto considerando radio de robot [posProd]=[x y direccion nivel]
nProductos = size(productos.id,1);
posPrev = zeros(nProductos,3);
posProd = zeros(nProductos,4);
for i=1:nProductos
    posPrev(i,:) = [productos.pose(i,1:2)+[-cos(productos.pose(i,3)) -sin(productos.pose(i,3))]*robot.offset,productos.pose(i,3)];
    posProd(i,:) = [productos.pose(i,1:2)+[-cos(productos.pose(i,3)) -sin(productos.pose(i,3))]*(robot.dist_estante),productos.pose(i,3),productos.nivel(i)];
end
% guardar variables en documentos
fileID = fopen('docs/posPrev.txt','w');
fprintf(fileID,'%f %f %f\n',posPrev');
fclose(fileID);
fileID = fopen('docs/posProd.txt','w');
fprintf(fileID,'%f %f %f %d\n',posProd');
fclose(fileID);
end