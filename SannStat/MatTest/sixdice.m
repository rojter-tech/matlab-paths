function [n] = sixdice()
s = 0;
n = 0;
while s ~= 5
	n = n+1;
    r = randi(6,1,6);
    r = sort(r);
    c = zeros(1,5);
    for i = 1:5
        c(i) = r(i) < r(i+1);
    end
    s = sum(c);
end

end

