%% Laboration 0
% Förberedande labtillfälle
%

%Skräpkod Upg 0 - 5
clear, clc
a = 1;
b = sqrt(36);
width = 3.89;
w = rand(4  , 1);
% exp log sin asin cos acos tan atan

%x = 0.5:0.1:2;
%y = log(x);
%plot(x,y)

n = 1000000;
MU = 2.5;
y = exprnd(MU, n, 1);
u = mean(y);
disp(['Medelvärdet av x är: ' num2str(u)]);
y1 = sort(y);
x1 = (1:1:n)';
%{
hold on, clf(1), figure(1)
plot(x1,y1, 'g');
line(x1, ones(length(x1),1)*u);
hold off
%}

min = 5;
xbool = y>min;
mxb = mean(xbool);
exp525_tail = 1 - expcdf(5,2.5);
disp(['Svanssannolikheten att värdet är större än ' num2str(min) ' är med ' num2str(n) ' försök beräknad till ' num2str(mxb)])
disp(['Det faktiska värdet är ' num2str(exp525_tail)]);

%% Olika sannolikhetsfördelningar -  Grafer för täthet
%%% binocdf, binopdf, normcdf, normpdf, expcdf, exppdf
% 
clear, clc
MU = 5;
SIGMA = MU/5;
N = 500;
P = MU/N;

UB = 2*MU;
LB = UB/N; 

x = LB:UB/N:UB;

%%% binocdf
% Kumulativ sannolikhetstäthet (sannolikheten) vid x > 0, kumulerad   
% (summerad) för sannolikhetstätheten kring x = N * P givet N försök och  
% sannolikheten P, diskret fördelade för x > 0 som tillhör de naturliga 
% talen.
%
y1 = binocdf(x,N,P);

%%% binopdf
% Sannolikhetstäteten kring x = N * P givet N försök och sannolikheten P
% diskret fördelade för x > 0 som tillhör de naturliga talen.
%
y2 = binopdf(x,N,P);

%%% normcdf
% Kumulativ sannolikhetstäthet
%
y3 = normcdf(x,MU,SIGMA);

%%% normpdf
% Sannolikhetstäteten
%
y4 = normpdf(x,MU,SIGMA);

%%% expcdf
% Kumulativ sannolikhetstäthet
%
y5 = expcdf(x,MU);

%%% exppdf
% Sannolikhetstäteten
%
y6 = exppdf(x,MU);

%%% poisspdf
% Poisson sannolikhetstäthet
%

y7 = poisspdf(x,MU);

%%% Subplot
figure(1), clf(1), hold on
subplot(2,3,1), plot(x,y1), title('binocdf')
subplot(2,3,4), plot(x,y2), title('binopdf')
subplot(2,3,2), plot(x,y3), title('normcdf')
subplot(2,3,5), plot(x,y4), title('normpdf')
subplot(2,3,3); plot(x,y5); title('expcdf')
subplot(2,3,6), plot(x,y6), title('exppdf')
hold off

figure(2), clf(2), hold on
plot(x,y7);
hold off

%%%% End Subplot %%%%


%% 6 Beräkning av sannolikheter
%
%
