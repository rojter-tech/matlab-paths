
global K dt 
K = [1.20 18 9.81 2 0.14 2.4];
% Första parametern (k)  är en dämpande konstant beroende på luftmotstånd och trädgrensfriktion.
% Andra parametern (m) är Nalle-Majas vikt tillsammans med gungan
% Tredje parametern (g) är gravitationen
% Fjärde parametern (l) är repetslängd
% Femte parametern (c) är luftmotståndskoefficient
% Sjätte parametern (h) är trädgrenens höjd över marken
% K = [k m g l c h] 
dt = 0.02; 
% dt längd av steget i hoppet och gungningen

XY = [0 0]; % koordinaternas startpunkter.
gtid = 8; % gungtiden 
rad =pi/180;
d=1.3; % Diskontinuitet
y =[25*rad 0]; % initialvilkor till diff ekvationen. 0 är start hastigheten.
limit = 70*pi/180; % max vinkel

Fx= gungansfunction(gtid,limit,d,y);

[r k] = size(Fx); % skapar en vektor av storleken Fx 
HL = []; % HL är en vektor som sparar hopplängderna
XC = []; % XC är en tom vektor som kommer spara alla x-koordinater
YC = []; % YC är en tom vektor som kommer spara alla y-koordinater
U = []; 
index = 1;
for n=1:r
iv = Fx(n,1); % initialvinkel
ivprim = Fx(n,2); % Vinkeländring
[ Xh,Yh,langd] = FHopp(iv,ivprim);

if langd > max(HL)
XC = Xh; % sparar det längsta hoppet i x-koordinat
YC = Yh; % sparar det längsta hoppet i y-koordinat
U = [iv ivprim]; % Sparar vinekeln och vinkelhastigheten för det längsta hoppet
index = n; % Sparar raden  av Fx där vinkeln och vinkelhastigheten ger det längsta hoppet
end
HL = [HL langd];
end


MaxHopp = max(HL)  % hoppets maxlängd
disp('chosen angle')
U(1)*180/pi % radianer->grader
disp('chosen anglevelocity')
U(2)*180/pi % grader->radianer

% plotten börjar

axis([-4 5 -1 5]), axis equal, hold on
plot([0 K(4)], [2.5 2.5], K(4), 2.5,'-'), title('Gungning & hopp'), pause(0.01)
set(gcf,'Doublebuffer','on')

for i=1:index % plotten slutar  
    plot([0 XY(1)], [2.5 XY(2)+2.5], 'w', XY(1), XY(2)+2.5, 'wo') % den målar om med vitt så att funktionen endast syns i nutid. 
    XY(1) = K(4)*sin(Fx(i,1)); XY(2) = -K(4)*cos(Fx(i,1));
    plot([0 XY(1)], [2.5 XY(2)+2.5], XY(1), XY(2)+2.5, 'ro'), pause(0.01) 
    xlabel('x'),ylabel('y')
end

hold on

for i=1:length(XC)
    if i>1
    plot(XC(i-1),YC(i-1),'wo') % den målar om med vitt
    end
plot(XC(i),YC(i),'ro'),pause(0.01) 
end
hold on
plot(XC,YC) % plottar hoppet 
hold on
plot(MaxHopp,0,'*') % plottar landningspunkt
