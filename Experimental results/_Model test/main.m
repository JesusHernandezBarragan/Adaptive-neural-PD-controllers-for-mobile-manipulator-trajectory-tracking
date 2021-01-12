clear all
close all
clc

% % %
load('Prueba_3 test 1/e.dat')
load('Prueba_3 test 1/q.dat')
load('Prueba_3 test 1/qp.dat')
load('Prueba_3 test 1/t.dat')
load('Prueba_3 test 1/x.dat')
load('Prueba_3 test 1/xd.dat')

I = t<=20;
t = t(I);
xd = xd(:,I);
x = x(:,I);
q = q(:,I);
qp = qp(:,I);

t1.e = e;
t1.q = q;
t1.qp = qp;
t1.t = t;
t1.x = x;
t1.xd = xd;

load('Prueba_3 test 2/e.dat')
load('Prueba_3 test 2/q.dat')
load('Prueba_3 test 2/qp.dat')
load('Prueba_3 test 2/t.dat')
load('Prueba_3 test 2/x.dat')
load('Prueba_3 test 2/xd.dat')

I = t<=20;
t = t(I);
xd = xd(:,I);
x = x(:,I);
q = q(:,I);
qp = qp(:,I);

t2.e = e;
t2.q = q;
t2.qp = qp;
t2.t = t;
t2.x = x;
t2.xd = xd;

load('Prueba_3 test 3/e.dat')
load('Prueba_3 test 3/q.dat')
load('Prueba_3 test 3/qp.dat')
load('Prueba_3 test 3/t.dat')
load('Prueba_3 test 3/x.dat')
load('Prueba_3 test 3/xd.dat')

I = t<=20;
t = t(I);
xd = xd(:,I);
x = x(:,I);
q = q(:,I);
qp = qp(:,I);

t3.e = e;
t3.q = q;
t3.qp = qp;
t3.t = t;
t3.x = x;
t3.xd = xd;

% % %
n = min([numel(t1.t) numel(t2.t) numel(t3.t)]);
t = t1.t(1:n); 
xd = t1.xd(:,1:n);

t1.e = t1.e(:,1:n);
t1.q = t1.q(:,1:n);
t1.qp = t1.qp(:,1:n);
t1.x = t1.x(:,1:n);

t2.e = t2.e(:,1:n);
t2.q = t2.q(:,1:n);
t2.qp = t2.qp(:,1:n);
t2.x = t2.x(:,1:n);

t3.e = t3.e(:,1:n);
t3.q = t3.q(:,1:n);
t3.qp = t3.qp(:,1:n);
t3.x = t3.x(:,1:n);

%%
f = figure;

subplot(3,1,1)
hold on 
grid on
plot(t,xd(1,:),'-','LineWidth',1.5)
plot(t,t1.x(1,:),'--','LineWidth',1.5)
plot(t,t2.x(1,:),'-.','LineWidth',1.5)
plot(t,t3.x(1,:),':','LineWidth',1.5)
xlabel('time (s)')
ylabel('x-axis (m)')

lu = max([xd(1,:) t1.x(1,:) t2.x(1,:) t3.x(1,:)]);
ld = min([xd(1,:) t1.x(1,:) t2.x(1,:) t3.x(1,:)]);
ylim([ld-0.01 lu+0.01])
title('A) System response for x-axis')


subplot(3,1,2)
hold on 
grid on
plot(t,xd(2,:),'-','LineWidth',1.5)
plot(t,t1.x(2,:),'--','LineWidth',1.5)
plot(t,t2.x(2,:),'-.','LineWidth',1.5)
plot(t,t3.x(2,:),':','LineWidth',1.5)
xlabel('time (s)')
ylabel('y-axis (m)')

lu = max([xd(2,:) t1.x(2,:) t2.x(2,:) t3.x(2,:)]);
ld = min([xd(2,:) t1.x(2,:) t2.x(2,:) t3.x(2,:)]);
ylim([ld-0.01 lu+0.01])
title('B) System response for y-axis')

subplot(3,1,3)
hold on 
grid on
plot(t,xd(3,:),'-','LineWidth',1.5)
plot(t,t1.x(3,:),'--','LineWidth',1.5)
plot(t,t2.x(3,:),'-.','LineWidth',1.5)
plot(t,t3.x(3,:),':','LineWidth',1.5)
xlabel('time (s)')
ylabel('z-axis (m)')

