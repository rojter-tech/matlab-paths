function r = polyroots(coeffs)
%polyroots Summary of this function goes here
%   Detailed explanation goes here
r = roots(coeffs);
assignin('base','r',r)
disproots(r)
end

