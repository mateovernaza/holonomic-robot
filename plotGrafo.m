function[]=plotGrafo(matAdy,nodos,grafico)
% plot aristas de grafo de visibilidad
for i=1:size(matAdy,1)-1
    for j=i+1:size(matAdy,1)
        if(matAdy(i,j)~=0)
            plot([nodos(i,1) nodos(j,1)],[nodos(i,2) nodos(j,2)],'b','Linewidth',0.7)
        end
    end
end
pause(grafico.tConectividad)
end