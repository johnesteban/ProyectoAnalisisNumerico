%Bisección: se ingresa el valor inicial y final del intervalo (xi, xs), la tolerancia del error (Tol), el máximo nùmero de iteraciones (niter) y la función. 
%Devuelve la tabla, la solución, el error y la función evaluada en ese
%xsolución.
%[s,error,fe]=Biseccion(0,1.9,0.5e-3,20,x^2-1)
function [s,error,fe] = Biseccion(xi,xs,Tol,niter,f)
    format long
    fi=eval(subs(f,xi)); %evalua la función en el inicio del intervalo
    fs=eval(subs(f,xs)); %evalua la función en el final del intervalo
    arregloiteraciones=[];
    arreglox=[];
    arreglofx=[];
    arregloerrores=[];
    if fi==0  %si en el inicio del intervalo la función es 0, esto quiere decir que xi es una raíz.
        s=xi; 
        error=0; %error sería 0
        fprintf('%f es raiz de f(x)',xi)
    elseif fs==0   %si en el final del intervalo la función es 0, esto quiere decir que xs es una raíz.
        s=xs; 
        error=0; 
        fprintf('%f es raiz de f(x)',xs)
    elseif fs*fi<0 %si f(xs)*f(xi)<0, es decir que en el intervalo se encuentra la raíz
        c=0; %iteracion 0
        xm=(xi+xs)/2; %xn1=(a+b)/2
        fe=eval(subs(f,xm)); %se evalua la función
        error=Tol+1; %error en la primera iteracion valor arbitrario 
        arregloiteraciones=[arregloiteraciones,c];
        arreglox=[arreglox,xm];
        arreglofx=[arreglofx,fe];
        arregloerrores=[arregloerrores,error]; %para agregar estos valores a la tabla
        while error>Tol && fe~=0 && c<niter %mientras el error sea mayor a la tolerancia y no se sobrepasen el numero de iteraciones
            if fi*fe<0 %f inicial por f(xn) es menor a 0, es decir la solución se encuentra entre xi y xn
                xs=xm; %el final del nuevo intervalo será xn
                fs=eval(subs(f,xs)); %evalua la función en ese punto, ese será el nuevo f(xs) 
            else
                xi=xm; %el inicio del intervalo siguiente será xn
                fi=eval(subs(f,xi)); %evalua la función en ese punto, será el nuevo f(xi)
            end
            xa=xm; %para guardar el xn-1 para la siguiente iteración 
            xm=(xi+xs)/2; %genera el nuevo xn
            fe=eval(subs(f,xm)); %evalua ese f(xn)
            error=abs(xm-xa); %error
            c=c+1; %iteracion
            arregloiteraciones=[arregloiteraciones,c];
            arreglox=[arreglox,xm];
            arreglofx=[arreglofx,fe];
            arregloerrores=[arregloerrores,error]; %para agregar a la tabla
        end
        if fe==0 %si f(xn)=0, quiere decir que xn es la raíz
           s=xm;
           fprintf('%f es raiz de f(x)',xm) 
        elseif error<Tol %si se llega a la solución.
           s=xm;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',xm,Tol)
        else  %si no se cumple con las iteraciones establecidas
           s=xm;
           fprintf('Fracasó en %f iteraciones',niter) 
        end
    else  %si en el intervalo dado no se encuentra la raíz de la función
       fprintf('El intervalo es inadecuado')         
    end    
    table(arregloiteraciones',arreglox',arreglofx',arregloerrores','VariableNames',{'n','x','f(x)','Error'})
end