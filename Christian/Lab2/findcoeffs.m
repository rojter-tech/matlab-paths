function coeffs = findcoeffs(n,points)
%findcoeffs Summary of this function goes here
%   Detailed explanation goes here
x = points(:,1)';
y = points(:,2)';

if ~isequal(size(x),size(y)) 
    error('X och Y vektorer måste vara lika stora.') 
end 

x = x(:); 
y = y(:); 
 
if nargout > 2 
   mu = [mean(x); std(x)]; 
   x = (x - mu(1))/mu(2); 
end 
 
% Skapa Vandermonde-matris. 
V(:,n+1) = ones(length(x),1); 
for j = n:-1:1 
   V(:,j) = x.*V(:,j+1); 
end 
 
% L�s 'Minsta Kvadrat'-problemet
[Q,R] = qr(V,0); 
ws = warning('off','all');  
coeffs = R\(Q'*y);    % Samma som coeffs = V\y; 
warning(ws); 
if size(R,2) > size(R,1) 
   warning('MATLAB:polyfit:PolyNotUnique', ... 
       'Polynomet är inte unikt; degree >= antalet datapunkter.') 
elseif condest(R) > 1.0e10 
    if nargout > 2 
        warning('MATLAB:polyfit:RepeatedPoints', ... 
            'Polynomet är illa konditionerat. Ta bort upprepade datapunkter.') 
    else 
        warning('MATLAB:polyfit:RepeatedPointsOrRescale', ... 
            ['Polynomet är illa konditionerat. Ta bort upprepade datapunkter\n' ... 
            '         eller prova att centrera och skala punkerna på ett meningsfullt sätt.']) 
    end 
end 

coeffs = coeffs.';
 
end

