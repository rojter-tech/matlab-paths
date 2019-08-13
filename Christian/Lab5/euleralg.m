%% Functions
%
function [euler,x] = euleralg(n,lower,upper)
h = (upper - lower)/n;
x = linspace(lower,upper,n);

euler = zeros(1,length(x));
y_0 = 0;
euler(1) = y_0;
for i=1:n-1
    dy = sin(x(i)) - 2*euler(i);
    euler(i+1) = euler(i) + h*dy;
end

end