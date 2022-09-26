%Newton: se ingresa el valor inicial (x0), la tolerancia del error (Tol),
%el máximo número de iteraciones (niter) y la función.
%devuelve iteraciones, xn (solución), f(xn), f'(xn) y error.
%[c,xn,fe,dfe,error]= newton(4,0.5*10^-5,6,exp(-x)-x^2+5*x)
function [c,xn,fe,dfe,error] = newton(x0,Tol,niter,f)
        format long
        df=diff(f); %derivada de la funcion
        c=0; %iteracion
        fe=eval(subs(f,x0)); %f(x0)
        dfe=eval(subs(df,x0)); %f'(x0)
        error=Tol+1; %error inicial, arbitrario
        arregloiteraciones=[c];
        arreglox=[x0];
        arreglofx=[fe];
        arreglodfx=[dfe];
        arregloerror=[error]; %todo esto es para la tabla
        while error>Tol && c<=niter
            xn=x0-fe/dfe; %xn+1=xn-f(xn)/f'(xn)
            fe=eval(subs(f,xn)); %f(xn+1)
            dfe=eval(subs(df,xn)); %f'(xn+1) 
            error=abs(xn-x0);
            %con cifras significativas: abs((xn-x0)/xn)
            x0=xn; %nuevo x0 para la siguiente iteracion
            c=c+1; %aumenta las iteraciones
            arregloiteraciones=[arregloiteraciones,c];
            arreglox=[arreglox,xn];
            arreglofx=[arreglofx,fe];
            arreglodfx=[arreglodfx,dfe];
            arregloerror=[arregloerror,error]; %para la tabla
        end
        if fe==0 %si fe==0, esto quiere decir que f(xn) es la raíz
           xn=x0;
           fprintf('%f es raiz de f(x) \n',x0)
        elseif error<Tol %si se sale del while, es decir error<Tol, se llega a la solucion aproximada
           xn=x0;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f \n',x0,Tol)
        elseif dfe==0 %si la derivada en xn es 0
           xn=x0;
           fprintf('%f es una posible raiz múltiple de f(x) \n',x0)
        else 
           xn=x0;
           fprintf('Fracasó en %f iteraciones \n',niter) 
        end
        table(arregloiteraciones',arreglox',arreglofx',arreglodfx',arregloerror','VariableNames',{'n','x','fx','dfx','Error'})
end