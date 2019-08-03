%% 
%

clear, clc
num = 100;
y = zeros(1,num);x = y;
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

plot(x,y,'.')
in = x.^2 + y.^2 <= 1;

disp('actual value of pi/4:')
disp(pi/4)

disp('simulated area')