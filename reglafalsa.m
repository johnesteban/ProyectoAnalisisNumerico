%Regla falsa: se ingresa el inicio del intervalo (a), el final del
%intervalo (b), la tolerancia, el número de iteraciones máxima y la
%función.
%devuelve iteraciones (c), solución (xn),error y f(xn).
%[c,xn,error,fe]= reglafalsa(4,6,0.5*10^-5,8,exp(-x)-x^2+5*x)
function [c,xn,error,fe] = reglafalsa(a,b,tol,niter,f)
   c=0;
   fi=eval(subs(f,a)); %f(a)
   fs=eval(subs(f,b)); %f(b)
   arregloiteraciones=[];
   arreglox=[];
   arreglofx=[];
   arregloerrores=[]; %para la tabla
   if fi==0 %si f(a)=0, entonces a es una raíz
        xn=a; %solucion
        error=0; %el error sería 0 
        fprintf('%f es raiz de f(x)',a)
   elseif fs==0 %si f(b)=0, entonces b es una raíz
        xn=b; %solucion
        error=0; 
        fprintf('%f es raiz de f(x)',b)
   elseif fi*fs<0
      xm=(fs*a-fi*b)/(fs-fi); %xn1=(f(b)*a-f(a)*b)/(f(b)-f(a))
      fe=eval(subs(f,xm));  %f(xn1)
      error=tol+1; %error en la primera iteracion valor arbitrario
      arregloiteraciones=[arregloiteraciones,c];
      arreglox=[arreglox,xm];
      arreglofx=[arreglofx,fe];
      arregloerrores=[arregloerrores,error];
      while error>tol && fe~=0 && c<niter %error>toleracionancia y las iteraciones no sobrepasen
            if fi*fe<0 %f(a)*f(xn)<0, es decir la raíz se encuentra en este nuevo intervalo
                b=xm; %el final del intervalo será el xn
                fs=eval(subs(f,xm));  %f(xn)
            else
                a=xm; %el inicio del intervalo siguiente será xn
                fi=eval(subs(f,xm));
            end
            xa=xm; %para almacenar el valor de xn
            xm=(fs*a-fi*b)/(fs-fi); %genera el siguiente xn+1
            fe=eval(subs(f,xm));
            error=abs(xm-xa); %error con decimales correctos
            %con cifras significativas: error=abs((xm-xa)/xm)
            c=c+1; %aumenta iteracion
            arregloiteraciones=[arregloiteraciones,c];
            arreglox=[arreglox,xm];
            arreglofx=[arreglofx,fe];
            arregloerrores=[arregloerrores,error];
       end
        if fe==0
           xn=xm;
           fprintf('%f es raiz de f(x)',xm) 
        elseif error<tol
           xn=xm;
           fprintf('%f es una aproximación de una raiz de f(x) con una tolerancia= %f',xm,tol)
        else 
           xn=xm;
           fprintf('Fracasó en %f iteraciones',niter) 
        end
    else
       fprintf('El intervalo es inadecuado')         
    end    
    table(arregloiteraciones',arreglox',arreglofx',arregloerrores','VariableNames',{'n','x','f(x)','Error'})
end