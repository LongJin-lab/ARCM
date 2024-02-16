import mindspore.numpy as np
from mindspore import Tensor
import mindspore.ops as ops

def B(theta, dtheta, ddtheta, k, dk, ddk, JeA, dJeA, ddJeA, Jb, dJb, ddJb, rd, drd, ddrd, dddrd, ra, dra, ddra, rc):
    init_rc = np.array([[3.06890577e-01], [ 0.00000000e+00], [4.39782083e-01]], np.float32)
    init_theta = np.array([[0], [-np.pi / 4], [0], [-np.pi * 3 / 4], [0], [np.pi / 2], [np.pi / 4]], np.float32)
    alpha = 40
    beta = 10
    m1 = 0.1
    d0 = 50
    d1 = 10
    sigma = 100
    B1 = Tensor([
        -(alpha*dtheta+beta*(theta-init_theta)),
        -m1*dk,
        ddrd-dJeA*dtheta+d0*(rd-ra)+d1*(drd-dra),
        -(2*dk*(JeA-Jb)+k*dJeA+(1-k)*dJb)*dtheta-sigma*(rc-init_rc)
    ], np.float32)

    dB1 = Tensor([
        -(alpha*ddtheta+beta*dtheta),
        -m1*ddk,
        dddrd-ddJeA*dtheta-dJeA*ddtheta+d0*(drd-dra)+d1*(ddrd-ddra),
        -(2*ddk*(JeA-Jb)+2*dk*(dJeA-dJb)+dk*dJeA+k*ddJeA+(1-k)*ddJb-dk*dJb)*dtheta-(2*dk*(JeA-Jb)+k*dJeA+(1-k)*dJb)*ddtheta-10*sigma*(rc-init_rc)
    ], np.float32)

    return B1, dB1