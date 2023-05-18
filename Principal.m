clc
clf
format long
% %% Video
% v = VideoWriter('Simulacion','MPEG-4');
% v.Quality = 95;
% open(v);
%% Parametros
docEntorno = 'EntornoV1.0';
% docEntorno = 'EntornoV2.0';
% Cargar parametros del Entorno
entorno.limites = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range','A2:A5');
rangoFin = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range','K2:K2');
if rangoFin(1) > 0
    rangoStr = strcat('L2:O',num2str(1+rangoFin(1)));
    entorno.obstaculosCon = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
else
    entorno.obstaculosCon = [];
end
rangoFin = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range','P2:P2');
if rangoFin(1) > 0
    rangoStr = strcat('Q2:T',num2str(1+rangoFin(1)));
    entorno.obstaculosDesc = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
else 
    entorno.obstaculosDesc = [];
end
% Cargar parametros de los productos
rangoFin = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range','B2:B2');
if rangoFin(1) > 0
    rangoStr = strcat('C2:E',num2str(1+rangoFin(1)));
    productos.pose = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
    rangoStr = strcat('F2:F',num2str(1+rangoFin(1)));
    productos.id = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
    rangoStr = strcat('G2:G',num2str(1+rangoFin(1)));
    productos.nombre = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr,'OutputType','string');
    rangoStr = strcat('H2:H',num2str(1+rangoFin(1)));
    productos.precio = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
    rangoStr = strcat('I2:I',num2str(1+rangoFin(1)));
    productos.nivel = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
    rangoStr = strcat('J2:J',num2str(1+rangoFin(1)));
    productos.pasillo = readmatrix('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
end
% Escribir a archivo
rangoStr = strcat('C1:J',num2str(1+rangoFin(1)));
T = readtable('Entornos.xlsx','Sheet',docEntorno,'Range',rangoStr);
writetable(T,'docs/productos.csv')
% Cargar parametros del robot
load('RobotV1.0.mat')
% load('RobotV2.0.mat')
% radio_robot = en mm
% n_sensores = numero de sensores ultrasonicos
% rango_sensor = rango de deteccion de obstaculosCon para repulsion en mm
% max_velocidad = velocidad lineal maxima en mm/s
% c_atraccion = constante de desaceleracion en mm
% max_velocidad_angular = velocidad angular maxima en rad/s
% c_atraccion_angular = constante de desaceleracion en rad
% c_repulsion = constante de repulsion
% c_filtro_ema = constante para filtro EMA para mediciones de sensores
% dist_final = error maximo de posicion en mm
% ang_final = error de orientacion maximo en rad
% dist_estante = distancia a posicion de recoleccion de producto en mm
% radio_rueda = radio de las ruedas en mm
% l = largo del robot desde punto de contacto de la rueda hasta centro geometrico en mm
% w = ancho del robot desde punto de contacto de la rueda hasta centro geometrico en mm
% coord_ini = [x y] coordenadas iniciales en mm
% t_actualizacion = 0.1
%% Funcion para leer y calcular variables iniciales
[entorno,grownObs,grownLimites,vecsObs,pointsObs,nodos,matAdy,matPesos,posPrev,posProd,productos] = leerDocs(robot,entorno,productos);
%% Figura
load GraficoV1.1.mat grafico
fig = figure(1);
maxTamano = max(entorno.limites(2),entorno.limites(4));
set(gcf,'position',[600 10 1000*entorno.limites(2)/maxTamano 1000*entorno.limites(2)/maxTamano])
axis([entorno.limites(1)-maxTamano/1e3 entorno.limites(2)+maxTamano/1e3 entorno.limites(3)-maxTamano/1e3 entorno.limites(4)+maxTamano/1e3]);
hold on
% plot obstaculosCon y limites
plotObs(entorno.obstaculosCon,grownObs,grownLimites,grafico);
% plot nodos
plotNodos(nodos,grafico);
% plot grafo de visibilidad
plotGrafo(matAdy,nodos,grafico)
% plot punto inicial del robot
plot(robot.coord_ini(1),robot.coord_ini(2),'go','LineWidth', 3)
%% Programa Principal
% Ingreso de pedidos
disp('PRODUCTOS DISPONIBLES:')
for i = 1:size(productos.id,1)
    disp(strcat("ID: ",num2str(productos.id(i))," Producto: ",productos.nombre(i)," Posicion: [",num2str(productos.pose(i,1))," ",num2str(productos.pose(i,2)),"]"));
end
% productos pedidos de pagina web
prodPedidos = input("Ingrese vector de IDs de productos pedidos: ");
while true
    % obtener posiciones previas a agarrar los productos pedidos
    goals = zeros(size(prodPedidos,2),2);
    for i=1:size(goals,1)
        goals(i,:) = [posPrev(prodPedidos(i),1),posPrev(prodPedidos(i),2)];
        %   plot metas de productos pedidos
        plot(goals(i,1),goals(i,2),'go','LineWidth', 3)
        pause(grafico.tGoals)
    end
    % generar nuevo grafo de visibilidad agregando posicion inicial y metas de los productos
    [nodosNew,matAdyNew,matPesosNew] = nuevoGrafo(goals,nodos,matAdy,matPesos,vecsObs,pointsObs,robot.coord_ini,grafico);
    % generar mejorar trayectoria que pase por todas las metas
    [camino,goalsOrder]=trayectoria(goals,matPesosNew,nodosNew,grafico);
    
    % Para simulacion se genera vectores de obstaculosCon conocidos y desconocidos
    % para calcular distancia con los sensores simulados
    [knownVObs,unknownVObs]=obstDesconocidos(entorno.obstaculosCon,entorno.obstaculosDesc);
    % generar vector de sensores
    vecSensores = genVecSensores(robot);
    % variables para simulacion
    infr=[];
    h=[];
    dir=[];

    % posicion inicial
    pos = nodosNew(camino(1),:);
    % Nodo siguiente en la ruta
    contCamino = 2;
    % contador de metas
    contGoals = 1;
    fin = true;
    while fin
    %     calculo de velocidad
        [V_control,distSensores]=calcVelocidad(camino,nodosNew,contCamino,pos,vecSensores,knownVObs,unknownVObs,robot);
    %     Actualizar posicion segun la velocidad -> equivalente a odometria
        pos = pos + V_control*robot.t_actualizacion;

    %     plot robot
        [infr,h,dir] = graficoSimulacion(pos,V_control,distSensores,robot,grafico,infr,h,dir);
        
%         frame = getframe(fig);
%         writeVideo(v,frame);
        
    %     condicion de terminacion
        if(contCamino == size(camino,1) && norm(nodosNew(camino(contCamino),:)-pos)<robot.dist_final)
%             close(v);
            return
        end
    %     chequeo para avanzar a siguiente meta
        [contCamino,contGoals,pos,infr,h,dir]=siguienteGoal(nodosNew,contCamino,camino,pos,contGoals,goalsOrder,posProd,prodPedidos,robot,vecSensores,knownVObs,unknownVObs,infr,h,dir,grafico);
    end
end
