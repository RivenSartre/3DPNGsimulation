clear
clc
g = 9.81; 
delta = 0.1;                          %���沽��0.01s

%beta = [];                                %Ŀ���ٶȷ�����ˮƽ��׼�ļн�
beta(1) = (pi/180)*0;
%alpha = [];                               %Ŀ���ٶȷ����봹ֱ��׼�ļн�
alpha(1) = (pi/180)*0;       
%at1 = [] ;
%at2 = [];
at1(1) = 0;
at2(1) = 0;

xnp = 4;       %��Ч������
vt = 250;
%vtx = [];
%vty = [];
%vtz = [];
vtx(1) = vt*cos(alpha(1))*cos(beta(1));        %������Ŀ����x���������
vty(1) = vt*cos(alpha(1))*sin(beta(1));         %������Ŀ����y���������
vtz(1) = vt*sin(alpha(1));                                %Ŀ����z���������Ϸ�

vm = 300;
xm(1) = 0;
ym(1) = 0;
zm(1) = 0;
pm(:,1) = [xm(1);ym(1);zm(1)];
xt(1) = 100000;
yt(1) = 100000;
zt(1) = 0;
pt(:,1) = [xt(1);yt(1);zt(1)];

%time = [];
time(1) = delta;
overload = [];
overload(1) = 0;
qshui = [];                %ˮƽ����ĵ�Ŀ���߽�
qshui(1) = atan((yt(1) - ym(1))/(xt(1) - xm(1)));
qchui = [];                %��ֱ����ĵ�Ŀ���߽�
qchui(1) = atan((zt(1) - zm(1))/(xt(1) - xm(1)));
deltashui = [];          %ˮƽ�����ϵ����ٶȷ������׼�ļн�
deltashui(1) = 0;
deltachui = [];          %��ֱ�����ϵ����ٶȷ������׼�ļн�
deltachui(1) = 0;
vmx = [];
vmy = [];
vmz = [];
vmx(1) = vm*cos(deltachui(1))*cos(deltashui(1));
vmy(1) = vm*cos(deltachui(1))*sin(deltashui(1));
vmz(1) = vm*sin(deltachui(1));
amshui = [];
amchui = [];
am = [] ;
amshui(1) = 0;
amchui(1) = 0;
am(1) = 0;

for k = 2:1:10000
%%%%%%%%%%%%%һ��ŷ�����ַ�%%%%%%%%%%%%%%
%     xt(k) = xt(k-1) + delta*vtx(k-1);
%     yt(k) = yt(k-1) + delta*vty(k-1);
%     zt(k) = zt(k-1) + delta*vtz(k-1);
%     alpha(k) = alpha(k-1) + delta*at1/vt;
%     beta(k) = beta(k-1) + delta*at2/vt;
%     vtx(k) = -vt*cos(alpha(k))*cos(beta(k));
%     vty(k) = -vt*cos(alpha(k))*sin(beta(k));
%     vtz(k) = vt*sin(alpha(k));
%%%%%%%%%%%%���Ϲ�ʽ������غ���%%%%%%%%%%%%
    [vtx(k),vty(k),vtz(k),xt(k),yt(k),zt(k),alpha(k),beta(k),at1(k),at2(k)] = squaremotorized3dnew(k,vt,delta,xt(k-1),yt(k-1),zt(k-1),alpha(k-1), beta(k-1),vtx(k-1),vty(k-1),vtz(k-1));
    pt(:,k) = [xt(k);yt(k);zt(k)];
    r = sqrt((pt(1,k) - pm(1,k-1))^2 + (pt(2,k) - pm(2,k-1))^2 + (pt(3,k) - pm(3,k-1))^2);     %��ǰ��Ŀ����r

