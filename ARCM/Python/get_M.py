
import mindspore.numpy as np
from mindspore import Tensor
from mindspore.ops import operations as P

def M(JeA, dJeA, Jb, dJb, k, dk, ra, dra, rb, drb):
    m2 = 0.1

    # Define constants
    eye7 = np.array([
    [1, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 0, 1]
    ], np.float32)
    zeros7_1 = np.array([0, 0, 0, 0, 0, 0, 0], np.float32).reshape(7, 1)
    zeros1_7 = np.array([0, 0, 0, 0, 0, 0, 0], np.float32).reshape(1, 7)
    zeros3_3 = np.array([0, 0, 0, 0, 0, 0, 0, 0, 0], np.float32).reshape(3, 3)
    zeros1_3 = np.array([0, 0, 0], np.float32).reshape(1, 3)
    zeros3_1 = np.array([0, 0, 0], np.float32).reshape(3, 1)
    
    M11 = np.concatenate((eye7, zeros7_1, JeA.T, (k*JeA + (1 - k)*Jb).T), axis=1)
    M12 = np.concatenate((zeros1_7, m2, zeros1_3, ra - rb), axis=1)
    M13 = np.concatenate((JeA, zeros3_1, zeros3_3, zeros3_3), axis=1)
    M14 = np.concatenate((k*JeA + (1 - k) * Jb, ra - rb, zeros3_3, zeros3_3), axis=1)
    M1 = np.concatenate((M11, M12, M13, M14), axis=0)

    return M1, dM1
