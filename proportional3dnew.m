% function [qshui,qchui] = proportional3dnew(xnpin,xt,xm,yt,ym,zt,zm,initialqshui,initialdeltashui,initialqchui,initialdeltachui)
function [ddeltachui,ddeltashui,qchui,qshui] = proportional3dnew(delta,vm,xnp,initialqchui,initialqshui,xt,xm,yt,ym,zt,zm)
qchui = atan((zt-zm)/(xt-xm));
qshui = atan((yt-ym)/(xt-xm));
ddeltachui = vm*xnp*((qchui - initialqchui)/delta);
ddeltashui = vm*xnp*((qshui - initialqshui)/delta);
% xnp = xnpin;
% deltashui = xnp*((qshui - initialqshui)) + initialdeltashui;
% deltachui = xnp*((qchui - initialqchui)) + initialdeltachui;


