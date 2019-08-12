function degree = askdegree()
%askdegree Summary of this function goes here
%   Detailed explanation goes here
degree = input('Vilket gradtal ska polynomet ha? ');

while ~isnumeric(degree)
    degree = input('Ett gradtal måste vara ett nummer. Försök igen: ');


end

