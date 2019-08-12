function coeffstring = dispcoeffs(coeffs)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
n = numel(coeffs);
coeffcell = cell(1,n);
coeffcell{1,n} = [];

for i = 1:n
    rev = fliplr(1:n);
    if rev(i) == 2
        coeffcell{i} = num2str(coeffs(i)) + "x" + " +";
        fprintf(coeffcell{i} + " ")
    elseif rev(i) == 1
        coeffcell{i} = num2str(coeffs(i));
        fprintf(coeffcell{i} + "\n")
    else
        coeffcell{i} = num2str(coeffs(i)) + "x^" + num2str(rev(i) - 1) + " +";
        fprintf(coeffcell{i} + " ")
    end
end

coeffstring = strjoin(string(coeffcell));

end

