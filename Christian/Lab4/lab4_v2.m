%%% SF1511, Numeriska metoder och grundläggande programmering
%              – Laboration 4 –
%   Ekvationslösning, interpolation och numerisk integration
%   Enkel Tredimensionell Design
%   Christian Amell

%% 1.) Icke-linjar skalar ekvation
% Behandla foljande ekvation:
% y(x) = x - 4sin(2x) - 3 = 0
% 
clear, clc
format long
% (a) - Plotta skiten

min_x = -4;
max_x = 8;
x = linspace(min_x, max_x, 300);
y = x - 4*sin(2*x) - 3;
max_y = max(y);
min_y = min(y);

% %% Figur/plot %% %
figure(1), clf(1), hold on
plot(x,y)

% Axlar
pLx = line([min_x,max_x],[0,0]);
pLx.Color = 'black';

if min_x <= 0
    pLy = line([0,0],[max_y,min_y]);
    pLy.Color = 'black';
end

% Plot-intervall
xlim([min_x,max_x])
ylim([min_y,max_y])

% Rutnat
grid on
grid minor

% Etiketter
title('Shit ar shit')
xlabel('x')
ylabel('y')
legend('y(x) = x - 4sin(2x) - 3', 'x-axel', 'y-axel')


hold off

% (b) - Testa i MATLAB och beskriv teoretiskt vilka rotter som kan
%       bestammas med:
%
%       Fixpunktsiteration: x_(n+1) = -sin(2x_n) + (5/4)x_n - 3/4
%       Newtons metod
%
%       10 korrekta vardesiffror

start = -0.1;

% %% Fixpunkt %% %

% Startgissning
x_guess = start;
disp("Startgissning: " + start)
disp(" ")

% Konvergenstabell
fixpunktvalue = [];
fixpunktdelta = [];
fixpunktiter = [];
fixpunktquote = 0;

%Kontrollvariabler
delta_x = 1;
count = 0;
countmax = 300;
while delta_x > 1e-10 && count < countmax
    x_minusone = x_guess;
    x_guess = -sin(2*x_guess) + (5/4)*x_guess - 3/4;
    delta_x = abs(x_minusone - x_guess);
    
    % Tabellvektorer och varden
    fixpunktvalue = [fixpunktvalue; x_minusone];
    fixpunktdelta = [fixpunktdelta;delta_x];
    count = count + 1;
    fixpunktiter = [fixpunktiter;count];
    if count > 1
        fixpunktquote = [fixpunktquote;fixpunktdelta(count-1)/delta_x];
    end
end

if count == countmax
    disp("OBS!! Fixpunktsalgoritmen gick mot oandligheten")
    disp(" ")
end
disp("Fixpunkt konvergensvarde: " + x_guess)
disp("Antalet iterationer: " + num2str(count))
% Anteckningar: Hittade -0.5444 och 3.1618

% %% Newton %% %

% Startgissning
x_guess = start;

% Konvergenstabell
newtondelta = [];
newtonvalue = [];
newtoniter = [];
newtonquote = 0;

%Kontrollvariabler
delta_x = 1;
count = 0;
countmax = 300;
while delta_x > 1e-10 && count < countmax
    x_minusone = x_guess;
    f = x_guess - 4*sin(2*x_guess) - 3;   df = 1 - 8*cos(2*x_guess);
    x_guess = x_guess - f/df;
    delta_x = abs(x_minusone - x_guess);
    
    % Tabellvektorer och varden
    newtonvalue = [newtonvalue; x_minusone];
    newtondelta = [newtondelta;delta_x];
    count = count + 1;
    newtoniter = [newtoniter;count];
    if count > 1
        newtonquote = [newtonquote;newtondelta(count-1)/delta_x];
    end
end

disp(" ")
if count == countmax
    disp("OBS!! Newtonalgoritmen gick mot oandligheten")
    disp(" ")
end

