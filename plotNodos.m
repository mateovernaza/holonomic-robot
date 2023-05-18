function[]=plotNodos(nodos,grafico)
% Graficar nodos
for i = 1:size(nodos,1)
    plot(nodos(i,1),nodos(i,2),'ro','LineWidth', 2)
end
pause(grafico.tNodos)
end