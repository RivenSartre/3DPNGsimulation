function [vtx,vty,vtz,xt,yt,zt,alpha,beta,at1,at2] = squaremotorized3dnew(kin,vtin,deltain,initialxt,initialyt,initialzt,initialalpha,initialbeta,initialvtx,initialvty,initialvtz)

vt = vtin;
g = 9.81;
k = kin;
delta =deltain;           %步进值  单位：s
% %%%%%竖直方向%%%%%%
% t11 = 5;                        %开始方波机动的时刻    单位：s
% t12 = 7;                        %方波机动加速度换向时刻
% t13 = 9;                      %方波机动加速度换向时刻
% t14 = 10;                      %方波机动结束时刻
% At1 = 10;                     %竖直方向正弦机动幅值
% %%%%%水平方向%%%%%%
% t21 = 5;                        %开始方 波机动的时刻    单位：s
% t22 = 7;                        %方波机动加速度换向时刻
% t23 = 9;                      %方波机动加速度换向时刻
% t24 = 10;                      %方波机动结束时刻
% At2 = 10;                     %水平方向正弦机动幅值
% %%%%%竖直方向%%%%%%
% if(k*delta < t11)
%     at1 = 0*g;
% end
% if((k*delta >= t11)&&(k*delta <t12))
%     at1 = At1*g;
% end
% if((k*delta >= t12)&&(k*delta <t13))
%     at1 = -At1*g;
% end
% if((k*delta >= t13)&&(k*delta <t14))
%     at1 = At1*g;
% end
% if(k*delta >= t14)
%     at1 = 0*g;
% end
% %%%%%水平方向%%%%%%
% if(k*delta < t21)
%     at2 = 0*g;
% end
% if((k*delta >= t21)&&(k*delta <t22))
%     at2 = At2*g;
% end
% if((k*delta >= t22)&&(k*delta <t23))
%     at2 = -At2*g;
% end
% if((k*delta >= t23)&&(k*delta <t24))
%     at2 = At2*g;
% end
% if(k*delta >= t24)
%     at2 = 0*g;
% end
at1 = 1;
at2 = 1;

[xtreturn,ytreturn,ztreturn,alpharetuan,betareturn] = rungekutta3d(delta,initialxt,initialyt,initialzt,initialalpha,initialbeta,at1,at2,vt);
xt = initialxt - xtreturn;
yt = initialyt - ytreturn;
zt = initialzt + ztreturn;
alpha = initialalpha + alpharetuan;
beta = initialbeta + betareturn;
vtx = vt*cos(alpha)*cos(beta);
vty = vt*cos(alpha)*sin(beta);
vtz = vt*sin(alpha);

% alpha = initialalpha + rungekutta3d(delta,at1/(vt));
% beta = initialbeta + rungekutta3d(delta,at2/vt);        %delta*at/vt;
% vtx = -vt*cos(alpha)*cos(beta);
% vty = -vt*cos(alpha)*sin(beta);
% vtz = vt*sin(alpha);
% xt = initialxt + rungekutta3d(delta,initialvtx);
% yt = initialyt + rungekutta3d(delta,initialvty);
% zt = initialzt + rungekutta3d(delta,initialvtz);












