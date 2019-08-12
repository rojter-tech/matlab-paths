%% Laboration 5
%% 1.)
clear, clc
C = 1/5;

lower = 0;
upper = 20;
n = [100,500,1000];

x = linspace(lower,upper,100);
y = C*exp(-2.*x) + (1/5)*(2*sin(x) - cos(x));

error = zeros(1,length(n));
figure(1), clf(1), hold on
plot(x,y)
k = 0;
for i = n
    k = k + 1;
    [euler,x] = euleralg(i,lower,upper);
    plot(x,euler);
    error(k) = abs(y(end) - euler(end));
end

legend('y(x)','euler100','euler500','euler1000');
hold off

figure(2), clf(2), hold on
loglog(error,(upper-lower)./n)
hold off

%%
%
clear,clc
L = 4;
T = (17/6)*pi;
u1_0 = pi/3;
u2_0 = 0;
u = [u1_0,u2_0];

[t,y] = rk4(u,T,100);
fi = y(:,1);

anim(t,fi,L)

%% 
% 3.) Randvardesproblem
clear, clc

L = 2;
A = 0.01;
k = 2.5;
T0 = 300;
TL = 400;

n = 100;
h = L/(n);
x = linspace(0,L,n)';
Q = 300*exp(-(x-L/2).^2);



e = (1/h^2)*ones(n,1);
a = spdiags([-e 2*e -e],-1:1,n,n);
b = zeros(n,1);
b(1) = 1; b(n) = 3;
A = full(a);
b = (1/k)*Q;
b(1) = b(1) + 300*(1/h^2);
b(end) = b(end) + 400*(1/h^2);
T = A\b;
xplot = [x;x(end)+h];
T_plot = [300;T];

plot(xplot,T_plot)


%%
% 4.) Icke linjart ekvationssystem - flera variabler
format long
clear, clc
a = 2;
L1 = 1;     L2 = 1;     L3 = 1;
m1 = 1;     m2 = 3;

%guesses
u1=1; 
u2=0.1;
u3=0.1; 
iter= 0;
xp =[u1;u2;u3];
x = zeros(size(xp));
%tol
tol = 10.^-10;
while norm(xp - x) > tol
    iter= iter + 1;
    x = xp;
    % new values for u1, u2, and u3
    u1 = x(1);
    u2 = x(2);
    u3 = x(3);
    %f1,f2 and f3.
    f1 = L1*cos(u1) + L2*cos(u2) + L3*cos(u3) - a;
    f2 =  L1*sin(u1) + L2*sin(u2) + L3*sin(u3); 
    f3 = m2*tan(u1) - (m1 + m2)*tan(u2) + m1*tan(u3);
    %Partial derivatives in terms of u1,u2 and u3.
    df1u1 = -L1*sin(u1);
    df1u2 = -L2*sin(u2);
    df1u3 = -L3*sin(u3);
    df2u1 = L1*cos(u1);
    df2u2 = L2*cos(u2);
    df2u3 = L3*cos(u3);
    df3u1 = m2*(sec(u1))^2;
    df3u2 = -(m1 + m2)*(sec(u1))^2;
    df3u3 = m1*(sec(u1))^2;
    % Jacobian
    J = [df1u1 df1u2 df1u3; df2u1 df2u2 df2u3; df3u1 df3u2 df3u3];    
    % The Newton-Raphson stuff
    xp = x - J\[f1;f2;f3];
    disp(sprintf('iteration=%2.0f,  u1=%6.15f,  u2=%6.15f, u3=%6.15f', iter,xp)); 
end

% Test solution
u1=0.846558081651859;
u2=0.186999833876885;
u3=-1.208022917668234;

calc_a = L1*cos(u1) + L2*cos(u2) + L3*cos(u3);
calc_zero = L1*sin(u1) + L2*sin(u2) + L3*sin(u3);
calc_zero2 = m2*tan(u1) - (m1 + m2)*tan(u2) + m1*tan(u3);
%% Functions
%
function [euler,x] = euleralg(n,lower,upper)
h = (upper - lower)/n;
x = linspace(lower,upper,n);

euler = zeros(1,length(x));
y_0 = 0;
euler(1) = y_0;
for i=1:n-1
    dy = sin(x(i)) - 2*euler(i);
    euler(i+1) = euler(i) + h*dy;
end

end


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



function anim(tout, fi, L) 

for i=1:length(tout)-1 
    x0 = L*sin(fi(i));
    y0 = -L*cos(fi(i)); 
    plot([0,x0],[0,y0],'-o') 
    axis('equal') 
    axis([-1 1 -1 0]*1.2*L) 
    drawnow
    pause(tout(i+1)-tout(i))
end

end