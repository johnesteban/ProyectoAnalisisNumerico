%Punto fijo: se ingresa el valor inicial (x0), la tolerancia del error
%(Tol), el máximo número de iteraciones (niter) y la función
%Devuelve las iteraciones, el xn encontrado, f(xn) y el error.
%[c,xn,fe,error]=pf(1,0.5e-1,20,sin(x)-x+2)
function [c,xn,fe,error] = pf(x0,Tol,niter,f)
    format long
    syms x
    g=f+x; %se establece la función g(x)
    c=0; %iteración
    fe=eval(subs(f,x0));  %evalua la función f(x0)
    error=Tol+1; %primer error, arbitrario;
    arregloiteraciones=[c];
    arreglox=[x0];
    arreglofx=[fe];
    arregloerror=[error]; %agrega todo esto para la tabla
    while error>Tol && fe~=0 && c<niter 
        xn=eval(subs(g,x0)); %xn=g(x0)
        fe=eval(subs(f,xn)); %f(xn)
        error=abs(xn-x0); %error
        %con cifras significativas: error=abs((xn-x0)/xn)
        x0=xn; %establece el nuevo x0 para la siguiente iteracion 
        c=c+1;
        arregloiteraciones=[arregloiteraciones,c];
        arreglox=[arreglox,x0];
        arreglofx=[arreglofx,fe];
        arregloerror=[arregloerror,error];
    end
    if fe==0 %si f(xn)=0, ya se llego a la solucion
        xn=x0;
        c=c;
        fprintf('%f es raiz de f(x)',x0)
    elseif error<Tol
        xn=x0;
        c=c;
        fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',x0,Tol)
    else 
        xn=x0;
        c=c;
        fprintf('Fracasó en %f iteraciones',niter) 
    end   
    table(arregloiteraciones',arreglox',arreglofx',arregloerror','VariableNames',{'n','x','f(x)','Error'})
end