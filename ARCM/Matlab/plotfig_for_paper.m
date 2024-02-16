close all
clear

load state_2000.mat
% load t_span.mat
load ZGQ/FigureNon_PDNN_cmg_dd.mat;

T = 20;
t_span = 0:0.01:T;


% Todo:坐标轴标记、加上放大显示
figure(1) 
% 机器臂轨迹3D
theta = state(:, 1:7);
r = zeros(3, length(t_span));
for i=1:length(t_span)
    r(:, i) = fka(theta(i, :));
end
plot3(r(1, :), r(2, :), r(3, :),'Color','r')
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
grid on
hold on
r_draw = zeros(3,length(t_span),8);
for i = 1:30:length(t_span)
    r_draw(:,i,1) = P1(state(i,1:7));
    r_draw(:,i,2) = P2(state(i,1:7));
    r_draw(:,i,3) = P3(state(i,1:7));
    r_draw(:,i,4) = P4(state(i,1:7));
    r_draw(:,i,5) = P5(state(i,1:7));
    r_draw(:,i,6) = P6(state(i,1:7));
    r_draw(:,i,7) = fkb(state(i,1:7));
    r_draw(:,i,8) = fka(state(i,1:7));
end
for j = 1:20:length(t_span)
    line('xdata',[0;r_draw(1,j,1)],'ydata',[0;r_draw(2,j,1)],'zdata',[0;r_draw(3,j,1)],'color', 'blue');
    line('xdata',[r_draw(1,j,1);r_draw(1,j,2)],'ydata',[r_draw(2,j,1);r_draw(2,j,2)],'zdata',[r_draw(3,j,1);r_draw(3,j,2)],'color', 'blue','LineWidth',2);
    line('xdata',[r_draw(1,j,2);r_draw(1,j,3)],'ydata',[r_draw(2,j,2);r_draw(2,j,3)],'zdata',[r_draw(3,j,2);r_draw(3,j,3)],'color', 'blue','LineWidth',2);
    line('xdata',[r_draw(1,j,3);r_draw(1,j,4)],'ydata',[r_draw(2,j,3);r_draw(2,j,4)],'zdata',[r_draw(3,j,3);r_draw(3,j,4)],'color', 'blue','LineWidth',2);
    line('xdata',[r_draw(1,j,4);r_draw(1,j,5)],'ydata',[r_draw(2,j,4);r_draw(2,j,5)],'zdata',[r_draw(3,j,4);r_draw(3,j,5)],'color', 'blue','LineWidth',2);
    line('xdata',[r_draw(1,j,5);r_draw(1,j,6)],'ydata',[r_draw(2,j,5);r_draw(2,j,6)],'zdata',[r_draw(3,j,5);r_draw(3,j,6)],'color', 'blue','LineWidth',2);
    line('xdata',[r_draw(1,j,6);r_draw(1,j,7)],'ydata',[r_draw(2,j,6);r_draw(2,j,7)],'zdata',[r_draw(3,j,6);r_draw(3,j,7)],'color', 'blue','LineWidth',2);
    line('xdata',[r_draw(1,j,7);r_draw(1,j,8)],'ydata',[r_draw(2,j,7);r_draw(2,j,8)],'zdata',[r_draw(3,j,7);r_draw(3,j,8)],'color', 'blue','LineWidth',2);
    plot3(r(1, j), r(2, j), r(3, j),'g.','linewidth',2);
    %drawnow
end
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/manipulator_trajectory.eps');

% figure(2)   % 末端轨迹图
% plot3(r(1, :), r(2, :), r(3, :), 'r'); hold on 
% i = 1; j=1;
% for t=t_span
%     [a, b, c, d] = fish_rd(t);
%     if mod(i,20)==0
%         rd(:, j) = d; %#ok<*SAGROW> 
%         j = j+1;
%     end
%     i = i+1;
% end
% plot3(rd(1, :), rd(2, :), rd(3, :), '-.bx'); hold on 
% xlabel('X/m','FontSize',24,'Position',[0.25, -0.01, 0.27]);
% ylabel('Y/m','FontSize',24,'Position',[0.17, 0.02, 0.27]);
% zlabel('Z/m','FontSize',24,'rotation',0,'Position',[0.15, 0.05, 0.3]);
% legend('Actual Trajectory', 'Desired Trajectory', 'Location', 'NorthEast');
% % view([0,0,pi/2])
% zlim([0.27 0.31])
% set(gca,'FontSize',14,'FontName','Arial');
% set(gca,'linewidth',0.8)
% grid on
% % exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/end-effector_trajectory.eps');

figure(2)   % 末端轨迹图
plot(r(1, :), r(2, :), 'r','LineWidth',2); hold on 
i = 1; j = 1;
for t=t_span
    [a, b, c, d] = fish_rd(t);
    if mod(i,20)==0
        rd(:, j) = d; %#ok<*SAGROW> 
        j = j+1;
    end
    i = i+1;
