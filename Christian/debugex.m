foo(-1,10)
function y = foo(x, a)
for k = -1:0
    b = x-k;
    while (x > -2) && (x < 2)
        x = x+a+1;
    end
end
y = b + x;
end