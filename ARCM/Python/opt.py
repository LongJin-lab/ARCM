import mindspore.numpy as np
from mindspore import Tensor
import Jacba, fka, fkb

from scipy.integrate import odeint
import odefun

init_theta = np.array([[0], [-np.pi / 4], [0], [-np.pi * 3 / 4], [0], [np.pi / 2], [np.pi / 4]], np.float32)
dq = np.zeros((7, 1), np.float32)
ddq = np.zeros((7, 1), np.float32)

k = 0.5
dk = 0
ddk = 0
lambda1 = 0.1 * np.rand((3, 1))
lambda2 = 0.1 * np.rand((3, 1))
d = np.rand((4, 1))
dcompensate = np.zeros((4, 1))
ncompensate = np.zeros((14, 1))
P = 0.01
T = 20
t_span = np.linspace(0, 20, 20001)

JeA = Jacba.a(init_theta)
ra = fka.a(init_theta)
rb = fkb.b(init_theta)
init_rc = rb + k * (ra - rb)

X = np.concatenate((ddq.flatten(), np.array(ddk).flatten(), lambda1.flatten(), lambda2.flatten()))
X = Tensor(X, np.float32)
init_state = np.concatenate((init_theta.flatten(), dq.flatten(), np.array(k).flatten(), np.array(dk).flatten(), d.flatten(), X.flatten(), dcompensate.flatten(), ncompensate.flatten(), JeA.reshape(21, 1).flatten(), np.array(P).flatten()))
init_state = Tensor(init_state, np.float32)

sol = odeint(odefun.fun, init_state, t_span)
