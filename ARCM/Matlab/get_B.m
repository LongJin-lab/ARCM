function[B,dB]=get_B(theta,dtheta,ddtheta,k,dk,ddk,JeA,dJeA,ddJeA,Jb,dJb,ddJb,rd,drd,ddrd,dddrd,ra,dra,ddra,rc)

global init_rc init_theta
global alpha beta m1 d0 d1 sigma

B=[
    -(alpha*dtheta+beta*(theta-init_theta));
    -m1*dk;
    ddrd-dJeA*dtheta+d0*(rd-ra)+d1*(drd-dra);
    -(2*dk*(JeA-Jb)+k*dJeA+(1-k)*dJb)*dtheta-sigma*(rc-init_rc)
];

dB=[
    -(alpha*ddtheta+beta*dtheta);
    -m1*ddk;
    dddrd-ddJeA*dtheta-dJeA*ddtheta+d0*(drd-dra)+d1*(ddrd-ddra);
    -(2*ddk*(JeA-Jb)+2*dk*(dJeA-dJb)+dk*dJeA+k*ddJeA+(1-k)*ddJb-dk*dJb)*dtheta-(2*dk*(JeA-Jb)+k*dJeA+(1-k)*dJb)*ddtheta-10*sigma*(rc-init_rc)
];

end