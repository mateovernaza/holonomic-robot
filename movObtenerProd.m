function[pos,infr,h,dir]=movObtenerProd(meta,pos,vecSensores,knownVObs,unknownVObs,robot,infr,h,dir,grafico)
fin = true;
while fin
%     calculo de velocidad sin considerar repulsion
    [V_control,distSensores]=calcVelocidadNoRep(meta,pos,vecSensores,knownVObs,unknownVObs,robot);
    %     Actualizar posicion segun la velocidad -> equivalente a odometria
    pos = pos + V_control*robot.t_actualizacion;
    
%     plot robot
    [infr,h,dir] = graficoSimulacion(pos,V_control,distSensores,robot,grafico,infr,h,dir);
    
%     frame = getframe(gcf);
%     writeVideo(v,frame);
    
%     condicion de terminacion
    if(norm(meta-pos)<robot.dist_final)
        break
    end
end
% equivalente a movimiento de agarre de producto
fprintf('Tomando Producto\n')
% for i=1:2.22e3
%     frame = getframe(gcf);
%     writeVideo(v,frame);
% end
pause(2)
end