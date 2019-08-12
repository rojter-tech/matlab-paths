%input: initialvinkeln, initialhastigheten
%output: vektorn Y som �ven anv�nds i gungansfunktion i runge-kuttametoden
%f�r att skriva om differentialekvationen till ordinaire differentialekvation. 
function Y = optimalvinkel(x) 
global K dt
Y = [x(2) -K(1)/K(2)*x(2)-K(3)/K(4)*sin(x(1))];
end 