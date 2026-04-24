% -------------------------------------------------------------------------
% setup
% -------------------------------------------------------------------------
setup
load ESM_mat


% -------------------------------------------------------------------------
% plot results
% -------------------------------------------------------------------------
close all

% controller attitude errors
figure
h = plot(t,alpha_error*r2d,t,beta_error*r2d);
set(h(1),'LineWidth', 2)
set(h(2),'LineWidth', 2)
hold on, grid on, zoom on
plot([t(1) t(end)], +r2d*attitude_deadband_x*[1 1],'b--', [t(1) t(end)], -r2d*attitude_deadband_x*[1 1],'b--' )
plot([t(1) t(end)], +r2d*attitude_deadband_y*[1 1],'g--', [t(1) t(end)], -r2d*attitude_deadband_y*[1 1],'g--' )
plot(t,(alpha_dem-alpha_true)*r2d,'--',t,(beta_dem-beta_true)*r2d,'--')
xlabel('time [sec]')
ylabel('attitude errors [deg]')
title('Attitude Controller Errors for [X Y] Axes')
legend('\alpha','\beta')

% controller rate errors - X & Y
figure
plot(t,w_bi(1:2,:)*r2d), grid on, zoom on
xlabel('time [sec]')
ylabel('w_{bi} [deg/sec]')
title('Controller Rate Errors for [X Y] Axes')
legend('X','Y')

% controller rate errors
figure
plot(t,wz_error*r2d), hold on, grid on, zoom on
plot([t(1) t(end)], +r2d*rate_deadband_z*[1 1],'b--', [t(1) t(end)], -r2d*rate_deadband_z*[1 1],'b--' )
xlabel('time [sec]')
ylabel('rate error [deg/sec]')
title('Rate Controller Error for [Z] axis')

% torque demand and true RCS torque
figure
plot(t,T_dem), hold on, grid on, zoom on
plot(t,T_rcs)
plot([t(1) t(end)],+Tdb(1)*[1 1],'--',[t(1) t(end)],+Tdb(2)*[1 1],'--',[t(1) t(end)],+Tdb(3)*[1 1],'--')
plot([t(1) t(end)],-Tdb(1)*[1 1],'--',[t(1) t(end)],-Tdb(2)*[1 1],'--',[t(1) t(end)],-Tdb(3)*[1 1],'--')
xlabel('time [sec]')
ylabel('RCS torque demand & truth [Nm]')
title('Controller Torque demand and Actual RCS Torque')
legend('X','Y','Z')

% true inertial body rate in body frame
figure
plot(t,w_bi*r2d), grid on, zoom on
xlabel('time [sec]')
ylabel('w_{bi} [deg/sec]')
title('Inertial Body Rate in Body Frame')
legend('X','Y','Z')

% true sun angle
figure
plot(t,sun_angle*r2d), grid on, zoom on
xlabel('time [sec]')
ylabel('sun\_angle [deg]')
title('Angle between Sun Vector and Solar Array Normal')

% spacecraft inertial rate in spacecraft body frame
fig_name = 'Sun Vector Locus in Body Frame';
CreateBasicAxes(1,{'X' 'Y' 'Z'});
plot3(s_b(1,:),s_b(2,:),s_b(3,:),'r')
plot3(s_b(1,end),s_b(2,end),s_b(3,end),'r+')
Vis3DSpacecraft(0.2);
fig_num  = gcf;
set(fig_num,'numbertitle','off');
set(fig_num,'name',[num2str(fig_num.Number),'. ',fig_name]);