disp("Newton konvergensvarde: " + x_guess)
disp("Antalet iterationer: " + num2str(count))
% Anteckningar: Hittade -0.89836, -0.54444, 1.7321, 3.1618, 4.5178
% Funktionen omkring x = 7 verkar inte ha en rot i det intervallet.

% (c) - For bagge metoderna och for minst tva konvergerade rotter, skriv ut
%       tabeller som visar hur det beraknade vardet konvergerar som
%       funktion av antalet iterationer. n_i och x(n_i)
%       
%       I tabellen ska konvergenshastigheten kunna utlasas och antalet
%       iterationer som kravs for 10 korrekta vardesiffror.

disp(" ")

if length(fixpunktiter) < countmax
    T1 = table(fixpunktiter,fixpunktvalue,fixpunktdelta,fixpunktquote);
    disp(T1)
end

if length(newtoniter) < countmax
    T2 = table(newtoniter,newtonvalue,newtondelta,newtonquote);
    disp(T2)
end



%% 2.) Linjär algebra: robotarm
% Koordinaterna for robothanden ar:
%
% x = L1*cos(theta1) + L2*cos(theta1 + theta2)      (1)
% y = L1*sin(theta1) + L2*sin(theta1 + theta2)      (1)*
%
% L1 och L2 ar lanklangder
%
% Vinklarna i sin tur:
%
% theta1(t) = theta1(0) + a1*t^3 + a2*t^4           (2)
% theta2(t) = theta2(0) + b1*t^3 + b2*t^4           (2)*
%
% theta [grader] och t [sekunder]
clear, clc
% (a) - Bestam a1, a2, b1, b2 givet:
%       theta1(0) = 10 grader = 10*(pi/180) radianer
%       theta2(0) = 20 grader = 20*(pi/180) radianer
%
%       theta1(3) = 50.5 grader = 50.5*(pi/180) radianer
%       theta2(3) = -28.6 grader = (-28.6)*(pi/180) radianer
%
%       theta1(4) = 131.6 grader = 131.6*(pi/180) radianer
%       theta2(4) = -140.0 grader = (-140.0)*(pi/180) radianer
theta1_0 = 10;    theta2_0 = 20;
theta1_3 = 50.5;  theta2_3 = -28.6;
theta1_4 = 131.6; theta2_4 = -140.0;

A = [3^3 3^4;
     4^3 4^4];
B1 = [theta1_3 - theta1_0;
      theta1_4 - theta1_0];
B2 = [theta2_3 - theta2_0;
      theta2_4 - theta2_0];
C1 = A\B1;  C2 = A\B2;
a1 = C1(1); a2 = C1(2);
b1 = C2(1); b2 = C2(2);


% (b) - Plotta skiten fran t = 0 till t = 4 med L1 = 4 och L2 = 3

t = linspace(0,4);
theta1_deg = theta1_0 + a1*t.^3 + a2*t.^4;
theta1 = (pi/180)*theta1_deg;
theta2_deg = theta2_0 + b1*t.^3 + b2*t.^4;
theta2 = (pi/180)*theta2_deg;
L1 = 4; L2 = 3;

x = L1*cos(theta1) + L2*cos(theta1 + theta2);
y = L1*sin(theta1) + L2*sin(theta1 + theta2);

figure(2), clf(2)
for i = 1:100
 xlim([-4,7])
 ylim([0,7])
 HandP = line([L1*cos(theta1(i)),x(i)],[L1*sin(theta1(i)),y(i)]);
 HandP.Color = "Red";
 HandP.LineWidth = 1.5;
 BodyP = line([0,L1*cos(theta1(i))],[0,L1*sin(theta1(i))]);
 BodyP.Color = "Black";
 BodyP.LineWidth = 1.5;
 pause(0.001)
