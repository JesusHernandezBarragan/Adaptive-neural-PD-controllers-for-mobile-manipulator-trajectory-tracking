clear all
close all
clc

s = '3'; % 3, 4
[mnpd.x,xd,mnpd.q,mnpd.qp,t] = Load_Data (['_multilayer_ANN_' s]);
[pd.x,~,pd.q,pd.qp,~] = Load_Data (['_ccpid_' s]);
[pid.x,~,pid.q,pid.qp,~] = Load_Data (['_pid_' s]);
[snpd.x,~,snpd.q,snpd.qp,~] = Load_Data (['_single_ANN_' s]);

%% Tabla

format shortE
format compact

rms_table = zeros(3,4);
mad_table = zeros(3,4);

rms_table(:,1) = rms((xd-mnpd.x)')';
mad_table(:,1) = mad((xd-mnpd.x)')';
rms_table(:,2) = rms((xd-pd.x)')';
mad_table(:,2) = mad((xd-pd.x)')';
rms_table(:,3) = rms((xd-pid.x)')';
mad_table(:,3) = mad((xd-pid.x)')';
rms_table(:,4) = rms((xd-snpd.x)')';
mad_table(:,4) = mad((xd-snpd.x)')';

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
plot(t,mnpd.x(1,:),'--','LineWidth',1.5)
plot(t,pd.x(1,:),'-.','LineWidth',1.5)
plot(t,pid.x(1,:),':','LineWidth',1.5)
plot(t,snpd.x(1,:),'--','LineWidth',1.5)
xlabel('time (s)')
ylabel('x-axis (m)')
xlim([0 20])
ylim([min(min([mnpd.x(1,:); pd.x(1,:); pid.x(1,:); snpd.x(1,:)])) max(max([mnpd.x(1,:); pd.x(1,:); pid.x(1,:); snpd.x(1,:)]))])
title('A) System response for x-axis')

subplot(3,1,2)
hold on
grid on
plot(t,xd(2,:),'-','LineWidth',1)
plot(t,mnpd.x(2,:),'--','LineWidth',1.5)
plot(t,pd.x(2,:),'-.','LineWidth',1.5)
plot(t,pid.x(2,:),':','LineWidth',1.5)
plot(t,snpd.x(2,:),'--','LineWidth',1.5)
xlabel('time (s)')
ylabel('y-axis (m)')
xlim([0 20])
ylim([min(min([mnpd.x(2,:); pd.x(2,:); pid.x(2,:); snpd.x(2,:)])) max(max([mnpd.x(2,:); pd.x(2,:); pid.x(2,:); snpd.x(2,:)]))])
title('B) System response for y-axis')

subplot(3,1,3)
hold on
grid on
plot(t,xd(3,:),'-','LineWidth',1.5)
plot(t,mnpd.x(3,:),'--','LineWidth',1.5)
plot(t,pd.x(3,:),'-.','LineWidth',1.5)
plot(t,pid.x(3,:),':','LineWidth',1.5)
plot(t,snpd.x(3,:),'--','LineWidth',1.5)
xlabel('time (s)')
ylabel('z-axis (m)')
xlim([0 20])
ylim([min(min([mnpd.x(3,:); pd.x(3,:); pid.x(3,:); snpd.x(3,:)])) max(max([mnpd.x(3,:); pd.x(3,:); pid.x(3,:); snpd.x(3,:)]))])
title('C) System response for z-axis')


ha = get(gcf,'children');

set(ha(1),'position',[0.0+0.11 0.0+0.11 0.86 0.17]);
set(ha(2),'position',[0.0+0.11 0.33+0.11 0.86 0.17]);
set(ha(3),'position',[0.0+0.11 0.66+0.11 0.86 0.17]);
legend(ha(3),{'Reference','MNPD','SNA-PID','PID','SNPD'},'Location','southeast')

print(f,'Images/Figure7.png','-dpng','-r300');

%% Trajectory
f = figure;

subplot(4,2,1)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(mnpd.x(1,:),mnpd.x(2,:),mnpd.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([mnpd.x(1,:) xd(1,:)])) max(max([mnpd.x(1,:) xd(1,:)]))])
ylim([min(min([mnpd.x(2,:) xd(2,:)])) max(max([mnpd.x(2,:) xd(2,:)]))])
zlim([min(min([mnpd.x(3,:) xd(3,:)])) max(max([mnpd.x(3,:) xd(3,:)]))])
title('A) Trajectory following for MNPD')
view([-60 30])

subplot(4,2,2)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(pd.x(1,:),pd.x(2,:),pd.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([pd.x(1,:) xd(1,:)])) max(max([pd.x(1,:) xd(1,:)]))])
ylim([min(min([pd.x(2,:) xd(2,:)])) max(max([pd.x(2,:) xd(2,:)]))])
zlim([min(min([pd.x(3,:) xd(3,:)])) max(max([pd.x(3,:) xd(3,:)]))])
title('B) Trajectory following for SNA-PID')
view([-60 30])

subplot(4,2,3)
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
title('C) Trajectory following for PID')
view([-60 30])

subplot(4,2,4)
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
title('D) Trajectory following for SNPD')
view([-60 30])


%% vector qp
subplot(4,2,5)
hold on
grid on
plot(t,mnpd.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,mnpd.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,mnpd.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,mnpd.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,mnpd.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,mnpd.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,mnpd.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,mnpd.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(mnpd.qp)) max(max(mnpd.qp))])
title('E) Joint velocities for MNPD')

subplot(4,2,6)
hold on
grid on
plot(t,pd.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,pd.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,pd.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,pd.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,pd.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,pd.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,pd.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,pd.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(pd.qp)) max(max(pd.qp))])
title('F) Joint velocities for SNA-PID')

