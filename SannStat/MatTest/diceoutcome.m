function o = diceoutcome( n )

c = zeros(n,1);
r = c;
for i = 1:n
r(i) = randi(6);
end

for i = 1:6
    k = 0;
    for j = 1:n
        if r(j) == i
            k = k + 1;
        end
    end
    c(i) = k;
    
end

disp(r)

o = c;

end