lu = max([xd(3,:) t1.x(3,:) t2.x(3,:) t3.x(3,:)]);
ld = min([xd(3,:) t1.x(3,:) t2.x(3,:) t3.x(3,:)]);
ylim([ld-0.01 lu+0.01])
title('C) System response for z-axis')

ha = get(gcf,'children');

set(ha(1),'position',[0.0+0.1 0.0+0.11 0.87 0.17]);
set(ha(2),'position',[0.0+0.1 0.33+0.11 0.87 0.17]);
set(ha(3),'position',[0.0+0.1 0.66+0.11 0.87 0.17]);
legend(ha(3),{'Reference','Output - Test 1','Output - Test 2','Output - Test 3'},'Location','northeast')

print(f,'Images/Figure15.png','-dpng','-r300');


%%
f = figure;

subplot(4,1,1)
hold on 
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',2)
plot3(t1.x(1,:),t1.x(2,:),t1.x(3,:),'--','LineWidth',2)
plot3(t2.x(1,:),t2.x(2,:),t2.x(3,:),'-.','LineWidth',2)
plot3(t3.x(1,:),t3.x(2,:),t3.x(3,:),':','LineWidth',2)

xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([xd(1,:) t1.x(1,:) t2.x(1,:) t3.x(1,:)])) max(max([xd(1,:) t1.x(1,:) t2.x(1,:) t3.x(1,:)]))])
ylim([min(min([xd(2,:) t1.x(2,:) t2.x(2,:) t3.x(2,:)])) max(max([xd(2,:) t1.x(2,:) t2.x(2,:) t3.x(2,:)]))])
zlim([min(min([xd(3,:) t1.x(3,:) t2.x(3,:) t3.x(3,:)])) max(max([xd(3,:) t1.x(3,:) t2.x(3,:) t3.x(3,:)]))])
title('A) Trajectory following')
view([-80 30])



subplot(4,1,2)
hold on 
grid on
plot(t,t1.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,t1.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,t1.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,t1.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,t1.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,t1.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,t1.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,t1.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
title('B) Joint velocities for Test 1')

lu = max(max(t1.qp));
ld = min(min(t1.qp));
ylim([ld-0.05 lu+0.05])


subplot(4,1,3)
hold on 
grid on
plot(t,t2.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,t2.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,t2.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,t2.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,t2.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,t2.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,t2.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,t2.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
title('C) Joint velocities for Test 2')

lu = max(max(t1.qp));
ld = min(min(t1.qp));
ylim([ld-0.05 lu+0.05])


subplot(4,1,4)
hold on 
grid on
plot(t,t3.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,t3.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,t3.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,t3.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,t3.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,t3.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,t3.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,t3.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
title('D) Joint velocities for Test 3')

lu = max(max(t1.qp));
ld = min(min(t1.qp));
ylim([ld-0.05 lu+0.05])


ax = gcf;
set (gcf, 'Position', [ax.Position(1)*0.1 ax.Position(2)*0.1 ax.Position(3) ax.Position(4)*2])

ha = get(gcf,'children');


set(ha(1),'position',[0.00+0.1 0.00+0.055 0.87 0.17]);
set(ha(2),'position',[0.00+0.1 0.25+0.055 0.87 0.17]);
set(ha(3),'position',[0.00+0.1 0.50+0.055 0.87 0.17]);
set(ha(4),'position',[0.00+0.12 0.75+0.055 0.80 0.17]);

legend(ha(4),{'Reference','Output - Test 1','Output - Test 2','Output - Test 3'},'Location','northwest')
legend(ha(3),{'$\dot{x}_b$','$\dot{y}_b$','$\dot{\theta}_b$','$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$','$\dot{\theta}_4$','$\dot{\theta}_5$'},'Interpreter','latex','Location','southeast')

print(f,'Images/Figure16.png','-dpng','-r300');

%%
format shortE
format compact

rms_table = zeros(3,3);
mad_table = zeros(3,3);

rms_table(:,1) = rms((xd-t1.x)')';
mad_table(:,1) = mad((xd-t1.x)')';

rms_table(:,2) = rms((xd-t2.x)')';
mad_table(:,2) = mad((xd-t2.x)')';

rms_table(:,3) = rms((xd-t3.x)')';
mad_table(:,3) = mad((xd-t3.x)')';

[~,n_rms] = min(rms_table');
RMS = [n_rms' rms_table]'

[~,n_mad] = min(mad_table');
MAD = [n_mad' mad_table]'

format

