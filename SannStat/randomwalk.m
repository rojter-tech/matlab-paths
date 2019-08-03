%% Slumpgang pa 1x1 kvadrat
%

clear, clc

% %%%%%%%%%%%%%%% Start parameters %%%%%%%%%%%%%%%
startpoint = [0.5 0.5]; % Choose betwen 0 and 1
stepsize = 2;
speed = 50000;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
