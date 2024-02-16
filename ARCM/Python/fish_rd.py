import mindspore.numpy as np
import math
from math import cos, sin

def d(t):
    init_theta = [[0], [-math.pi / 4], [0], [-math.pi * 3 / 4], [0], [math.pi / 2], [math.pi / 4]]
    T = 20
    ra =[
        [0.307869801227108],
        [0],
        [0.290298255968448]
        ]
    x0 = ra[0][0]
    y0 = ra[1][0]
    z0 = ra[2][0]
    a = 2 * math.pi
    size_d = 0.015
    # rx = a * (cos(a * t / T) - ((sin(a * t / T)) ** 2 / math.sqrt(2)))
    # ry = a * sin(a * t / T) * cos(a * t / T)

    rx = x0 + size_d * (a * (cos(a * t / T) - ((sin(a * t / T)) ** 2 / math.sqrt(2))) - a)
    ry = y0 + size_d * a * sin(a * t / T) * cos(a * t / T)
    rz = z0
    drx = -(3 * a * ((a * sin((a * t) / T)) / T + (2 ** (1 / 2) * a * cos((a * t) / T) * sin((a * t) / T)) / T)) / 200
    dry = (3 * a ** 2 * cos((a * t) / T) ** 2) / (200 * T) - (3 * a ** 2 * sin((a * t) / T) ** 2) / (200 * T)
    drz = 0
    ddrx = -(3 * a * ((a ** 2 * cos((a * t) / T)) / T ** 2 + (2 ** (1 / 2) * a ** 2 * cos((a * t) / T) ** 2) / T ** 2 - (2 ** (1 / 2) * a ** 2 * sin((a * t) / T) ** 2) / T ** 2)) / 200
    ddry = -(3 * a ** 3 * cos((a * t) / T) * sin((a * t) / T)) / (50 * T ** 2)
    ddrz = 0

    dddrx = (3 * a * ((a ** 3 * sin((a * t) / T)) / T ** 3 + (4 * 2 ** (1 / 2) * a ** 3 * cos((a * t) / T) * sin((a * t) / T)) / T ** 3)) / 200
    dddry = (3 * a ** 4 * sin((a * t) / T) ** 2) / (50 * T ** 3) - (3 * a ** 4 * cos((a * t) / T) ** 2) / (50 * T ** 3)
    dddrz = 0

    r = np.array([rx, ry, rz], np.float32).reshape((3, 1))
    dr = np.array([drx, dry, drz], np.float32).reshape((3, 1))
    ddr = np.array([ddrx, ddry, ddrz], np.float32).reshape((3, 1))
    dddr = np.array([dddrx, dddry, dddrz], np.float32).reshape((3, 1))

    return dddr, ddr, dr, r
