function o = coinoutcome(n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

r = zeros(n,1);
for i = 1:n
r(i) = round(rand());
end

o = sum(r);

end

