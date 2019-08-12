% Vi använder oss av Runge-kuttametoden som 
% approximerar lösningen till differential ekvationen
% input=
function fH = hopp(x)
global K dt

 fH = [x(2) -K(5)*abs(x(2))*sqrt((x(2))^2+(x(4))^2) x(4) ...   
    -K(3)-K(5)*abs(x(4))*sqrt((x(2))^2+(x(4))^2)];

