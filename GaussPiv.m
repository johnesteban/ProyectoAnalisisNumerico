%GaussPiv: Calcula la solución de un sistema de ecuaciones Ax=b, ya sea
%sin pivoteo piv=0, usando pivoteo parcial piv=1 o pivoteo total piv=2. 
%Donde A es de tamaño nxn (matriz de coeficientes) y b de tamaño nx1
%(matriz de constantes)

function [x, mark] = GaussPiv(A,b,n,Piv)
    Ab=[A b]; %concatena matriz A y matriz b
    mark=1:1:n; %1,2,3.. hasta el tamaño de la matriz
    for k=1:n-1 
        if Piv==1
            Ab=pivpar(Ab,n,k); %realiza pivoteo parcial
        elseif Piv==2
            [Ab, mark]=pivtot(Ab,mark,n,k); %realiza pivoteo total
        end
        for i=k+1:n
            M=Ab(i,k)/Ab(k,k); %encuentra los multiplicadores
            for j=k:n+1
                Ab(i,j)=Ab(i,j)-M*Ab(k,j); %se realiza pivoteo simple, operacion filas. 
            end
        end
    end
    x=sustreg(Ab,n); %se realiza sustitución regresiva para encontrar las soluciones con la matriz pivoteada 
end
%error=A*x-b
%si es pivoteo total sería= A*xord-b
%se saca la norma de este error. Error=norm(error,(3,5,inf..))