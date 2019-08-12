function disproots(r)
%disproots Skickar rötterna till terminaloutput
%   Detailed explanation goes here

n = numel(r);

for i = 1:n
    if r(i) < 1e-9 && r(i) > -1e-9
        r(i) = 0;
    end
    rev = fliplr(1:n);
    fprintf(num2str(i) + ": " +  num2str( r( rev(i) ) ) + "\n");
end

end