clear all
close all
clc

s = '4'; % 4, 5

[pid.x,pid.xd,pid.q,pid.qp,pid.t] = Load_Data (['pid/Prueba_' s]);
[snpd.x,snpd.xd,snpd.q,snpd.qp,snpd.t] = Load_Data (['npd/Prueba_' s]);

n = min([numel(pid.t) numel(snpd.t)]);
t = snpd.t(1:n); xd = snpd.xd(:,1:n);
snpd.x = snpd.x(:,1:n); snpd.q = snpd.q(:,1:n); snpd.qp = snpd.qp(:,1:n);
pid.x = pid.x(:,1:n); pid.q = pid.q(:,1:n); pid.qp = pid.qp(:,1:n);


%% Tabla
format shortE
format compact

rms_table = zeros(3,2);
mad_table = zeros(3,2);

rms_table(:,1) = rms((xd-snpd.x)')';
mad_table(:,1) = mad((xd-snpd.x)')';
rms_table(:,2) = rms((xd-pid.x)')';
mad_table(:,2) = mad((xd-pid.x)')';

[~,n_rms] = min(rms_table');
RMS = [n_rms' rms_table]'

[~,n_mad] = min(mad_table');
MAD = [n_mad' mad_table]'

format

%% Tracking Results
f = figure;

subplot(3,1,1)
hold on
grid on
plot(t,xd(1,:),'-','LineWidth',1.5)
plot(t,snpd.x(1,:),'--','LineWidth',1.5)
plot(t,pid.x(1,:),'-.','LineWidth',1.5)
xlabel('time (s)')
ylabel('x-axis (m)')
xlim([0 20])
ylim([min(min([pid.x(1,:); snpd.x(1,:)])) max(max([pid.x(1,:); snpd.x(1,:)]))])
title('A) System response for x-axis')

subplot(3,1,2)
hold on
grid on
plot(t,xd(2,:),'-','LineWidth',1)
plot(t,snpd.x(2,:),'--','LineWidth',1.5)
plot(t,pid.x(2,:),'-.','LineWidth',1.5)
xlabel('time (s)')
ylabel('y-axis (m)')
xlim([0 20])
ylim([min(min([pid.x(2,:); snpd.x(2,:)])) max(max([pid.x(2,:); snpd.x(2,:)]))])
title('B) System response for y-axis')

subplot(3,1,3)
hold on
grid on
plot(t,xd(3,:),'-','LineWidth',1.5)
plot(t,snpd.x(3,:),'--','LineWidth',1.5)
plot(t,pid.x(3,:),'-.','LineWidth',1.5)
xlabel('time (s)')
ylabel('z-axis (m)')
xlim([0 20])
ylim([min(min([pid.x(3,:); snpd.x(3,:)])) max(max([pid.x(3,:); snpd.x(3,:)]))])
title('C) System response for z-axis')


ha = get(gcf,'children');

set(ha(1),'position',[0.0+0.11 0.0+0.11 0.86 0.17]);
set(ha(2),'position',[0.0+0.11 0.33+0.11 0.86 0.17]);
set(ha(3),'position',[0.0+0.11 0.66+0.11 0.86 0.17]);
legend(ha(3),{'Reference','SNPD','PID'},'Location','southeast')

print(f,'Images/Figure11.png','-dpng','-r300');


%% Trajectory
f = figure;

subplot(2,2,1)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(snpd.x(1,:),snpd.x(2,:),snpd.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([snpd.x(1,:) xd(1,:)])) max(max([snpd.x(1,:) xd(1,:)]))])
ylim([min(min([snpd.x(2,:) xd(2,:)])) max(max([snpd.x(2,:) xd(2,:)]))])
zlim([min(min([snpd.x(3,:) xd(3,:)])) max(max([snpd.x(3,:) xd(3,:)]))])
title('A) Trajectory following for SNPD')
view([-70 17])

subplot(2,2,2)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(pid.x(1,:),pid.x(2,:),pid.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([pid.x(1,:) xd(1,:)])) max(max([pid.x(1,:) xd(1,:)]))])
ylim([min(min([pid.x(2,:) xd(2,:)])) max(max([pid.x(2,:) xd(2,:)]))])
zlim([min(min([pid.x(3,:) xd(3,:)])) max(max([pid.x(3,:) xd(3,:)]))])
title('B) Trajectory following for PID')
view([-70 17])


%% vector qp
subplot(2,2,3)
hold on
grid on
plot(t,snpd.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,snpd.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,snpd.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,snpd.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,snpd.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,snpd.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,snpd.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,snpd.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(snpd.qp)) max(max(snpd.qp))])
title('C) Joint velocities for SNPD')

subplot(2,2,4)
hold on
grid on
plot(t,pid.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,pid.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,pid.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,pid.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,pid.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,pid.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,pid.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,pid.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(pid.qp)) max(max(pid.qp))])
title('D) Joint velocities for PID')


