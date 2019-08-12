function [t,y] = eulerf(u0,T,n,alpha)
%Framåt Euler
%   Den här metoden approximerar differentialekvationen i i Uppgift A
%   med hjälp av framåt euler.
%   indata: (u0,T,n,alpha)
%   utdata: [t,y]
m = 0.1;
L = 1;
g = 9.81;
dt = T/n;

y = zeros(n,2);
y(1,:) = u0;
f = @(th) [th(2),-(g/L)*th(1) - (alpha/m)*th(2)]; % -(m*g/L) blir bara -(g/L), alpha blir (alpha/m)

for i = 1:n
    y(i+1,:) =  y(i,:) + dt*f(y(i,:));
end

t = (0:dt:T)';

end