subplot(4,2,7)
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
ylim([min(min(pid.qp)) max(max(pid.qp))])
xlim([0 20])
title('G) Joint velocities for PID')

subplot(4,2,8)
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
ylim([min(min(snpd.qp)) max(max(snpd.qp))])
xlim([0 20])
title('H) Joint velocities for SNPD')


ax = gcf;
set (gcf, 'Position', [ax.Position(1)*0.1 ax.Position(2)*0.1 ax.Position(3) ax.Position(4)*2])

ha = get(gcf,'children');
    

set(ha(2),'position',[0.00+0.1 0.00+0.055 0.37 0.17]);
set(ha(1),'position',[0.50+0.1 0.00+0.055 0.37 0.17]);

set(ha(4),'position',[0.00+0.1 0.25+0.055 0.37 0.17]);
set(ha(3),'position',[0.50+0.1 0.25+0.055 0.37 0.17]);

set(ha(6),'position',[0.00+0.1 0.50+0.055 0.33 0.17]);
set(ha(5),'position',[0.50+0.1 0.50+0.055 0.33 0.17]);

set(ha(8),'position',[0.00+0.1 0.75+0.055 0.33 0.17]);
set(ha(7),'position',[0.50+0.1 0.75+0.055 0.33 0.17]);

legend(ha(3),{'$\dot{x}_b$','$\dot{y}_b$','$\dot{\theta}_b$','$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$','$\dot{\theta}_4$','$\dot{\theta}_5$'},'Interpreter','latex','Location','southeast')
legend(ha(7),{'Reference','Output'},'Location','best')

print(f,'Images/Figure8.png','-dpng','-r300');







%%
s = '4'; % 3, 4
[mnpd.x,xd,mnpd.q,mnpd.qp,t] = Load_Data (['_multilayer_ANN_' s]);
[pd.x,~,pd.q,pd.qp,~] = Load_Data (['_ccpid_' s]);
[pid.x,~,pid.q,pid.qp,~] = Load_Data (['_pid_' s]);
[snpd.x,~,snpd.q,snpd.qp,~] = Load_Data (['_single_ANN_' s]);

%% Tabla

format shortE
format compact

