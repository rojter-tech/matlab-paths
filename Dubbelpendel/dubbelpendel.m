clc, clear
phi_1 = 2; phi_2 = 0.8; dphi_1 = 0; dphi_2 = 0;
u1 = phi_1; u2 = dphi_1; u3 = phi_2; u4 = dphi_2;
u0 = [u1,u2,u3,u4];
tspan = (0:0.005:5)';
[t,y1] = ode45('fpendel',tspan,u0);

figure(1), clf(1), hold on
plot(t,y1(:,1),t,y1(:,3))
title('Sammansatt pendel')
xlabel('Tid i intervallet 0 < t < 5')
ylabel('\phi(t)')
legend('y = \phi_1(t) ode45','y = \phi_2(t) ode45')
xL = xlim; line(xL, [0 0],'color','k','linewidth',0.5);
grid minor
hold off

tspan = (0:0.01:2)'; % har lekt lite med parametrarna, ett bredd spann med många punkter tar evigheter att plotta, men ju fler punkter desto "smoothare"
[t,y2] = ode45('fpendel',tspan,u0); % y6 blir y2 istället
y2 = [y2(:,1),y2(:,3)]; % jag plockar ut kolumn 1 och 3 från y2 och definerar om y2, som är vinkelfunktionerna
                        % kortfattat, jag tar bort kolumn 2 och 4 från y2
figure(2)
for k = 1:length(y6)-1
    plot([-1 1],[0,0],[0 sin(y2(k,:))],[0 -cos(y2(k,:))],'-o');  % har ändrat argumentet för y2 till (k,:) istället för (k,1), det plottar båda pendlarna samtidigt
    axis equal
    axis(1.2*[-1 1 -1 1]);
    drawnow
end