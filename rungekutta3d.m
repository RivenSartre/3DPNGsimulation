function [xtreturn,ytreturn,ztreturn,alpharetuan,betareturn] = rungekutta3d(deltain,xtin,ytin,ztin,alphain,betain,at1in,at2in,vtin)
statetarget(1:5,1) = [xtin;ytin;ztin;alphain;betain];             %xn
dstatetarget(1:5,1) = [vtin*cos(statetarget(4,1))*cos(statetarget(5,1));vtin*cos(statetarget(4,1))*sin(statetarget(5,1));vtin*sin(statetarget(4,1));at1in/vtin;at2in/vtin];  %vt再试试加分量的形式
k1 = dstatetarget(1:5,1);

statetarget(1:5,2) = statetarget(1:5,1) + deltain*k1/2;
dstatetarget(1:5,2) = [vtin*cos(statetarget(4,2))*cos(statetarget(5,2));vtin*cos(statetarget(4,2))*sin(statetarget(5,2));vtin*sin(statetarget(4,2));at1in/vtin;at2in/vtin];
k2 = dstatetarget(1:5,2);

statetarget(1:5,3) = statetarget(1:5,1) + deltain*k2/2;
dstatetarget(1:5,3) = [vtin*cos(statetarget(4,3))*cos(statetarget(5,3));vtin*cos(statetarget(4,3))*sin(statetarget(5,3));vtin*sin(statetarget(4,3));at1in/vtin;at2in/vtin];
k3 = dstatetarget(1:5,3);

statetarget(1:5,4) = statetarget(1:5,1) + deltain*k3;
dstatetarget(1:5,4) = [vtin*cos(statetarget(4,4))*cos(statetarget(5,4));vtin*cos(statetarget(4,4))*sin(statetarget(5,4));vtin*sin(statetarget(4,4));at1in/vtin;at2in/vtin];
k4 = dstatetarget(1:5,4);

returnvalue = 1/6*deltain*(k1 + 2*k2 +2*k3 + k4);
xtreturn = returnvalue(1,1);
ytreturn = returnvalue(2,1);
ztreturn = returnvalue(3,1);
alpharetuan = returnvalue(4,1);
betareturn = returnvalue(5,1);




































% function detlay = rungekutta3d(deltain,valuein)
% delta = deltain;
% y1 = delta*valuein;
% y2 = delta*(valuein + y1/2);
% y3 = delta*(valuein + y2/2);
% y4 = delta*(valuein + y3);
% detlay = 1/6*(y1 + 2*y2 +2*y3 + y4);