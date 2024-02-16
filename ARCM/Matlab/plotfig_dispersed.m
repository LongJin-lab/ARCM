% test linux
close all
clear

% load thetaPlot.mat
% % load dthetaPlot.mat
% % load ddthetaPlot.mat
% load kPlot.mat
% % load JeAPlot.mat
% load t_span.mat

load thetaPlot.mat
load ddthetaPlot.mat
load kPlot.mat
load t_span.mat

T = 20;
% t_span = 0:0.01:T;
% t_span = t_span(1:190);
% thetaPlot = thetaPlot(1:190,:);
% ddthetaPlot = ddthetaPlot(1:190,:);
% kPlot = kPlot(1:190);



% figure(200)
% 
% pose = zeros(length(t_span), 5);
% for i=1:length(t_span)
%     pose(i,1) = norm(r_draw(:,i,3) - r_draw(:,i,2));
%     pose(i,2) = norm(r_draw(:,i,4) - r_draw(:,i,3));
%     pose(i,3) = norm(r_draw(:,i,5) - r_draw(:,i,4));
%     pose(i,4) = norm(r_draw(:,i,6) - r_draw(:,i,5));
%     pose(i,5) = norm(r_draw(:,i,7) - r_draw(:,i,6));
% end
% plot(t_span, pose)

% figure(100)
% r = zeros(3, length(t_span));
% for i=1:length(t_span)
%     r(:, i) = fka(thetaPlot(i, :));
% end
% plot3(r(1, :), r(2, :), r(3, :))
% xlabel('X')
% ylabel('Y')

figure(2)   % theta change
plot(t_span, thetaPlot);
xlabel('t','FontSize',12);
ylabel('theta','FontSize',12);
title('Theta Change')
grid on


% figure(2)   % endeffector postion error
% subplot(2, 2, 2)
% j = 0;
% for i=1:length(t_span)
%     [r, dr] = fish_rd(j);
%     j = j + 0.1;
%     r(:, i) = fka(theta(i, :)) - r;
% end

% plot(t_span, r(1, :), r(2, :), r(3, :)); hold on
% plot(t_span, r(2, :)); hold on
% plot(t_span, r(3, :)); hold on
% legend('x error', 'y error', 'z error')
% title('Endeffector Postion Error')
% xlabel('t','FontSize',12)
% grid on

figure(3)
xpos = zeros(length(t_span), 3);
x = 1;
for i=t_span
    [dddr, ddr, dr, r]=fish_rd(i);
    xpos(x,:)=fka(thetaPlot(x,:))-r;
    x = x+1;
end
plot(t_span, xpos(:,1));hold on
plot(t_span, xpos(:,2));hold on
plot(t_span, xpos(:,3));
legend('x', 'y', 'z')
title("End-effector position error")
% title('X Postion Error')
% subplot(1, 3, 2)
% plot(t_span, xpos(:,2));
% legend('x', 'y', 'z')
% title('Y Postion Error')
% subplot(1, 3, 3)
% plot(t_span, xpos(:,3));
% grid on
% legend('x', 'y', 'z')
% title('Z Postion Error')

figure(302)
xpos = zeros(length(t_span), 3);
x = 1;
for i=t_span
    [dddr, ddr, dr, r]=fish_rd(i);
    xpos(x,:)=r;
    x = x+1;
end
% subplot(1, 3, 1)
plot3(xpos(:,1), xpos(:,2), xpos(:,3));hold on
r = zeros(3, length(t_span));
for i=1:length(t_span)
    r(:, i) = fka(thetaPlot(i, :));
end
plot3(r(1, :), r(2, :), r(3, :))
xlabel('X')
ylabel('Y')
zlabel('Z')

figure(4)
xPa = zeros(length(t_span), 3);
xPb = zeros(length(t_span), 3);
xPc = zeros(length(t_span), 3);
for i=1:length(t_span)
    xPa(i,:) = fka(thetaPlot(i,:));
    xPb(i,:) = fkb(thetaPlot(i,:));
    xPc(i,:) = xPb(i,:) + kPlot(i)*(xPa(i,:)-xPb(i,:));
end
plot(t_span,xPc(:, 1)-0.3074);hold on
plot(t_span,xPc(:, 2)-0);hold on
plot(t_span,xPc(:, 3)-0.4408);
legend('RCM x', 'RCM y', 'RCM z')
title('RCM point position')

figure(5)
plot(t_span, kPlot);

% figure(500)
% plot(t_span, dPlot);

% figure(6)
% plot(t_span, JeAPlot)
% title('J')
% 
% figure(8)
% plot(t_span, xJeA);
% title('Jestimition')
% 
% figure(9)
% dtheta = state(:,8:14);
% ddtheta = state(:,21:27);
% v = zeros(length(t_span), 3);
% for i=1:length(t_span)
%     J = Jacba(theta(i,:)');
%     v(i,:) = J*dtheta(i,:)';
% end
% for i=1:3
%     plot(t_span, v(:,i));hold on
% end
% title('velocity Change')

% figure(10)
% for i=1:7
%     plot(t_span, dtheta(:,i));hold on
% end
% title('dotTheta Change')

figure(11)

plot(t_span, ddthetaPlot);hold on

title('dotdotTheta Change')
