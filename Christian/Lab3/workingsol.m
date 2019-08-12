%% Kryptering ceasarkryptering
% Uppercase alphabetic letters 65 - 90
% Lowercase alphabetic letters 97 - 122
clear, clc
filestr = fileread('source.txt');
charnumbers = double(filestr);

shift = 0;
n = length(charnumbers);
convcharnumbers = zeros(1,n);
for i = 1:n
    thischar = charnumbers(i);
    
    if (thischar >= 65 && thischar <= 90)
        convchar = mod(thischar - 65 + shift,26) + 65;
        convcharnumbers(i) = convchar;
    elseif (thischar >= 97 && thischar <= 122)
        convchar = mod(thischar - 97 + shift,26) + 97;
        convcharnumbers(i) = convchar;
    else
        convcharnumbers(i) = thischar;
    end
end


disp('Loaded file:')
disp(' ')
disp(char(charnumbers));
disp(' ')
disp('----------------------------')
disp(' ')
disp('Converted output:')
disp(' ')
disp(char(convcharnumbers));