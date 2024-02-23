import mindspore.numpy as mp
import numpy as np
from scipy.integrate import odeint
import zgq.Odefun as Odefun

init_theta = np.array([-0.0000, -0.785472, -0.00, -2.35425, -0.0000, 1.57164, 0.785465])
dq = np.zeros(7)
ddq = np.zeros(7)

k = 0.5
dk = 0
lambda1 = 0.1 * np.random.rand(3)
lambda2 = 0.1 * np.random.rand(3)
JeA = np.random.rand(3, 7) + 0.3 * np.random.rand(3, 7)
ra = np.array([0.3079, 0, 0.2903])
rb = np.array([0.3070, 0, 0.5913])
init_rc = rb + k * (ra - rb)

T = 20
t_span = np.arange(0, T, 0.01)

init_state = np.concatenate((init_theta, dq, [k, dk], lambda1, lambda2, JeA.flatten()))


state = odeint(Odefun.fun, init_state, t_span)
