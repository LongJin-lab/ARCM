function dstate = odefun(t, state)
 
% global init_theta init_rc %#ok<GVMIS> 
global alpha beta m1 m2 d0 d1 sigma %#ok<GVMIS> 

theta = state(1:7);   dtheta = state(8:14);
k = state(15);   dk = state(16);
d = state(17:20);
X = state(21:34);
ddtheta = X(1:7);   ddk = X(8);   % lambda1 = X(9:11);   lambda2 = X(12:14);
dcompensate = state(35:38);
ncompensate = state(39:52);
JeA = reshape(state(53:73), 3, 7);
P = state(74);

ddtheta = qLimit(ddtheta);

% zeta = 1e5;
alpha = 40;   beta = 10;
d0 = 50;   d1 = 10;   m1 = 0.1;   m2 = 0.1;
sigma = 100;
deta = [50+1*t;50+2*t;50+3*t;50+4*t];
neta = [50+1*t;50+2*t;50+3*t;50+4*t;50+5*t;50+6*t;50+7*t;50+8*t;50+9*t;50+10*t;50+11*t;50+12*t;50+13*t;50+14*t];
dgamma = 1e2;   dlambda = 1e5;
ngamma = 1e2;   nlambda = 1e5;

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

% 原程序
% W = k*JeA + (1 - k)*Jb;
% dJeA = 10000*(JEA(theta, d) - JeA);
% dddtheta = -zeta*(ddtheta + (alpha*dtheta + beta*(theta - init_theta)) + JeA'*lambda1 + W'*lambda2);
% dddk = -zeta*(m1*dk + m2*ddk + lambda2'*(ra - rb));
% dlambda1 = zeta*(JeA*ddtheta - ddrd + dJeA*dtheta - d0*(rd - ra) - d1*(drd - dra));
% dlambda2 = zeta*(W*ddtheta + (2*dk*(JeA - Jb) + k*dJeA + (1 - k)*dJb)*dtheta + ddk*(ra - rb) + sigma*(rc - init_rc));

% nNSND
dJeA = 10000*(JEA(theta, d) - JeA);
ddJeA = 100*(dJEA(theta, dtheta, d) - dJeA);
[M, dM] = get_M(JeA, dJeA, Jb, dJb, k, dk, ra, dra, rb, drb);
[B, dB] = get_B(theta, dtheta, ddtheta, k, dk, ddk, JeA, dJeA, ddJeA, Jb, dJb, ddJb, rd, drd, ddrd, dddrd, ra, dra, ddra, rc);
% parameter of end-effetor
dX = pinv(M)*(dB - dM*X - nlambda*linear(M*X - B) - ngamma*(linear(M*X - B) + ngamma*nlambda*ncompensate)) + 100*neta;
dncompensate = linear(M*X - B);

% dNSND
% noise-supperising during working
dd = pinv(T)*(db - dT*d - dlambda*linear(T*d - b) - dgamma*(linear(T*d - b) + dgamma*dlambda*dcompensate)) + 100*deta;
ddcompensate = linear(T*d - b);

% Kalman filter
F = 1;
G = 1;
H = 1;
Q = 0.01;
R = 0.25;
W = sqrt(Q)*randn(14, 1);
V = sqrt(R)*randn(14, 1);

K = P*H*pinv(R);
dX = F*dX + G*W + K*V;
dP = F*P + P*F' + Q - K*R*K';


dstate = [dtheta; ddtheta; dk; ddk; dd; dX; ddcompensate; dncompensate; reshape(dJeA, 21, 1); dP];

disp(t)
end
