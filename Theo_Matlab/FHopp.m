function [ Xh,Yh,l] = FHopp( iv, ivprim )
global K dt

%   Input: vinkeln samt vinkelhastigheten
%   Output: Vektorer som inneh�ller alla x samt y koordinater som hoppet
%   g�r igenom.

T=0;
Tend = 20; % Tend en ej s� nogrann estimering av tiden tills hoppet �r slut
SP =[K(4)*sin(iv) K(4)*cos(iv)*ivprim K(6)-K(4)*cos(iv) K(4)*sin(iv)*ivprim]; 
NP = SP;
%NP = Nuvarandepunkt i hoppet = [x dx/dt y dy/dt] 
% SP Hoppets startpunkt
Punktinfo=NP; % Punktinfo sparar alla koordintater i alla tid moment i hoppet

while T<Tend-dt/2 && NP(3)>0 % Medan dessa villkor g�ller k�rs loopen
    h1=hopp(NP); 
    h2=hopp(NP+dt*h1/2);
    h3=hopp(NP+dt*h2/2);
    h4=hopp(NP+dt*h3);
    NP=NP+dt*(h1+2*h2+2*h3+h4)/6; T=T+dt;
    Punktinfo=[Punktinfo; NP];    
end 

Xh = Punktinfo(:,1); 
Yh = Punktinfo(:,3); % Alla punkter som x,y passerar

%Vi anv�nder oss av en polyomial funktion och l�ser ekvationen p(x)=0  
b = length(Xh);
a = b-1;
lin = polyfit(Xh(a:b)',Yh(a:b)',1);
l = roots(lin); 

end
