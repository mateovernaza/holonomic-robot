function [infr,h,dir]=graficoSimulacion(pos,V_control,sensores,robot,grafico,infr,h,dir)
% se borra grafico anterior
deleteGrafico(infr,h,dir)
% Se grafica cada sensor
for k=0:size(sensores,1)-1
    infr(k+1) = plot([pos(1) pos(1)+cos(2*pi/robot.n_sensores*k)*sensores(k+1)],[pos(2) pos(2)+sin(2*pi/robot.n_sensores*k)*sensores(k+1)],'r','LineWidth',1);
end
% plot robot
h = circle(pos(1),pos(2),robot.radio_robot);
% Graficar la direccion y magnitud de velocidad
dir = plot([pos(1) pos(1)+V_control(1)*10],[pos(2) pos(2)+V_control(2)*10],'blue','LineWidth',3);
pause(grafico.tSimulacion)
end