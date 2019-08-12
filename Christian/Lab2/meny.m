function meny()
%menuoptions Summary of this function goes here
%   Detailed explanation goes here
clear,clc
choice = true;
while choice ~= false
	displayoptions()
	choice = input('Ditt val: ');
	if choice == 1
		clc
		degree = askdegree();
		fprintf("Gradtalet sattes till: " + degree + "\n")
		assignin('base','degree',degree);
	elseif choice == 2
		clc
		points = askpoints();
		fprintf("Punkter inmatade!\n ")
        assignin('base','points',points);
	elseif choice == 3
		coeffs = findcoeffs(degree,points);
		clc
        termsstring = dispterms(coeffs);
        assignin('base','coeffs',coeffs);
        assignin('base','termsstring',termsstring);
	elseif choice == 4
		clc
		plotpoly(coeffs,points,termsstring);
	elseif choice == 5
		clc
		polyroots(coeffs);
	elseif choice == false
		clc
	else
		disp('�r du s�ker p� att du har matat in r�tt?')
		input('Tryck Enter f�r att forts�tta: ')
end

end