end
%% 3.) Interpolation och minstakvadratanpassning
% Givet en datamangd k(T) - kondktivitet som funktion av temperatur
% med foljande varden
%
% Temperatur, T, (K): 
% 100  200  300   400   500   600   700   800   900   1000
% Kond., k, (W/cmK): 
% 1.32 0.94 0.835 0.803 0.694 0.613 0.547 0.487 0.433 0.38
clear, clc
% (a) - Anvand T = [100, 400, 700, 1000] for
%              K = [1.32, 0.803, 0.547, 0.38]
%       och anpassa till ett tredjegradspolynom. Plotta skiten.

T3 = [100, 400, 700, 1000];
K3 = [1.32, 0.803, 0.547, 0.38]';

N = 3;
A3_4 = zeros(length(K3),N+1);
for k = 1:N+1
    A3_4(:,k) = T3.^(N+1-k);
end
P3 = A3_4\K3;
x = (100:20:1000);
y3 = polyval(P3,x);

k_300 = P3(1)*300^3 + P3(2)*300^2 + P3(3)*300^1 + P3(4)*300^0;
tabell_300 = 0.835;
delta_k_300 = abs(tabell_300 - k_300);
% Anteckning: Finns flera orsaker, men framfor allt for att undvika tailing,
% och andra "squees"-effekter nar datapunkterna i sjalva verket foljer en
% kurva som mer liknar en avtagande exponentialfunktion. Att tvinga
% punkerna genom samtliga punkter via ett 9-gradspolyom kommer troligen
% ocksa att orsaka oonskade oscillationer mellan datapunkterna.

figure(3), clf(3), hold on
grid on
grid minor
plot(x,y3)
hold off


% (b) - Anpassa ett andragradsplynom med \ och samtliga datapunkter. Jamfor
%       med resultatet fran a, berakna felkvadratsumman.

T = [100 200 300 400 500 600 700 800 900 1000];
K = [1.32 0.94 0.835 0.803 0.694 0.613 0.547 0.487 0.433 0.38]';

N = 2;
A2 = zeros(length(K),N+1);
for k = 1:N+1
    A2(:,k) = T.^(N+1-k);
end

P2 = A2\K;

y2 = polyval(P2,x);

figure(4), clf(4), hold on
grid on
grid minor
plot(x,y2)
hold off
% (c) - Gor samma sak som i b men for ett tredjegradspolynom. Uppskatta
%       vilket av felen som ar minst.

N = 3;
A3 = zeros(length(K),N+1);
for k = 1:N+1
    A3(:,k) = T.^(N+1-k);
end

P3_ = A3\K;

y3_ = polyval(P3_,x);

figure(5), clf(5), hold on
grid on
grid minor
plot(x,y3_)
hold off



%% 4.) Numerisk integration
% Numerisk integrering med trapetsregeln och Richardson-extrapolation.
%
clear, clc
% (a) - Berakna:
%
%       I(f) = Integral[-1,1]sqrt(x + 4)dx
%
%       (1) Exakt, (2) trapetsregeln (egen), (3) Richardsonextrapolation

% (1)
I_exact = (10/3)*sqrt(5) - 2*sqrt(3);

% (2)
f = @(x) sqrt(x + 4);
LB = -1;    UB = 1;
I_h2 = trapzalalala(f,1,LB,UB);     % h = 2   <=> N = 1
I_h1 = trapzalalala(f,2,LB,UB);     % h = 1   <=> N = 2
I_h05 = trapzalalala(f,4,LB,UB);    % h = 0.5 <=> N = 4

% (3) Trapetsregel foljt av Richardson extrapolation
N = 1;
h = (UB - LB)/N;
LA = trapzalalala(f,N,LB,UB);
MA = trapzalalala(f,2*N,LB,UB);
RE = (4*MA-LA)/3; % Richardson-extrapolation av andra ordningen

n = 100;
delta_trapzerror = zeros(n,1);
delta_reerror = zeros(n,1);
h_vector = zeros(n,1);
for i = 1:100
    I_trapz = trapzalalala(f,i,LB,UB);
    I_htrapz = trapzalalala(f,2*i,LB,UB);
    I_re = (4*I_htrapz-I_trapz)/3;
    delta_trapzerror(i) = abs((I_exact - I_trapz));
    delta_reerror(i) = abs((I_exact - I_re));
    h_vector(i) = (UB - LB)/i;
