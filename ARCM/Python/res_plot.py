import scipy.io
import numpy as np
import matplotlib.pyplot as plt
import fa
import fb

data = scipy.io.loadmat('state.mat')
state = data['state']

T = 20
t_span = np.arange(0, T, 0.001)

fig = plt.figure()
ax = fig.add_subplot(111)

theta = state[:, 0:7]
r = np.zeros((3, len(t_span)))
for i in range(len(t_span)):
    r[:, i] = np.squeeze(fa.a(theta[i, :]))

ax.plot(r[0, :], r[1, :])
ax.set_xlabel('x', fontsize=12)
ax.set_ylabel('y', fontsize=12)
ax.set_title('Manipulator Path')
ax.grid(True)

r_draw = np.zeros((3, len(t_span), 8))
for i in range(0, len(t_span), 10):
    r_draw[:, i, 7] = np.squeeze(fa.a(state[i, 0:7]))

for j in range(0, len(t_span), 10):
    ax.plot(r_draw[0, j], r_draw[1, j], 'g.', linewidth=3)

plt.show()