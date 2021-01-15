function PLOT(u,t)

%Plot the results of PDE
l=size(u);
m=l(1)/2;
plot(0.1:0.1:m/10, u(1:m),'b','LineWidth',2)
hold on
plot(0.1:0.1:m/10, u(m+1:end),'r','LineWidth',2)
hold off
title(['Time=', num2str(t)])
drawnow
end