end
plot(rd(1, :), rd(2, :), '-.bx','LineWidth',1.5); hold on 
xlabel('X (m)');
ylabel('Y (m)');
legend('Actual Trajectory', 'Desired Trajectory');
% view([0,0,pi/2])
grid on
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/end-effector_trajectory.eps');

figure(3)  % 关节角度
plot(t_span, state(:, 1:7));
% xlabel('\it{t} \text{s}','FontSize',24);
% ylabel('Joint Angle','FontSize',24);
legend('\theta_1', '\theta_2', '\theta_3', '\theta_4', '\theta_5', '\theta_6', '\theta_7', 'NumColumns', 3, 'Location', 'south');
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/joint_angle.eps');

figure(4)  % 关节角速度
dtheta = state(:,8:14);
ddtheta = state(:,21:27);
for i=1:7
    plot(t_span, dtheta(:,i), '-.','LineWidth',2);hold on
end
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$', '$\dot{\theta}_4$', '$\dot{\theta}_5$', '$\dot{\theta}_6$', '$\dot{\theta}_7$','Interpreter','latex', 'NumColumns', 3, 'Location', 'south');
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/joint_v.eps');

figure(5)  % 关节角加速度
for i=1:7
    plot(t_span, ddtheta(:,i));hold on
end
legend('$\ddot{\theta}_1$', '$\ddot{\theta}_2$', '$\ddot{\theta}_3$', '$\ddot{\theta}_4$', '$\ddot{\theta}_5$', '$\ddot{\theta}_6$', '$\ddot{\theta}_7$','Interpreter','latex', 'NumColumns', 3,'Location','south');
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/joint_a.eps');

figure(6)  % 末端参数
d = state(:,17:20);
yyaxis left
plot(t_span, d);
legend('alpha', 'a', 'd', 'const')
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/end-effector_paramters.eps');

figure(7)  % 末端位置
xpos = zeros(length(t_span), 3);
for i=1:length(t_span)
    xpos(i,:)=fka(state(i,1:7));
end
% subplot(1, 3, 1)
plot(t_span, xpos(:,1));hold on
plot(t_span, xpos(:,2));hold on
plot(t_span, xpos(:,3));
legend('r_a_x', 'r_a_y', 'r_a_z', 'Location', 'north')
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/end-effector_position.eps');

figure(8)  % RCM点位置
xPa = zeros(length(t_span), 3);
xPb = zeros(length(t_span), 3);
xPc = zeros(length(t_span), 3);
for i=1:length(t_span)
    xPa(i,:) = fka(state(i,1:7));
    xPb(i,:) = fkb(state(i,1:7));
    xPc(i,:) = xPb(i,:) + state(i,15)*(xPa(i,:)-xPb(i,:));
end
plot(t_span,xPc(:, 1));hold on
plot(t_span,xPc(:, 2));hold on
plot(t_span,xPc(:, 3));
legend('r_c_x', 'r_c_y', 'r_c_z')
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/RCM_point_position.eps');


figure(9)  % 本论文的RCM误差
xPa = zeros(length(t_span), 3);
xPb = zeros(length(t_span), 3);
xPc = zeros(length(t_span), 3);
for i=1:length(t_span)
    xPa(i,:) = fka(state(i,1:7));
    xPb(i,:) = fkb(state(i,1:7));
    xPc(i,:) = xPb(i,:) + state(i,15)*(xPa(i,:)-xPb(i,:));
end
plot(t_span,xPc(:, 1)-0.3074);hold on
plot(t_span,xPc(:, 2)-0);
xlabel('\it{t} (s)')
ylabel('error (m)')
legend('r_c_x error', 'r_c_y error', 'r_c_z error')
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/RCM_error.eps');

figure(10)   % 张国谦论文RCM误差
plot(t_store,e_operate(:,1:2));
xlabel('\it{t} (s)')
ylabel('error (m)')
legend('r_c_x error', 'r_c_y error', 'r_c_z error');
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/RCM_error_ZGQ.eps');


figure(11)   % 本论文末端位置误差
xpos = zeros(length(t_span), 3);
t = 0;
for i=1:length(t_span)
    [dddr, ddr, dr, rd]=fish_rd(t);
    t = t + 0.001;
    xpos(i,:)=fka(theta(i, :))-rd;
end
plot(t_span, xpos(:,1));hold on
plot(t_span, xpos(:,2));hold on
plot(t_span, xpos(:,3));
xlabel('\it{t} (s)')
ylabel('error (m)')
legend('r_a_x error', 'r_a_y error', 'r_a_z error', 'Location', 'southeast')
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/end-effector_error.eps');

figure(12)   % 张国谦论文末端位置误差
plot(t_store,e_store(:,1:3));
xlabel('\it{t} (s)')
ylabel('error (m)')
legend('r_a_x error','r_a_y error','r_a_z error','Location', 'southeast');
% exportgraphics(gcf,'../../MyDocument/ARCM_2022.12/eps/end-effector_error_ZGQ.eps');