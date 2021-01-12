clear all
close all
clc

Txy = @(d) [1 0 0 d; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Tyt = @(d) [1 0 0 0; 0 1 0 d; 0 0 1 0; 0 0 0 1];
Tt0 = @(theta) [cos(theta), -sin(theta) 0, 0.140; sin(theta), cos(theta), 0, 0; ...
                0, 0, 1.0, 0.151; 0, 0, 0, 1.0];
T01 = @(theta) [cos(theta), 0, sin(theta), 0.033*cos(theta); sin(theta), 0, -cos(theta), 0.033*sin(theta); ...
                0, 1.0, 0, 0.147; 0, 0, 0, 1.0];
T12 = @(theta) [cos(theta), -sin(theta), 0, 0.155*cos(theta); sin(theta), cos(theta), 0, 0.155*sin(theta); ...
	            0, 0, 1.0, 0; 0, 0, 0, 1.0];
T23 = @(theta) [cos(theta), -sin(theta), 0, 0.135*cos(theta); sin(theta), cos(theta), 0, 0.135*sin(theta); ...
                0, 0, 1.0, 0; 0, 0, 0, 1.0];
T34 = @(theta) [cos(theta), 0, sin(theta), 0; sin(theta), 0, -cos(theta), 0; ...
                0, 1.0, 0, 0; 0, 0, 0, 1.0];
T45 = @(theta) [cos(theta), -sin(theta), 0, 0; sin(theta), cos(theta), 0, 0; ...
                0, 0, 1.0, 0.2174; 0, 0, 0, 1.0];
      
q = [0.0 0.0 0.0 0 pi/2 -pi/4 pi/4 0]';

S = 60;
t = 0.001;
N = S/t;
trac = 4; % 3, 4

x_plot = zeros(3,N);
xd_plot = zeros(3,N);
q_plot = zeros(8,N);
qp_plot = zeros(8,N);
e_plot = zeros(1,N);
t_plot = zeros(1,N);

k0 = 0.2;
d = 0.001;

w_x = [1 0 0]';
w_y = [1 0 0]';
w_z = [1 0 0]';

K = 2.5;

eta_x = [0.00001 0.00001 0.00001]';
eta_y = [0.00001 0.00001 0.00001]';
eta_z = [0.00001 0.00001 0.00001]';

u = [0 0 0]';
e = zeros(3,N+2);

for i=1:N
    disp(['t = (' num2str(round(i*t)) '/' num2str(S) ')'])
    
    Tx = Txy(q(1));
    Ty = Tx*Tyt(q(2));
    Tt = Ty*Tt0(q(3));
    T1 = Tt*T01(q(4));
    T2 = T1*T12(q(5));
    T3 = T2*T23(q(6));
    T4 = T3*T34(q(7));
    T5 = T4*T45(q(8));
 
    xd = Trajectory(i*t,trac);
    xi = T5(1:3,4);
    
    e(:,i+2) = xd - xi;

    x1 = e(1,i+2) - e(1,i+1);
    x2 = e(1,i+2);
    x3 = e(1,i+2) - 2*e(1,i+1) + e(1,i);
    x_x = [x1 x2 x3]';
    
    x1 = e(2,i+2) - e(2,i+1);
    x2 = e(2,i+2);
    x3 = e(2,i+2) - 2*e(2,i+1) + e(2,i);
    x_y = [x1 x2 x3]';
    
    x1 = e(3,i+2) - e(3,i+1);
    x2 = e(3,i+2);
    x3 = e(3,i+2) - 2*e(3,i+1) + e(3,i);
    x_z = [x1 x2 x3]';
    
    du_x = K*(w_x'*x_x);
    du_y = K*(w_y'*x_y);
    du_z = K*(w_z'*x_z);
    
    u = u + [du_x du_y du_z]';
    
    w_x = w_x + e(1,i+2)*(eta_x.*x_x);
    w_y = w_y + e(2,i+2)*(eta_y.*x_y);
    w_z = w_z + e(3,i+2)*(eta_z.*x_z);
    
    w_x = w_x/norm(w_x);
    w_y = w_y/norm(w_y);
    w_z = w_z/norm(w_z);
    
    J = Jacob(q);
    Ji = pinv(J);
    
    q0 = zeros(8,1);
    q0(5) = (sqrt(det(Jacob(q+[0;0;0;0;0.5*d;0;0;0])*Jacob(q+[0;0;0;0;0.5*d;0;0;0])'))-(sqrt(det(Jacob(q-[0;0;0;0;0.5*d;0;0;0])*Jacob(q-[0;0;0;0;0.5*d;0;0;0])'))))/d;
    q0(6) = (sqrt(det(Jacob(q+[0;0;0;0;0;0.5*d;0;0])*Jacob(q+[0;0;0;0;0;0.5*d;0;0])'))-(sqrt(det(Jacob(q-[0;0;0;0;0;0.5*d;0;0])*Jacob(q-[0;0;0;0;0;0.5*d;0;0])'))))/d;
    q0(7) = (sqrt(det(Jacob(q+[0;0;0;0;0;0;0.5*d;0])*Jacob(q+[0;0;0;0;0;0;0.5*d;0])'))-(sqrt(det(Jacob(q-[0;0;0;0;0;0;0.5*d;0])*Jacob(q-[0;0;0;0;0;0;0.5*d;0])'))))/d;
    
    qp = Ji*u + k0*(eye(8,8)-Ji*J)*q0;
    
    q = q + qp*t;
    
    x_plot(:,i) = xi;
    xd_plot(:,i) = xd;
    q_plot(:,i) = q;
    qp_plot(:,i) = qp;
    e_plot(i) = norm(e(:,i+2));
    t_plot(i) = i*t;
end

save(['_ccpid_' num2str(trac)],'x_plot','xd_plot','q_plot','qp_plot','e_plot','t_plot')

figure
hold on
grid on
plot(t_plot,x_plot(1,:),'LineWidth',2)
plot(t_plot,xd_plot(1,:),'LineWidth',2)
legend('x','xd')

figure
hold on
grid on
plot(t_plot,x_plot(2,:),'LineWidth',2)
plot(t_plot,xd_plot(2,:),'LineWidth',2)
legend('y','yd')

figure
hold on
grid on
plot(t_plot,x_plot(3,:),'LineWidth',2)
plot(t_plot,xd_plot(3,:),'LineWidth',2)
legend('z','zd')

figure
hold on
grid on
plot3(x_plot(1,:),x_plot(2,:),x_plot(3,:),'LineWidth',2)
plot3(xd_plot(1,:),xd_plot(2,:),xd_plot(3,:),'LineWidth',2)
legend('X','Xd')

% figure
% hold on
% grid on
% plot(t_plot,q_plot(1,:),'LineWidth',2)
% plot(t_plot,q_plot(2,:),'LineWidth',2)
% plot(t_plot,q_plot(3,:),'LineWidth',2)
% plot(t_plot,q_plot(4,:),'LineWidth',2)
% plot(t_plot,q_plot(5,:),'LineWidth',2)
% plot(t_plot,q_plot(6,:),'LineWidth',2)
% plot(t_plot,q_plot(7,:),'LineWidth',2)
% plot(t_plot,q_plot(8,:),'LineWidth',2)
% legend('q1','q2','q3','q4','q5','q6','q7','q8')
% 
% figure
% hold on
% grid on
% plot(t_plot,qp_plot(1,:),'LineWidth',2)
% plot(t_plot,qp_plot(2,:),'LineWidth',2)
% plot(t_plot,qp_plot(3,:),'LineWidth',2)
% plot(t_plot,qp_plot(4,:),'LineWidth',2)
% plot(t_plot,qp_plot(5,:),'LineWidth',2)
% plot(t_plot,qp_plot(6,:),'LineWidth',2)
% plot(t_plot,qp_plot(7,:),'LineWidth',2)
% plot(t_plot,qp_plot(8,:),'LineWidth',2)
% legend('qp1','qp2','qp3','qp4','qp5','qp6','qp7','qp8')

figure
hold on
grid on
plot(t_plot,e_plot,'LineWidth',2)
legend('e')
