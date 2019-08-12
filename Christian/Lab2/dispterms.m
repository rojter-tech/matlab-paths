function coeffstring = dispterms(coeffs)
%dispterms Visar polynomtermer i terminalen och returnerar detta som en sträng.
%   Detailed explanation goes here
n = numel(coeffs);
coeffcell = cell(1,n);
coeffcell{1,n} = [];

for i = 1:n
    if coeffs(i) < 1e-9 && coeffs(i) > -1e-9
        coeffs(i) = 0;
    end
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
