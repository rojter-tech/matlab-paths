
global K dt 
K = [1.20 18 9.81 2 0.14 2.4];
% F�rsta parametern (k)  �r en d�mpande konstant beroende p� luftmotst�nd och tr�dgrensfriktion.
% Andra parametern (m) �r Nalle-Majas vikt tillsammans med gungan
% Tredje parametern (g) �r gravitationen
% Fj�rde parametern (l) �r repetsl�ngd
% Femte parametern (c) �r luftmotst�ndskoefficient
% Sj�tte parametern (h) �r tr�dgrenens h�jd �ver marken
% K = [k m g l c h] 
dt = 0.02; 
% dt l�ngd av steget i hoppet och gungningen

XY = [0 0]; % koordinaternas startpunkter.
gtid = 8; % gungtiden 
rad =pi/180;
d=1.3; % Diskontinuitet
y =[25*rad 0]; % initialvilkor till diff ekvationen. 0 �r start hastigheten.
limit = 70*pi/180; % max vinkel

Fx= gungansfunction(gtid,limit,d,y);

[r k] = size(Fx); % skapar en vektor av storleken Fx 
HL = []; % HL �r en vektor som sparar hoppl�ngderna
XC = []; % XC �r en tom vektor som kommer spara alla x-koordinater
YC = []; % YC �r en tom vektor som kommer spara alla y-koordinater
U = []; 
index = 1;
for n=1:r
iv = Fx(n,1); % initialvinkel
ivprim = Fx(n,2); % Vinkel�ndring
[ Xh,Yh,langd] = FHopp(iv,ivprim);

if langd > max(HL)
XC = Xh; % sparar det l�ngsta hoppet i x-koordinat
YC = Yh; % sparar det l�ngsta hoppet i y-koordinat
U = [iv ivprim]; % Sparar vinekeln och vinkelhastigheten f�r det l�ngsta hoppet
index = n; % Sparar raden  av Fx d�r vinkeln och vinkelhastigheten ger det l�ngsta hoppet
end
HL = [HL langd];
end


MaxHopp = max(HL)  % hoppets maxl�ngd
disp('chosen angle')
U(1)*180/pi % radianer->grader
disp('chosen anglevelocity')
U(2)*180/pi % grader->radianer

% plotten b�rjar

axis([-4 5 -1 5]), axis equal, hold on
plot([0 K(4)], [2.5 2.5], K(4), 2.5,'-'), title('Gungning & hopp'), pause(0.01)
set(gcf,'Doublebuffer','on')

for i=1:index % plotten slutar  
    plot([0 XY(1)], [2.5 XY(2)+2.5], 'w', XY(1), XY(2)+2.5, 'wo') % den m�lar om med vitt s� att funktionen endast syns i nutid. 
    XY(1) = K(4)*sin(Fx(i,1)); XY(2) = -K(4)*cos(Fx(i,1));
    plot([0 XY(1)], [2.5 XY(2)+2.5], XY(1), XY(2)+2.5, 'ro'), pause(0.01) 
    xlabel('x'),ylabel('y')
end

hold on

for i=1:length(XC)
    if i>1
    plot(XC(i-1),YC(i-1),'wo') % den m�lar om med vitt
    end
plot(XC(i),YC(i),'ro'),pause(0.01) 
end
hold on
plot(XC,YC) % plottar hoppet 
hold on
plot(MaxHopp,0,'*') % plottar landningspunkt
