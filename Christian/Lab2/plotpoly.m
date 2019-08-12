function plotpoly(coeffs, points, termsstring)
%plotpoly Plottar det anpassade polynomet och datapunkterna 
%   Detailed explanation goes here
x = points(:,1)';
y = points(:,2)';

spanfactor = 0.3;

span = max(x) - min(x);
x_min = min(x) - spanfactor*span;
x_max = max(x) + spanfactor*span;

x_fit = linspace(x_min, x_max);
y_fit = polyval(coeffs,x_fit);

figure(1), clf(1), hold on
line([min(x_fit),max(x_fit)],[0,0])
plot(x,y,'k+',x_fit,y_fit,'b--');
xlim([min(x_fit) max(x_fit)])
grid on, grid minor
title('Kurvanpassning med polynom')
xlabel([num2str(x_min) ++ ' < x < ' ++ num2str(x_max)])
ylabel('y-värden')
legend('Datapunkter', termsstring)
hold off

end

