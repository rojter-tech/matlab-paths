%% Simulering av sannolikheten att minst 2 personer av 50 delar födelsedag
clear, clc

n = 1000;
max = 365;
num = 50;
least = 2;
ul = num-least+1;

s = 0;
for i = 1:n
s = s + randnumprob(max,num,least);
end
format long
disp('Simulated')
disp(1 - s/n)


y = zeros(ul,1);
for i = 1:ul
    y(i) = (max-i)/max;
end

prob = 1 - prod(y);
disp('Real')
disp(prob)

%% Simulering av brus
clear, clc
points = 10000;
i = 100/points;
x = (1:i:100)';
figure(1), clf(1)
for i = 1:100
y = 100*rand(length(x),1);
X = [ones(length(x),1) x];
b = X\y;
yres = X*b;
plot(x,yres,x,y,'.')
pause(0.01)
end

%% Simulering av antalet gånger ett mynt visar "krona upp"
% n antal försök
clear, clc
ll = 430;
ul = 570;
x = (ll:ul)';
n = ul-ll+1;
y = zeros(n,1);

num = 100000;
c = zeros(num,1);
for i = 1:num
    c(i) = coinoutcome(1000);
end

x = 1;
for i = ll:ul
    k = 0;
    for j = 1:num
        if i == c(j)
            k = k + 1;
        end
    end
    y(x) = k;
    x = x + 1;
end

figure(1), clf(1)
scatter(x,y/num)

figure(2), clf(2)
histogram(c)




%% Simulering av summa av tärningskast
%
clear, clc

n = 100000;
c = zeros(n,1);
for i = 1:n
    c(i) = randi(6,1) + randi(6,1);
end

x = 1;
x = 1:13;
y = zeros(1,13);
for i = 1:13
    k = 0;
    for j = 1:n
        if i == c(j)
            k = k + 1;
        end
    end
    y(x) = k;
    x = x + 1;
end

figure(1), clf(1)
stem(x,y/n)


x2 = [0 1/6 1/6 1/6 1/6 1/6 1/6];
y2 = conv(x2,x2);
figure(2), clf(2)
stem(x-1,y2)

%% För första gången simulering
%

clear, clc

randi(6,1);


num = 100000;
c = zeros(1,num);
for i = 1:num
    n = 0;
    x = 0;
    while x ~= 5
        n = n + 1;
        x = randi(6,1);
    end
    c(i) = n;
end


ul = 25;
x = 1:ul;
y = zeros(1,ul);
for i = 1:ul
    k = 0;
    for j = 1:num
        if i == c(j)
            k = k + 1;
        end
    end
    y(i) = k;
end


figure(1), clf(1), hold on
stem(x,y/num)
hold off


%% Simulering av antalet gånger ett mynt visar "krona upp"
% n antal försök
clear, clc


num = 10000;
c = zeros(num,1);
for i = 1:num
    c(i) = coinoutcome(1000);
end

figure(1), clf(1)
histogram(c)

%% Real-time plot
%
%
figure(1), clf(1)
hold on

ll = 0;
ul = 4*pi;
step = pi/45;

line([0,ul],[0,0])
line([0,0],[-1.1,1.1])

for i = ll:step:ul
    plot(i,cos(i),'o')
    plot(i,sin(i - pi/2),'o')
    pause(0.02)
end

hold off

%% Slumpmässig beräkning av pi
%
clear, clc
num = 10;
xr = rand(1,num);
yr = rand(1,num);
x = 0:1/100:1;
y = sqrt(1-x.^2);
axis equal
plot(x,y,xr,yr,'.');
in = xr.^2 + yr.^2 <= 1;
area = sum(in)/num;
format long
disp('actual value of pi:')
disp(pi)

disp('simulated area')
disp(area*4)

%% Jämt fördelade punkter för beräkning av pi
%

clear, clc
num = 100;
y = zeros(1,num);
x = y;

k = 0;
for i = 1/num:1/num:1
    for j = 1:num
        y(j + k) = i;
    end
    k = k + num;
end

k = 0;
for i = 1/num:1/num:1
    for j = 1:num
        x(j + k) = 1/num + mod(j,num)/num;
    end
    k = k + num;
end

x = [zeros(1,num+1) 1/num:1/num:1 x];
y = [1/num:1/num:1 zeros(1,num+1) y];
xc = 0:1/100:1;
yc = sqrt(1-xc.^2);
axis equal

in = x.^2 + y.^2 <= 1;
area = sum(in)/length(in);

figure(1), clf(1), hold on
axis equal
plot(x,y,'.g',xc,yc,'b')
hold off



disp('actual value of pi/4:')
disp(pi)


disp('simulated area')
disp(area*4)

%% Slumpgång på 1x1 kvadrat
%

clear, clc

% %%%%%%%%%%%%%%% Start parameters %%%%%%%%%%%%%%
startpoint = [0.5 0.5]; % Choose betwen 0 and 1
stepsize = 5;
speed = 100;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initializing parameters
stepsize = stepsize*0.01;
speed = (2*speed)^-1;
d = stepsize;
margin = d;
sign = [-1,1];

% %%%%%%%%%%%%%%%%%%% The plot %%%%%%%%%%%%%%%%%%% %
figure(1), clf(1), title('Random Walk'), hold on

% The Square
line([0,0],[1+margin,-margin]) % Left
line([1,1],[1+margin,-margin]) % Right
line([-margin,1+margin],[1,1]) % Top
line([-margin,1+margin],[0,0]) % Bottom

% Plot startpoint
x=startpoint(1);y=startpoint(2);xdist=0;ydist=0;
plot(x,y,'p')

% Real-time plot
pause(speed);
while xdist <= 0.25 && ydist <= 0.25
% Random next point & random signs
a = rand(1); b = rand(1);
s1 = sign(randi(2));s2 = sign(randi(2));
% Determined lenght
r = sqrt(a^2+b^2);
k = d/r;
% Random next point of lenght d
np = [x+s1*k*a,y+s2*k*b];
% Plot line betwen this point and next point
plot([x,np(1)],[y,np(2)])
pause(speed/4)
% Plot next point
plot(np(1),np(2),'.')
x = np(1); y = np(2);
% Determine distance
xdist = (0.5-x)^2;
ydist = (0.5-y)^2;
pause(speed)
end

xlabel('finished')

hold off

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

%% 3d Plots
%
clear, clc

[X,Y,Z] = peaks(25);
CO(:,:,1) = zeros(25); % red
CO(:,:,2) = ones(25).*linspace(0.5,0.6,25); % green
CO(:,:,3) = ones(25).*linspace(0,1,25); % blue
surf(X,Y,Z,CO)

