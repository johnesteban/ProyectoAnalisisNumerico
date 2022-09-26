%Búsquedas incrementales: se ingresa el valor inicial de x (x0), el tamaño de paso(Delta), el máximo número de iteraciones (niter) y la función. 
%La salida es la tabla, solución e intervalo donde se encuentra solución.
function [solucion,c] = Bi(x0,Delta,niter,f)
    format long
    %syms x
    f0=eval(subs(f,x0)); %evalua la función en el punto inicial 
    arregloiteraciones=[0];  %Iteración 0. 
    arreglox=[x0];
    arreglofx=[f0]; 
    %n/a, el primer error no existe, se pone un numero grande
    if f0==0 %si la función evaluada en el punto inicial da 0, es decir f(x)=0, esto quiere decir que x es una raíz de la función
        solucion=x0;
        fprintf('%f es raiz de f(x)',x0)
    else
        x1=x0+Delta; %fórmula para generar xn=xn-1+Delta
        c=1;         %contador
        f1=eval(subs(f,x1)); %evaluamos la función en x1
        arregloiteraciones=[arregloiteraciones,c];   %agregamos iteración para la tabla
        arreglox=[arreglox,x1];  %agregamos x1 para la tabla
        arreglofx=[arreglofx,f1];  %agregamos f(x1) para la tabla
        while f0*f1>0 && c<=niter    %si f0*f1>0, es porque tienen signos iguales y por tanto no ha cruzado por una raíz, hasta el numero de iteraciones establecido
            x0=x1; %el nuevo x0 será el x1
            f0=f1; %f0 para luego volver a evaluar la condiciones f0*f1, ya que luego sería f1*f2  
            x1=x0+Delta; %el nuevo x1 (o xn) se construye así
            f1=eval(subs(f,x1));  %evaluamos f(xn)
            c=c+1; %aumentamos la iteracion
            arregloiteraciones=[arregloiteraciones,c];
            arreglox=[arreglox,x1];
            arreglofx=[arreglofx,f1]; %agregamos todo a la tabla
        end
        if f1==0             %si se rompe el while tal vez es que f1==0, lo que quiere decir que x1 en ese momento es una raíz
            solucion=x1;
            fprintf('%f es raiz de f(x)',x1)
        elseif f0*f1<0                             %si realmente f0*f1 es menor que 0 es que hay una raíz en el intervalo
            solucion=x1;
            fprintf('Existe una raiz de f(x) entre %f y %f',x0,x1)
        else                                       % si no se logra llegar a nada con el número de iteraciones establecido 
           solucion=x1;
           fprintf('Fracasó en %f iteraciones',niter) 
        end
    end
    table(arregloiteraciones',arreglox',arreglofx','VariableNames',{'n','x','f(x)'})
end