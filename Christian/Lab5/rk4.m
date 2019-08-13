function [t,y] = rk4(u0,T,n)
%Runge-Kutta 4
%   Den här metoden approximerar differentialekvationen i i Uppgift B
%   med hjälp av runge kutta.
%   indata: (u0,T,n,alpha)
%   utdata: [t,y]
L = 4;
g = 9.81;
dt = T/n;

y = zeros(n,2);
y(1,:) = u0;
f = @(th) [th(2),-(g/L)*sin(th(1))];

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