rms_table = zeros(3,4);
mad_table = zeros(3,4);

rms_table(:,1) = rms((xd-mnpd.x)')';
mad_table(:,1) = mad((xd-mnpd.x)')';
rms_table(:,2) = rms((xd-pd.x)')';
mad_table(:,2) = mad((xd-pd.x)')';
rms_table(:,3) = rms((xd-pid.x)')';
mad_table(:,3) = mad((xd-pid.x)')';
rms_table(:,4) = rms((xd-snpd.x)')';
mad_table(:,4) = mad((xd-snpd.x)')';

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
plot(t,mnpd.x(1,:),'--','LineWidth',1.5)
plot(t,pd.x(1,:),'-.','LineWidth',1.5)
plot(t,pid.x(1,:),':','LineWidth',1.5)
plot(t,snpd.x(1,:),'--','LineWidth',1.5)
xlabel('time (s)')
ylabel('x-axis (m)')
xlim([0 20])
ylim([min(min([mnpd.x(1,:); pd.x(1,:); pid.x(1,:); snpd.x(1,:)])) max(max([mnpd.x(1,:); pd.x(1,:); pid.x(1,:); snpd.x(1,:)]))])
title('A) System response for x-axis')

subplot(3,1,2)
hold on
grid on
plot(t,xd(2,:),'-','LineWidth',1)
plot(t,mnpd.x(2,:),'--','LineWidth',1.5)
plot(t,pd.x(2,:),'-.','LineWidth',1.5)
plot(t,pid.x(2,:),':','LineWidth',1.5)
plot(t,snpd.x(2,:),'--','LineWidth',1.5)
xlabel('time (s)')
ylabel('y-axis (m)')
xlim([0 20])
ylim([min(min([mnpd.x(2,:); pd.x(2,:); pid.x(2,:); snpd.x(2,:)])) max(max([mnpd.x(2,:); pd.x(2,:); pid.x(2,:); snpd.x(2,:)]))])
title('B) System response for y-axis')

subplot(3,1,3)
hold on
grid on
plot(t,xd(3,:),'-','LineWidth',1.5)
plot(t,mnpd.x(3,:),'--','LineWidth',1.5)
plot(t,pd.x(3,:),'-.','LineWidth',1.5)
plot(t,pid.x(3,:),':','LineWidth',1.5)
plot(t,snpd.x(3,:),'--','LineWidth',1.5)
xlabel('time (s)')
ylabel('z-axis (m)')
xlim([0 20])
ylim([min(min([mnpd.x(3,:); pd.x(3,:); pid.x(3,:); snpd.x(3,:)])) max(max([mnpd.x(3,:); pd.x(3,:); pid.x(3,:); snpd.x(3,:)]))])
title('C) System response for z-axis')


ha = get(gcf,'children');

set(ha(1),'position',[0.0+0.11 0.0+0.11 0.86 0.17]);
set(ha(2),'position',[0.0+0.11 0.33+0.11 0.86 0.17]);
set(ha(3),'position',[0.0+0.11 0.66+0.11 0.86 0.17]);
legend(ha(3),{'Reference','MNPD','SNA-PID','PID','SNPD'},'Location','southeast')

print(f,'Images/Figure9.png','-dpng','-r300');

%% Trajectory
f = figure;

subplot(4,2,1)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(mnpd.x(1,:),mnpd.x(2,:),mnpd.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([mnpd.x(1,:) xd(1,:)])) max(max([mnpd.x(1,:) xd(1,:)]))])
ylim([min(min([mnpd.x(2,:) xd(2,:)])) max(max([mnpd.x(2,:) xd(2,:)]))])
zlim([min(min([mnpd.x(3,:) xd(3,:)])) max(max([mnpd.x(3,:) xd(3,:)]))])
title('A) Trajectory following for MNPD')
view([-60 30])

subplot(4,2,2)
hold on
grid on
plot3(xd(1,:),xd(2,:),xd(3,:),'-','LineWidth',1.5)
plot3(pd.x(1,:),pd.x(2,:),pd.x(3,:),'--','LineWidth',1.5)
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
xlim([min(min([pd.x(1,:) xd(1,:)])) max(max([pd.x(1,:) xd(1,:)]))])
ylim([min(min([pd.x(2,:) xd(2,:)])) max(max([pd.x(2,:) xd(2,:)]))])
zlim([min(min([pd.x(3,:) xd(3,:)])) max(max([pd.x(3,:) xd(3,:)]))])
title('B) Trajectory following for SNA-PID')
view([-60 30])

subplot(4,2,3)
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
title('C) Trajectory following for PID')
view([-60 30])

subplot(4,2,4)
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
title('D) Trajectory following for SNPD')
view([-60 30])


%% vector qp
subplot(4,2,5)
hold on
grid on
plot(t,mnpd.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,mnpd.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,mnpd.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,mnpd.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,mnpd.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,mnpd.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,mnpd.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,mnpd.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(mnpd.qp)) max(max(mnpd.qp))])
title('E) Joint velocities for MNPD')

subplot(4,2,6)
hold on
grid on
plot(t,pd.qp(1,:),'LineWidth',1.5,'Color',[0 0.4470 0.7410])
plot(t,pd.qp(2,:),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t,pd.qp(3,:),'LineWidth',1.5,'Color',[0.9290 0.6940 0.1250])
plot(t,pd.qp(4,:),'LineWidth',1.5,'Color',[0.4940 0.1840 0.5560])
plot(t,pd.qp(5,:),'LineWidth',1.5,'Color',[0.4660 0.6740 0.1880])
plot(t,pd.qp(6,:),'LineWidth',1.5,'Color',[0.3010 0.7450 0.9330])
plot(t,pd.qp(7,:),'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840])
plot(t,pd.qp(8,:),'LineWidth',1.5,'Color',[0 0 1])
xlabel('time (s)')
ylabel('joint value (m/s, rad/s)')
xlim([0 20])
ylim([min(min(pd.qp)) max(max(pd.qp))])
title('F) Joint velocities for SNA-PID')

subplot(4,2,7)
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
ylim([min(min(pid.qp)) max(max(pid.qp))])
xlim([0 20])
title('G) Joint velocities for PID')

subplot(4,2,8)
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
ylim([min(min(snpd.qp)) max(max(snpd.qp))])
xlim([0 20])
title('H) Joint velocities for SNPD')


ax = gcf;
set (gcf, 'Position', [ax.Position(1)*0.1 ax.Position(2)*0.1 ax.Position(3) ax.Position(4)*2])

ha = get(gcf,'children');
    

set(ha(2),'position',[0.00+0.1 0.00+0.055 0.37 0.17]);
set(ha(1),'position',[0.50+0.1 0.00+0.055 0.37 0.17]);

set(ha(4),'position',[0.00+0.1 0.25+0.055 0.37 0.17]);
set(ha(3),'position',[0.50+0.1 0.25+0.055 0.37 0.17]);

set(ha(6),'position',[0.00+0.1 0.50+0.055 0.33 0.17]);
set(ha(5),'position',[0.50+0.1 0.50+0.055 0.33 0.17]);

set(ha(8),'position',[0.00+0.1 0.75+0.055 0.33 0.17]);
set(ha(7),'position',[0.50+0.1 0.75+0.055 0.33 0.17]);

legend(ha(3),{'$\dot{x}_b$','$\dot{y}_b$','$\dot{\theta}_b$','$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$','$\dot{\theta}_4$','$\dot{\theta}_5$'},'Interpreter','latex','Location','southeast')
legend(ha(7),{'Reference','Output'},'Location','best')

print(f,'Images/Figure10.png','-dpng','-r300');



%%
function [x,xd,q,qp,t] = Load_Data (s)
    load(s)

    x = x_plot;
    xd = xd_plot;
    q = q_plot;
    qp = qp_plot;
    t = t_plot;
end