ha = get(gcf,'children');

set(ha(2),'position',[0.00+0.1 0.00+0.11 0.37 0.34]);
set(ha(1),'position',[0.50+0.1 0.00+0.11 0.37 0.34]);

set(ha(4),'position',[0.00+0.11 0.50+0.11 0.31 0.34]);
set(ha(3),'position',[0.50+0.11 0.50+0.11 0.31 0.34]);

legend(ha(3),{'Reference','Output'},'Location','best')
legend(ha(1),{'$\dot{x}_b$','$\dot{y}_b$','$\dot{\theta}_b$','$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$','$\dot{\theta}_4$','$\dot{\theta}_5$'},'Interpreter','latex','Location','southeast')

print(f,'Images/Figure12.png','-dpng','-r300');






%%
s = '5'; % 4, 5

[pid.x,pid.xd,pid.q,pid.qp,pid.t] = Load_Data (['pid/Prueba_' s]);
[snpd.x,snpd.xd,snpd.q,snpd.qp,snpd.t] = Load_Data (['npd/Prueba_' s]);

n = min([numel(pid.t) numel(snpd.t)]);
t = snpd.t(1:n); xd = snpd.xd(:,1:n);
snpd.x = snpd.x(:,1:n); snpd.q = snpd.q(:,1:n); snpd.qp = snpd.qp(:,1:n);
pid.x = pid.x(:,1:n); pid.q = pid.q(:,1:n); pid.qp = pid.qp(:,1:n);


%% Tabla
format shortE
format compact

rms_table = zeros(3,2);
mad_table = zeros(3,2);

