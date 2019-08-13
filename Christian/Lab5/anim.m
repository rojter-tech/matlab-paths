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