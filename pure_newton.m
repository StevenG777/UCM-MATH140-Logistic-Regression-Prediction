function x=pure_newton(f,g,h,x0,epsilon)
% Pure Newton's method
%
% INPUT
% ==============
% f ..........  objective function.
% g ..........  gradient of the objective function
% h ..........  Hessian of the function
% x0........... initial point
% epsilon ..... tolerance
% OUTPUT
% ==============
% x - solution obtained by Newton's method (up to some tolerance)
 
if (nargin<5)
    epsilon=1e-5;
end
 
x=x0;
gval=g(x);
hval=h(x);
iter=0;

while ((norm(gval)>epsilon)&&(iter<10000))
    iter=iter+1;
    x=x-hval\gval;
    fprintf('iter= %2d f(x)=%10.10f\n',iter,f(x))
    gval=g(x);
    hval=h(x);
end
 
if (iter==10000)
    fprintf('did not converge')
end