rms_table(:,1) = rms((xd-snpd.x)')';
mad_table(:,1) = mad((xd-snpd.x)')';
rms_table(:,2) = rms((xd-pid.x)')';
mad_table(:,2) = mad((xd-pid.x)')';

[~,n_rms] = min(rms_table');
RMS = [n_rms' rms_table]'

[~,n_mad] = min(mad_table');
MAD = [n_mad' mad_table]'

format

%% Tracking Results
f = figure;

subplot(3,1,1)
hold on
grid on
plot(t,xd(1,:),'-','LineWidth',1.5)
plot(t,snpd.x(1,:),'--','LineWidth',1.5)
plot(t,pid.x(1,:),'-.','LineWidth',1.5)
xlabel('time (s)')
ylabel('x-axis (m)')
xlim([0 20])
ylim([min(min([pid.x(1,:); snpd.x(1,:)])) max(max([pid.x(1,:); snpd.x(1,:)]))])
title('A) System response for x-axis')

subplot(3,1,2)
hold on
grid on
plot(t,xd(2,:),'-','LineWidth',1)
plot(t,snpd.x(2,:),'--','LineWidth',1.5)
plot(t,pid.x(2,:),'-.','LineWidth',1.5)
xlabel('time (s)')
ylabel('y-axis (m)')
xlim([0 20])
ylim([min(min([pid.x(2,:); snpd.x(2,:)])) max(max([pid.x(2,:); snpd.x(2,:)]))])
title('B) System response for y-axis')

subplot(3,1,3)
hold on
grid on
plot(t,xd(3,:),'-','LineWidth',1.5)
plot(t,snpd.x(3,:),'--','LineWidth',1.5)
plot(t,pid.x(3,:),'-.','LineWidth',1.5)
xlabel('time (s)')
ylabel('z-axis (m)')
xlim([0 20])
ylim([min(min([pid.x(3,:); snpd.x(3,:)])) max(max([pid.x(3,:); snpd.x(3,:)]))])
title('C) System response for z-axis')


ha = get(gcf,'children');

set(ha(1),'position',[0.0+0.11 0.0+0.11 0.86 0.17]);
set(ha(2),'position',[0.0+0.11 0.33+0.11 0.86 0.17]);
set(ha(3),'position',[0.0+0.11 0.66+0.11 0.86 0.17]);
legend(ha(3),{'Reference','SNPD','PID'},'Location','southeast')

print(f,'Images/Figure13.png','-dpng','-r300');


%% Trajectory
f = figure;

subplot(2,2,1)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(snpd.x(1,:),snpd.x(2,:),snpd.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([snpd.x(1,:) xd(1,:)])) max(max([snpd.x(1,:) xd(1,:)]))])
ylim([min(min([snpd.x(2,:) xd(2,:)])) max(max([snpd.x(2,:) xd(2,:)]))])
zlim([min(min([snpd.x(3,:) xd(3,:)])) max(max([snpd.x(3,:) xd(3,:)]))])
title('A) Trajectory following for SNPD')
view([-70 17])

subplot(2,2,2)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(pid.x(1,:),pid.x(2,:),pid.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([pid.x(1,:) xd(1,:)])) max(max([pid.x(1,:) xd(1,:)]))])
ylim([min(min([pid.x(2,:) xd(2,:)])) max(max([pid.x(2,:) xd(2,:)]))])
zlim([min(min([pid.x(3,:) xd(3,:)])) max(max([pid.x(3,:) xd(3,:)]))])
title('B) Trajectory following for PID')
view([-70 17])


%% vector qp
subplot(2,2,3)
hold on
grid on
plot(t,snpd.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,snpd.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,snpd.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,snpd.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,snpd.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,snpd.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,snpd.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,snpd.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(snpd.qp)) max(max(snpd.qp))])
title('C) Joint velocities for SNPD')

subplot(2,2,4)
hold on
grid on
plot(t,pid.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,pid.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,pid.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,pid.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,pid.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,pid.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,pid.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,pid.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(pid.qp)) max(max(pid.qp))])
title('D) Joint velocities for PID')


ha = get(gcf,'children');

set(ha(2),'position',[0.00+0.1 0.00+0.11 0.37 0.34]);
set(ha(1),'position',[0.50+0.1 0.00+0.11 0.37 0.34]);

set(ha(4),'position',[0.00+0.11 0.50+0.11 0.31 0.34]);
set(ha(3),'position',[0.50+0.11 0.50+0.11 0.31 0.34]);

legend(ha(3),{'Reference','Output'},'Location','northeast')
legend(ha(1),{'$\dot{x}_b$','$\dot{y}_b$','$\dot{\theta}_b$','$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$','$\dot{\theta}_4$','$\dot{\theta}_5$'},'Interpreter','latex','Location','southeast')

print(f,'Images/Figure14.png','-dpng','-r300');








%%
function [x,xd,q,qp,t] = Load_Data (s)
    load([s '/e.dat'])
    load([s '/x.dat'])
    load([s '/xd.dat'])
    load([s '/q.dat'])
    load([s '/qp.dat'])
    load([s '/t.dat'])
    
    I = t<=60;
    
    t = t(I);
    xd = xd(:,I);
    x = x(:,I);
    q = q(:,I);
    qp = qp(:,I);
end