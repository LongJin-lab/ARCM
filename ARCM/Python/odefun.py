import mindspore.numpy as np
from mindspore import Tensor
from mindspore.ops import operations as ops
import fka, fkb, Jacba, Jacbb, dJA, dJB, ddJB, fish_rd, get_T, get_dT, JEA, dJEA, get_M, get_B
from mindspore.ops import operations as Plus

def fun(state, t):
    state = Tensor(state, np.float32)
    theta = state[:7].reshape((7, 1))
    dtheta = state[7:14].reshape((7, 1))
    k = state[14]
    dk = state[15]
    d = state[16:20].reshape((4, 1))
    X = state[20:34].reshape((14, 1))
    ddtheta = X[:7]
    ddk = state[28]
    dcompensate = state[34:38].reshape((4, 1))
    ncompensate = state[38:52].reshape((14, 1))
    JeA = state[52:73].reshape(3, 7)
    P = state[73]
    
    alpha = 40
    beta = 10
    d0 = 50
    d1 = 10
    m1 = 0.1
    m2 = 0.1
    sigma = 100
    
    deta = np.array([50 + i * t for i in range(1, 5)], np.float32).reshape(4, 1)
    neta = np.array([50 + i * t for i in range(1, 15)], np.float32).reshape(14, 1)
    dgamma = 100
    dlambda = 100000
    ngamma = 100
    nlambda = 100000
    
    ra = fka.a(theta)
    rb = fkb.b(theta)
    rc = rb + k * (ra - rb)
    
    b = np.concatenate((ra, np.array([1], np.float32)), axis=0)
    
    Ja = Jacba.a(theta)
    Jb = Jacbb.b(theta)
    dJa = dJA.A(theta, dtheta)
    dJb = dJB.B(theta, dtheta)
    ddJb = ddJB.B(theta, dtheta, ddtheta)
    
    dddrd, ddrd, drd, rd = fish_rd.d(t)
    T = get_T.T(theta)
    dT = get_dT.T(theta, dtheta)

    dra = Ja @ Tensor(dtheta)
    drb = Jb @ dtheta
    ddra = dJa @ dtheta + Ja @ ddtheta
    db = np.concatenate((dra, np.array([0], np.float32)), axis=0)
    
    # nNSND
    dJeA = 10000 * (JEA.A(theta, d) - JeA)
    ddJeA = 100 * (dJEA.A(theta, dtheta, d) - dJeA)
    
    M, dM = get_M.M(JeA, dJeA, Jb, dJb, k, dk, ra, dra, rb, drb)
    B, dB = get_B.B(theta, dtheta, ddtheta, k, dk, ddk, JeA, dJeA, ddJeA, Jb, dJb, ddJb, rd, drd, ddrd, dddrd, ra, dra, ddra, rc)
    
    # dNSND
    dX = ops.linalg.pinv(M) * (dB - ops.matmul(dM, X) - nlambda * (ops.matmul(M, X) - B) - ngamma * ((ops.matmul(M, X) - B) + ngamma * nlambda * ncompensate)) + 100 * neta
    dncompensate = ops.matmul(M, X) - B
    
    dd = ops.linalg.pinv(T)*(db - ops.matmul(dT, d) - dlambda*(ops.matmul(T, d) - b) - dgamma*((T*d - b) + dgamma*dlambda*dcompensate)) + 100*deta
    ddcompensate = ops.matmul(T, d) - b
    
    # Kalman
    F = 1
    G = 1
    H = 1
    Q = 0.01
    R = 0.25
    W = Tensor(np.sqrt(Q) * np.random.randn(14, 1), np.float32)
    V = Tensor(np.sqrt(R) * np.random.randn(14, 1), np.float32)

    # 计算 K
    K = ops.matmul(ops.matmul(P, H), ops.linalg.pinv(R))

    # 计算 dX
    dX = F * dX + G * W + ops.matmul(K, V)

    # 计算 dP
    dP = F * P + ops.matmul(P, ops.transpose(F, (1, 0))) + Q - ops.matmul(ops.matmul(K, R), ops.transpose(K, (1, 0)))
    
    dstate = np.concatenate((dtheta.flatten(), ddtheta.flatten(), np.array(dk).flatten(), np.array(ddk).flatten(), dd.flatten(), dX.flatten(), ddcompensate.flatten(), dncompensate.flatten(), dJeA.reshape(21, 1).flatten(), np.array(dP).flatten()))
    
    print(t)
    
    return dstate
