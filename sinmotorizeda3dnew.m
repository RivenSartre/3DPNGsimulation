function [vtx,vty,vtz,xt,yt,zt,alpha,beta,at1,at2] = sinmotorizeda3dnew(kin,vtin,deltain,initialxt,initialyt,initialzt,initialalpha,initialbeta,initialvtx,initialvty,initialvtz)
vt = vtin;
g = 9.81;
k = kin;
delta =deltain;           %步进值  单位：s
tnow = k*delta;
t01 = 0;                        %竖直方向开始正弦机动的时刻    单位：s
At1 = 10;                     %竖直方向正弦机动幅值
f1 = 0.1;                          %竖直方向正弦机动加速度的频率
t01stop = 1000;

t02 = 0;                        %水平方向开始正弦机动的时刻    单位：s
At2 = 0;                        %水平方向正弦机动幅值
f2 = 0.1;                         %水平方向正弦机动加速度的频率
if(k*delta < t01)
    at1 = 0*g;
end
if(k*delta >= t01)&&(k*delta < t01stop)
     at1 = At1*g*sin(2*pi*f1*(tnow - t01));
end
if(k*delta >= t01stop)
    at1 = 0*g;
end
if(k*delta < t02)
    at2 = 0*g;
end
if(k*delta >= t02)
    at2 = At2*g*sin(2*pi*f2*(tnow - t02));
end

[xtreturn,ytreturn,ztreturn,alpharetuan,betareturn] = rungekutta3d(delta,initialxt,initialyt,initialzt,initialalpha,initialbeta,at1,at2,vt);
xt = initialxt - xtreturn;
yt = initialyt - ytreturn;
zt = initialzt + ztreturn;
alpha = initialalpha + alpharetuan;
beta = initialbeta + betareturn;
vtx = vt*cos(alpha)*cos(beta);
vty = vt*cos(alpha)*sin(beta);
vtz = vt*sin(alpha);

% alpha = initialalpha + rungekutta3d(delta,at1/vt);
% beta = initialbeta + rungekutta3d(delta,at2/vt);      %delta*at/vt;
% vtx = -vt*cos(alpha)*cos(beta);
% vty = -vt*cos(alpha)*sin(beta);
% vtz = vt*sin(alpha);
% xt = initialxt + rungekutta3d(delta,initialvtx);
% yt = initialyt + rungekutta3d(delta,initialvty);
% zt = initialzt + rungekutta3d(delta,initialvtz);