end

figure(6), clf(6)
loglog((h_vector),(delta_trapzerror))
hold on
title("Log-Log over approximationsfel")
xlabel("Steglangd (h)")
ylabel("Approximationsfel (E_h)")
loglog(fliplr(h_vector),fliplr(delta_reerror))
legend("Trapetsregel","Richardson-extrapolation")
grid on
hold off

delta_log_h = log(h_vector(end)) - log(h_vector(1));
delta_log_trapz = log(delta_trapzerror(end)) - log(delta_trapzerror(1));
delta_log_re = log(delta_reerror(end)) - log(delta_reerror(1));
p_trapz = (delta_log_trapz)/(delta_log_h);
p_re = (delta_log_re)/(delta_log_h);
disp("Noggrannhetsordning for trapetsregel: " + num2str(p_trapz));
disp("Noggrannhetsordning for Richardson-extrapolation: " + num2str(p_re));
% (b) - Berakna svangningstiden
%
%       T = 4sqrt(L/g)*Integral[0,pi/2]sqrt(1 - k^2(sin alfa)^2 )^(-1)
%       k = sin(phi_0/2)

L = 1;
g = 9.81;
Ts = 2*pi*sqrt(L/g);

phi_0 = 0:5:90;
T = zeros(1,length(phi_0));
rel_terror = zeros(1,length(phi_0));
for i = phi_0
    phi_0_rad = i*(pi/180);
    k = sin(phi_0_rad/2);
    f_pendel = @(x) (sqrt(1 - k^2*(sin(x))^2))^(-1);
    T_store = 4*sqrt(L/g)*trapzalalala(f_pendel,30,0,pi/2);
    T(1 + i/5) = T_store;
    rel_terror(1 + i/5) = abs(Ts - T_store) / abs(T_store); 
end


figure(7), clf(7), hold on
plot(phi_0,T)
title("Samband mellan phi och T")
xlabel("Utslagsvinkel (phi)")
ylabel("Svangningstid (T)")
legend("Svangningstid")
grid on
grid minor
hold off

figure(8), clf(8), hold on
plot(phi_0,rel_terror)
title("Relativt fel av T_s som funktion av phi")
xlabel("Utslagsvinkel (phi)")
ylabel("Relativt fel (R_{T_s})")
legend("Svangningstid")
grid on
grid minor
hold off



%% 5.) Tredimensionell design
clear,clc
% (a) - Skapa en kolumnvektor z med element från ?14 till 5 med nagot 
%       lampligt antal steg, och definiera funktionen x = 2 ? arctan(z).
%       Konstruera nu en radvektor ? med element från 0 till 2?.
%       Anvand:
%
%       X = x cos(?), Y = x sin(?), Z = z ? ones(size(?)), surfl(X, Y, Z) 
%       och axis equal

z = linspace(-14,5,20)';
x = 2 - atan(z);
phi = linspace(0,2*pi,20);

X = x*cos(phi);
Y = x*sin(phi);
Z = z*ones(size(phi));

figure(9), clf(9)
surfl(X,Y,Z)
axis equal
axis off
shading flat
colormap hot

% (b)

n = 5;

figure(10), clf(10)
[x,y] = ginput(n);

P = polyfit(x,y,n-1);
phi = linspace(0,2*pi,20);
X = linspace(0,1,20)';
Y = polyval(P,X);

Xplot = X*ones(size(phi));
Yplot = Y*cos(phi);
Zplot = Y*sin(phi);

figure(10), clf(10)
surfl(Xplot, Yplot, Zplot)
axis off


% (alternativ)



%% Funktioner
function I = trapzalalala(f,N,a,b)
    h = (b-a)/N;
    I = 0;
    for i = 1:N
        I = I + (h/2)*(f(a+(i-1)*h) + f(a+(i)*h));
    end
end