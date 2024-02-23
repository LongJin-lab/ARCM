import numpy as np
import fish_r_d, fa, fb, JEA, Jacb1
from mindspore import Tensor
from mindspore.ops import operations as ops
from mindspore.ops import operations as Plus

def fun(state, t):
    init_theta = np.array([-0.0000, -0.785472, -0.00, -2.35425, -0.0000, 1.57164, 0.785465])
    init_theta = init_theta.T
    state.reshape((43, 1))
    theta = state[:7]
    dtheta = state[7:14]
    k = state[14]
    dk = state[15]
    lambda1 = state[16:19]
    lambda2 = state[19:22]
    J1 = state[22:].reshape(3, 7)
    
    c1=10
    c2=0.1
    c3=10
    
    dot_r_d_t, r_d_t=fish_r_d.d(t)
    ra = fa.a(theta)
    rb = fb.b(theta)
    rc = rb + k * (ra - rb)
    J2=JEA.A(theta)
    J0=Jacb1.Jacb(theta)
    W=k*J1+(1-k)*J2
    
    dd_theta=-1000*(dtheta+(theta-init_theta)+np.dot(lambda1.reshape((1, 3)),W).reshape((1, 7))+np.dot(lambda2.reshape((1, 3)),J1).reshape((1, 7))).reshape((1, 7))
    aa=-10000000*np.dot((np.dot(J1,dtheta.T)-np.dot(J0,dtheta.T)).reshape((3, 1)),dtheta.reshape((1, 7)))
    dot_J=aa.reshape(21, 1).T
    dd_k=-1000*(c2*dk+lambda1.T*(ra-rb))
    init_rc = np.array([0.3075, 0, 0.4408])
    d_lambda1=1000*(np.dot(W,dtheta.T)+dk*(ra-rb)+c1*(rc-init_rc))
    d_lambda2=1000*(np.dot(J1,dtheta.T)+c3*(ra-np.squeeze(r_d_t))-dot_r_d_t.reshape((3, 1)))
    
    dstate = np.concatenate((np.squeeze(dtheta), np.array(dd_theta).flatten(), np.array([dk]).flatten(), np.array([dd_k]).flatten(), np.squeeze(lambda1).flatten(),np.squeeze(lambda2).flatten(), np.array(dot_J[0]).flatten()))
    print(t)
    
    return dstate