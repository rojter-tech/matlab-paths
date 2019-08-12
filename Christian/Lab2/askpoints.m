function points = askpoints()
%askpoints Summary of this function goes here
%   Detailed explanation goes here
disp('Ange punkter (retur avslutar inmatningen)')
x = [];
y = [];
in = true;
while ~isempty(in)
    in = input('Ange en punkt([x, y]): ');
    if isvector(in)
        if numel(in) == 2
            x = [x;in(1)];
            y = [y;in(2)];
        else
            disp('Du måste ange en vektor med två element, försök igen ...')
        end
    else
        disp('Du måste ange en vektor med två element, försök igen ...')
    end
end

points = [x y];

end

