clear; close all; clc

global init_theta init_rc
global alpha beta m1 m2 d0 d1 sigma


init_theta = [0,-0.785472,0,-2.35425,0,1.57164,0.785465]';
dtheta = zeros(7, 1);  
ddtheta = zeros(7, 1);

k = 0.5;   dk = 0;   ddk = 0;
lambda1 = 0.1*rands(3, 1);   lambda2 = 0.1*rands(3, 1);
JeA = Jacba(init_theta) + 0.3*rands(3, 7);
ra = fka(init_theta);
rb = fkb(init_theta);
init_rc = rb + k*(ra - rb);
d = [rand(); rand(); rand(); rand()];
% d = [0; 0; 0.4080; 1];
dcompensate = zeros(4, 1);
ncompensate = zeros(14, 1);
X = [ddtheta; ddk; lambda1; lambda2];

T = 20;   tspan = 0.00000001;   t_span = 0:tspan:T;

alpha = 40;   beta = 10;
d0 = 50;   d1 = 10;   m1 = 0.1;   m2 = 0.1;
sigma = 300;
dgamma = 1e2;   dlambda = 1e5; %  反直觉
ngamma = 1e2;   nlambda = 1e5;
theta = init_theta;

len = length(t_span);
thetaPlot = zeros(len, 7);
dthetaPlot = zeros(len, 7);
ddthetaPlot = zeros(len, 7);
kPlot = zeros(len, 1);
JeAPlot = zeros(len, 21);
dPlot = zeros(len, 4);
i = 1;
P = 0.01;

for t = t_span    
    ddtheta = X(1:7);   ddk = X(8);
    ddtheta = qLimit(ddtheta);
    deta = [50+1*t;50+2*t;50+3*t;50+4*t];
    neta = [50+1*t;50+2*t;50+3*t;50+4*t;50+5*t;50+6*t;50+7*t;50+8*t;50+9*t;50+10*t;50+11*t;50+12*t;50+13*t;50+14*t];
    
    ra = fka(theta);   b = [ra; 1];
    rb = fkb(theta);
    rc = rb + k*(ra - rb);
    
    Ja = Jacba(theta);   Jb = Jacbb(theta);
    dJa = dJA(theta, dtheta);   dJb = dJB(theta, dtheta);
    ddJb = ddJB(theta, dtheta, ddtheta);
    [dddrd, ddrd, drd, rd]=fish_rd(t);
    T = get_T(theta);   dT = get_dT(theta, dtheta);
    
    dra = Ja*dtheta;   db = [dra; 0];
    drb = Jb*dtheta;
    ddra = dJa*dtheta + Ja*ddtheta;
    

    % n
    dJeA = 10000*(JEA(theta, d) - JeA);
    ddJeA = 1000*(dJEA(theta, dtheta, d) - dJeA);
    [M, dM] = get_M(JeA, dJeA, Jb, dJb, k, dk, ra, dra, rb, drb);
    [B, dB] = get_B(theta, dtheta, ddtheta, k, dk, ddk, JeA, dJeA, ddJeA, Jb, dJb, ddJb, rd, drd, ddrd, dddrd, ra, dra, ddra, rc);
    dX = pinv(M)*(dB - dM*X - nlambda*linear(M*X - B) - ngamma*(linear(M*X - B) + nlambda*ncompensate)) + 100*neta;
    dncompensate = linear(M*X - B);

    % d
    dd = pinv(T)*(db - dT*d - dlambda*linear(T*d - b) - dgamma*(linear(T*d - b) + dlambda*dcompensate)) + 100*deta;
    ddcompensate = linear(T*d - b);

    % Iteration
    X = X + tspan*dX/100;
    d = d + tspan*dd;
    theta = theta + tspan*dtheta;
    dtheta = dtheta + tspan*ddtheta;
    k = k + tspan*dk/10;
    dk = dk + tspan*ddk/10;
    dcompensate = dcompensate + ddcompensate;
    ncompensate = ncompensate + dncompensate;
    JeA = JeA + tspan*dJeA;

    
%     parameter
    F = 1;
    G = 1;
    H = 1;
    I = eye(14);
    Q = 0.01;
    R = 0.25;
    W = sqrt(Q)*randn(14, 1);
    V = sqrt(R)*randn(14, 1);
    
    % kalman
    X = F*X + G*W;
    Z = H*X + V;
    P = F*P*F' + Q;
    Kg = P*pinv(H*P*H' + R);
    e = Z - H*X;
    X = X + Kg*e;
    P = (I - Kg*H)*P;


    thetaPlot(i, :) = theta';
    dthetaPlot(i, :) = dtheta';
    ddthetaPlot(i, :) = ddtheta';
    kPlot(i, 1) = k;
    JeAPlot(i, :) = reshape(JeA, 1, 21);
    dPlot(i, :) = d';
    i = i + 1;


    disp(t)

end

save thetaPlot.mat
% save dthetaPlot.mat
save ddthetaPlot.mat
save kPlot.mat
% save JeAPlot.mat
save t_span.mat






