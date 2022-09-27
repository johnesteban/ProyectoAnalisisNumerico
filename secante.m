%Secante: se ingresa el valor inicial (x0), el siguiente (x1), la tolerancia 
% del error (Tol), el máximo nùmero de iteraciones (niter) y la función.
% Se devuelve el numero de iteraciones, la solucion, f(xn) y el error.
%[c,cn,fe,error]=secante(-3,-2,0.5*10^-5,10,((abs(x))^(x-1))-2.5*x-5)
function [c,xn,fe,error] = secante(x0,x1,Tol,niter,f)
    format long
        c=-1; %iteracion
        fe=eval(subs(f,x0)); %f(x0)
        fe1=eval(subs(f,x1)); %f(x1)
        error=Tol+1; 
        error1=Tol+1; %error primeras iteraciones
        xn=x0; %punto inicial 
        xn1=x1;
        arregloiteraciones=[c,c+1];
        arreglox=[xn,xn1];
        arreglofx=[fe,fe1];
        arregloerror=[error,error1];
        c=c+1;
        while error>Tol && c<niter && fe~=0
            nxn=xn1; %nuevo xn-1
            nfe=fe1; %nuevo f(xn-1)
            xn1=xn1-((fe1*(xn1-xn))/(fe1-fe)); %nuevo xn
            fe1=eval(subs(f,xn1));
            error=abs(xn1-nxn);
            %cifras significativas: abs((xn1-nxn)/xn1)
            xn=nxn; %nuevo xn-1
            c=c+1;
            fe=nfe;
            arregloiteraciones=[arregloiteraciones,c];
            arreglox=[arreglox,xn1];
            arreglofx=[arreglofx,fe1];
            arregloerror=[arregloerror,error];
        end
        if fe==0 
           xn=xn1;
           fprintf('%f es raiz de f(x) \n',x0)
        elseif error<Tol
           xn=xn1;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f \n',xn1,Tol)
        else 
           xn=xn1;
           fprintf('Fracasó en %f iteraciones \n',niter) 
        end
        table(arregloiteraciones',arreglox',arreglofx',arregloerror','VariableNames',{'n','x','fx','Error'})
end