function [t,y] = rk4(u0,T,n,alpha)
%Runge-Kutta 4
%   Den här metoden approximerar differentialekvationen i i Uppgift B
%   med hjälp av runge kutta.
%   indata: (u0,T,n,alpha)
%   utdata: [t,y]
m = 0.1;
L = 1;
g = 9.81;
dt = T/n;

y = zeros(n,2);
y(1,:) = u0;
f = @(th) [th(2),-(g/L)*th(1) - (alpha/m)*th(2)];  % -(m*g/L) blir bara -(g/L), alpha blir (alpha/m)

for i = 1:n
    u2_ = y(i,:);
    fa = f(u2_);
    fb = f(u2_+dt/2.*fa);
    fc = f(u2_+dt/2.*fb);
    fd = f(u2_+dt.*fc);
    y(i+1,:) = y(i,:) + (dt/6)*(fa+2*fb+2*fc+fd);
end

t = (0:dt:T)';

end