%     qshui(k) = atan((yt(k) - ym(k-1))/(xt(k) - xm(k-1)));
%     qchui(k) = atan((zt(k) - zm(k-1))/(xt(k) - xm(k-1)));
%     deltashui(k) = xnp*(qshui(k) - qshui(k-1)) + deltashui(k-1);
%     deltachui(k) = xnp*(qchui(k) - qchui(k-1)) + deltachui(k-1);
%%%%%%%%%%%%���Ϲ�ʽ������غ���%%%%%%%%%%%%
   % [qshui(k),qchui(k),deltashui(k), deltachui(k)] = proportional3dnew(xnp,xt(k),xm(k-1),yt(k),ym(k-1),zt(k),zm(k-1),qshui(k-1),deltashui(k-1),qchui(k-1),deltachui(k-1));
    [ddeltachui,ddeltashui,qchui(k),qshui(k)] = proportional3dnew(delta,vm,xnp,qchui(k-1),qshui(k-1),xt(k),xm(k-1),yt(k),ym(k-1),zt(k),zm(k-1));
    [xtreturn,ytreturn,ztreturn,deltachuireturn,deltashuiretuan] = rungekutta3d(delta,xm(k-1),ym(k-1),zm(k-1),deltachui(k-1),deltashui(k-1),ddeltachui,ddeltashui,vm);
    xm(k) = xm(k-1) + xtreturn;   %�����ǰ�ǰһʱ�̵��ٶȷ���ɻ��ǰ���һʱ���ٶȷ����?
    ym(k) = ym(k-1) + ytreturn;
    zm(k) = zm(k-1) + ztreturn;
    deltachui(k) = deltachui(k-1) + deltachuireturn;
    deltashui(k) = deltashui(k-1) + deltashuiretuan;
    vmx(k) = vm*cos(deltachui(k))*cos(deltashui(k));
    vmy(k) = vm*cos(deltachui(k))*sin(deltashui(k));
    vmz(k) = vm*sin(deltachui(k));
    pm(:,k) = [xm(k);ym(k);zm(k)];
    amchui(k) = vm*sin(deltachui(k))*(deltachui(k) - deltachui(k-1));
    amshui(k) = vm*cos(deltachui(k))*(deltashui(k) - deltashui(k-1));
    am(k) = sqrt((amshui(k))^2 + (amchui(k))^2);
    time(k) = k*delta;
    if(r < 300)
        break;
    end
end

pmx = xm(1:k);
pmy = ym(1:k);
pmz = zm(1:k);
ptx = xt(1:k);
pty = yt(1:k);
ptz = zt(1:k);

subplot(1,3,1);
plot3(pmx/1000,pmy/1000,pmz/1000,'linewidth',1.0);
hold on;
plot3(ptx/1000,pty/1000,ptz/1000,'--','linewidth',1.0);
axis tickaligned
xlabel('����λ��(km)');
ylabel('����λ��(km)');
zlabel('��ֱλ��(km)');
title('��ά�ռ����������(��ά�ռ�)');
legend('����','Ŀ��');
hold off;
grid on 

subplot(1,3,2);
plot(ptx/1000,pty/1000,'linewidth',1.0);
hold on;
plot(pmx/1000,pmy/1000,'--','linewidth',1.0);
axis tickaligned
xlabel('����λ��(km)');
ylabel('����λ��(km)');
title('��ά�ռ����������(ˮƽƽ��)');
legend('����','Ŀ��');
hold off;
grid on 

subplot(1,3,3);
plot(pty/1000,ptz/1000,'linewidth',1.0);
hold on;
plot(pmy/1000,pmz/1000,'--','linewidth',1.0);
axis tickaligned
xlabel('����λ��(km)');
ylabel('��ֱλ��(km)');
title('��ά�ռ����������(Ǧ��ƽ��)');
legend('����','Ŀ��');
hold off;
grid on 

% subplot(1,2,2);
% hold on;
% plot(time,am);
% xlabel('ʱ��(s)');
% ylabel('����������ٶ�(m/s^2)');
% title('����������');
% hold off;