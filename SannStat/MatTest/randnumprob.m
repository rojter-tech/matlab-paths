function [v] = randnumprob(max,num,least)

r = randi(max,num,1);r = sort(r);
ul = num - least + 1;

i = 1;
while i <= ul && r(i) < r(i+1)
    i = i + 1;
end

if i == ul + 1
    v = 1;
else
    v = 0;
end

end

