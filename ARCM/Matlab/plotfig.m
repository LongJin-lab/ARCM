close all
clear

load state.mat

T = 20;
t_span = 0:0.001:T;


figure(1)
theta = state(:, 1:7);
r = zeros(3, length(t_span));
for i=1:length(t_span)
    r(:, i) = fka(theta(i, :));
end
plot3(r(1, :), r(2, :), r(3, :))
xlabel('x','FontSize',12);
ylabel('y','FontSize',12);
zlabel('z','FontSize',12);
title('Manipulator Path')
grid on
hold on
r_draw = zeros(3,length(t_span),8);
for i = 1:10:length(t_span)
    r_draw(:,i,1) = P1(state(i,1:7));
    r_draw(:,i,2) = P2(state(i,1:7));
    r_draw(:,i,3) = P3(state(i,1:7));
    r_draw(:,i,4) = P4(state(i,1:7));
    r_draw(:,i,5) = P5(state(i,1:7));
    r_draw(:,i,6) = P6(state(i,1:7));
    r_draw(:,i,7) = fkb(state(i,1:7));
    r_draw(:,i,8) = fka(state(i,1:7));
end
for j = 1:10:length(t_span)
    line('xdata',[0;r_draw(1,j,1)],'ydata',[0;r_draw(2,j,1)],'zdata',[0;r_draw(3,j,1)],'color', 'blue');
    line('xdata',[r_draw(1,j,1);r_draw(1,j,2)],'ydata',[r_draw(2,j,1);r_draw(2,j,2)],'zdata',[r_draw(3,j,1);r_draw(3,j,2)],'color', 'blue');
    line('xdata',[r_draw(1,j,2);r_draw(1,j,3)],'ydata',[r_draw(2,j,2);r_draw(2,j,3)],'zdata',[r_draw(3,j,2);r_draw(3,j,3)],'color', 'blue');
    line('xdata',[r_draw(1,j,3);r_draw(1,j,4)],'ydata',[r_draw(2,j,3);r_draw(2,j,4)],'zdata',[r_draw(3,j,3);r_draw(3,j,4)],'color', 'blue');
    line('xdata',[r_draw(1,j,4);r_draw(1,j,5)],'ydata',[r_draw(2,j,4);r_draw(2,j,5)],'zdata',[r_draw(3,j,4);r_draw(3,j,5)],'color', 'blue');
    line('xdata',[r_draw(1,j,5);r_draw(1,j,6)],'ydata',[r_draw(2,j,5);r_draw(2,j,6)],'zdata',[r_draw(3,j,5);r_draw(3,j,6)],'color', 'blue');
    line('xdata',[r_draw(1,j,6);r_draw(1,j,7)],'ydata',[r_draw(2,j,6);r_draw(2,j,7)],'zdata',[r_draw(3,j,6);r_draw(3,j,7)],'color', 'blue');
    line('xdata',[r_draw(1,j,7);r_draw(1,j,8)],'ydata',[r_draw(2,j,7);r_draw(2,j,8)],'zdata',[r_draw(3,j,7);r_draw(3,j,8)],'color', 'blue');
    plot3(r(1, j), r(2, j), r(3, j),'g.','linewidth',2);
%     drawnow
end

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

figure(100)
plot3(r(1, :), r(2, :), r(3, :))

figure(2)   % theta change
plot(t_span, state(:, 1:7));
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
t = 0;
for i=1:length(t_span)
    [dddr, ddr, dr, r]=fish_rd(t);
    t = t + 0.01;
    xpos(i,:)=fka(state(i,1:7)) - r;
end
% subplot(1, 3, 1)
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

figure(4)
xPa = zeros(length(t_span), 3);
xPb = zeros(length(t_span), 3);
xPc = zeros(length(t_span), 3);
for i=1:length(t_span)
    xPa(i,:) = fka(state(i,1:7));
    xPb(i,:) = fkb(state(i,1:7));
    xPc(i,:) = xPb(i,:) + state(i,15)*(xPa(i,:)-xPb(i,:));
end
plot(t_span,xPc(:, 1)-0.3074);hold on
plot(t_span,xPc(:, 2)-0);hold on
plot(t_span,xPc(:, 3)-0.4408);
legend('RCM x', 'RCM y', 'RCM z')
title('RCM point position')

figure(5)
k = state(:,15);
plot(t_span, k);

figure(500)
d = state(:,17:20);
plot(t_span, d);

figure(6)
xJeA = state(:,53:73);
plot(t_span, xJeA)
title('J')
% 
% figure(8)
% plot(t_span, xJeA);
% title('Jestimition')
% 
figure(9)
dtheta = state(:,8:14);
ddtheta = state(:,21:27);
v = zeros(length(t_span), 3);
for i=1:length(t_span)
    J = Jacba(theta(i,:)');
    v(i,:) = J*dtheta(i,:)';
end
for i=1:3
    plot(t_span, v(:,i));hold on
end
title('velocity Change')

figure(10)
for i=1:7
    plot(t_span, dtheta(:,i));hold on
end
title('dotTheta Change')

figure(11)
for i=1:7
    plot(t_span, ddtheta(:,i));hold on
end
title('dotdotTheta Change')
