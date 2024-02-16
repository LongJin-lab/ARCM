function [M ,dM] = getM(JeA, dJeA, Jb, dJb, k, dk, ra, dra, rb, drb)

global m2

M = [
                eye(7),  zeros(7, 1),         JeA',  (k*JeA + (1 - k)*Jb)';
           zeros(1, 7),           m2,  zeros(1, 3),             (ra - rb)';
                   JeA,  zeros(3, 1),  zeros(3, 3),            zeros(3, 3);
  (k*JeA + (1 - k)*Jb),    (ra - rb),  zeros(3, 3),            zeros(3, 3);
];

dM = [
                              zeros(7, 7),   zeros(7, 1),        dJeA',  (dk*JeA + k*dJeA + (1 - k)*dJb - dk*Jb)';
                              zeros(1, 7),   zeros(1, 1),  zeros(1, 3),                              (dra - drb)';
                                     dJeA,   zeros(3, 1),  zeros(3, 3),                               zeros(3, 3);
  (dk*JeA + k*dJeA + (1 - k)*dJb - dk*Jb),   (dra - drb),  zeros(3, 3),                               zeros(3, 3);
];


end