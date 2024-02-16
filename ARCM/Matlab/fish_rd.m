function [dddr, ddr, dr,r]=fish_rd(t)

global init_theta

T=20;
ra=fka(init_theta);

x0=ra(1);
y0=ra(2);
z0=ra(3);
a=2*pi;
size_d=0.015;
rx = a *(cos(a*t/T) - ((sin (a*t/T))^2/sqrt(2)));
ry = a *sin(a*t/T) *cos(a*t/T);

rx=x0+size_d*(rx-a);
ry=y0+size_d*ry;
rz=z0;
drx = -(3*a*((a*sin((a*t)/T))/T + (2^(1/2)*a*cos((a*t)/T)*sin((a*t)/T))/T))/200;
dry = (3*a^2*cos((a*t)/T)^2)/(200*T) - (3*a^2*sin((a*t)/T)^2)/(200*T);
drz=0;
ddrx = -(3*a*((a^2*cos((a*t)/T))/T^2 + (2^(1/2)*a^2*cos((a*t)/T)^2)/T^2 - (2^(1/2)*a^2*sin((a*t)/T)^2)/T^2))/200;
ddry = -(3*a^3*cos((a*t)/T)*sin((a*t)/T))/(50*T^2);
ddrz = 0;

dddrx = (3*a*((a^3*sin((a*t)/T))/T^3 + (4*2^(1/2)*a^3*cos((a*t)/T)*sin((a*t)/T))/T^3))/200;
dddry = (3*a^4*sin((a*t)/T)^2)/(50*T^3) - (3*a^4*cos((a*t)/T)^2)/(50*T^3);
dddrz = 0;

r=[rx;ry;rz];
dr=[drx;dry;drz];
ddr=[ddrx;ddry;ddrz];
dddr=[dddrx;dddry;dddrz];

end
