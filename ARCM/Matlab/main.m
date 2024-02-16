clear; close all; clc

global init_theta init_rc %#ok<GVMIS> 

init_theta = [-0.0000,-0.785472,-0.00,-2.35425,-0.0000,1.57164,0.785465]';
dq = zeros(7, 1);   ddq = zeros(7, 1);

k = 0.5;   dk = 0;   ddk = 0;
lambda1 = 0.1*rands(3, 1);   lambda2 = 0.1*rands(3, 1);
JeA = Jacba(init_theta) + 0.3*rands(3, 7);
ra = fka(init_theta);
rb = fkb(init_theta);
init_rc = rb + k*(ra - rb);
d = [rand(); rand(); rand(); rand()];
dcompensate = zeros(4, 1);
ncompensate = zeros(14, 1);
X = [ddq; ddk; lambda1; lambda2];
P = 0.01;

T = 20;   t_span = 0:0.01:T;

init_state = [init_theta; dq; k; dk; d; X; dcompensate; ncompensate; reshape(JeA, 21, 1); P];

[t_sample, state] = ode45(@odefun, t_span, init_state);

save state.mat
