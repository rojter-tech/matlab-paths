%input: 
%gtid är gungtiden
%limit är diskonuitets gränsen 
%d är den adderade diskontinuitet där värderna finns i main (initialvinkel
%vinkeländring)
%output: en matris med n*2 där ena kolumnen är ekvivalent med vinkeln och
%andra med vinkelhastigheten


function  Y = gungansfunction(gtid, limit, d, y)
global K dt
 
t=0; 
Y=y;

while t<gtid-dt/2
    f1=optimalvinkel(y); 
    f2=optimalvinkel(y+dt*f1/2);
    f3=optimalvinkel(y+dt*f2/2);
    f4=optimalvinkel(y+dt*f3);
    y=y+dt*(f1+2*f2+2*f3+f4)/6; t=t+dt;
    %Villkoret är uppfylt när derivatan byter tecken, dvs extrempunkten. 
    if sign(y(2)) ~= sign(Y(end,2)) && abs(y(1)) < limit 
     y(2) = y(2)+sign(y(2))*d; % diskontinuitet adderas.
    end
     Y=[Y; y]; 
end