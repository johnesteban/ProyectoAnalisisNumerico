%Raíces múltiples: se ingresa el valor inicial (x0), la tolerancia del error (Tol), 
% el màximo número de iteraciones (niter) y la función. 
%Se devuelve el número de iteraciones, xn, f(xn), f'(xn), f''(xn) y el
%error
%[c,xn,fe,dfe,dffe,error]=raicesMultiples(0,0.5*10^-6,9,(x-5)^2)
function [c,xn,fe,dfe,dffe,error] = raicesMultiples(x0,Tol,niter,f)
        format long
        %f=sin(2*x)-(x/(3))^3+0.1; %funcion
        df=diff(f); %derivada de la funcion
        dff=diff(df); %segunda derivada
        c=0; %iteracion
        fe=eval(subs(f,x0)); %f(xn)
        dfe=eval(subs(df,x0)); %f'(x0)
        dffe = eval(subs(dff,x0)); %f''(x0)
        error=Tol+1; %primer error arbitrario
        arregloiteraciones=[c];
        arreglox=[x0];
        arreglofx=[fe];
        arreglodfx=[dfe];
        arreglodffx=[dffe];
        arregloerror=[error];
        while error>Tol && c<=niter && fe~=0 && dfe~=0
            xn=x0-(fe*dfe)/(dfe^2-fe*dffe); %xn+1=xn-[f(xn)*f'(xn)]/[(f'(xn))^2-f(xn)f''(xn)]
            fe=eval(subs(f,xn)); %f(xn)
            dfe=eval(subs(df,xn)); %f'(xn)
            dffe=eval(subs(dff,xn)); %f''(xn)
            error=abs(xn-x0); 
            %con cifras significativas: error= abs((xn-x0)/xn)
            x0=xn; %para la siguiente iteración
            c=c+1;
            arregloiteraciones=[arregloiteraciones,c];
            arreglox=[arreglox,xn];
            arreglofx=[arreglofx,fe];
            arreglodfx=[arreglodfx,dfe];
            arreglodffx=[arreglodffx,dffe];
            arregloerror=[arregloerror,error]; %para agregar a la tabla
        end
        if fe==0
           xn=x0;
           fprintf('%f es raiz de f(x) \n',x0)
        elseif error<Tol
           xn=x0;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f \n',x0,Tol)
        elseif dfe==0 %si la derivada es 0 esta puede ser una posible raíz multiple
           xn=x0;
           fprintf('%f es una posible raiz múltiple de f(x) \n',x0)
        else 
           xn=x0;
           fprintf('Fracasó en %f iteraciones \n',niter) 
        end
        table(arregloiteraciones',arreglox',arreglofx',arreglodfx',arreglodffx',arregloerror','VariableNames',{'n','x','fx','dfx','dffx','Error'})
end