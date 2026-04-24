% ESM simulation
% This script simulates the Emergency Sun Mode described in the P6 notes.
% This mode comprises 2-axis attitude control and 1-axis rate control


% preliminaries
clear variables
close all
r2d     = 180/pi;
setup

% -------------------------------------------------------------------------
% setup initial conditions
% -------------------------------------------------------------------------
% dynamic conditions
e       = [0 1 0]';                            % [-] euler axis at start of simulation describing rotation from inertial to body frame
phi     = 45/r2d;                              % [r] euler angle at start of simulation describing rotation from inertial to body frame
q_bi0   = [e*sin(phi/2); cos(phi/2)];          % [-] initial inertial to body attitude quaternion
w_bi0   = [1 1 1]'/r2d;                        % [r/s] initial spacecraft inertial rate in body frame
I_sc    = diag([10000, 30000, 30000]);         % [kgm^2] spacecraft inertia matrix
T_env   = [0.1 0.1 0.1]';                       % [Nm] environmental disturbance torque
s_i     = [0 0 1]';                            % [-] sun vector in inertial frame (fixed)

% simulation time variables
dt_sim  = 0.1;                                  % [s] integration/simulation time step
tdur    = 500;                                  % [s] simulation duration

% controller gains
tdelay  = 0.2;                                 % [sec] transport delay 
ta      = 0.5;                                 % [sec] controller update time (i.e. interval at which controller output is updated)
Kpx     = 125;                                 % [Nm/r] proportional gain for spacecraft X-axis controller
Kdx     = 5000;                                % [Nm/(r/s)] derivative gain for spacecraft X-axis controller
Kpy     = 375;                                 % [Nm/r] proportional gain for spacecraft Y-axis controller
Kdy     = 15000;                               % [Nm/(r/s)] derivative gain for spacecraft Y-axis controller
Kdz     = 1700;                                % [Nm/(r/s)] proportional gain for spacecraft Z-axis (rate) controller

% attitude demands (effectively the demanded angular offsets from Z-axis pointing)
alpha_dem = 0;                                 % [r] input demand to X-axis controller, corresponds to Z-axis pointing at the Sun
beta_dem  = 0;                                 % [r] input demand to X-axis controller, corresponds to Z-axis pointing at the Sun

% sensor errors
w_bias                 = [0 0 -0.1]/r2d;       % [r/s] rate sensor bias (sensor output when actual rate=0)
sigma_w                = 0.0005/r2d;           % [r/s] rates sensor read-out noise standard deviation
sun_sensor_model_type  = 2;                    % [-] sun sensor model type flag (1=perfect sensor, 2=non-linear (as described in lecture notes) sensor)
rate_sensor_model_type = 2;                    % [-] rate sensor model type flag (1=perfect sensor, 2=noisy sensor with bias)


% PWM & RCS actuator parameters
Tdb                    = [2 5 2];              % [Nm] PWM torque deadbands for [X Y Z] axes respectively
Trcs_saturation        = [12 58 57];           % [Nm] maximum control torques available per axis [X Y Z] from RCS 
Krcs                   = 1;                    % [-] RCS gain

% -------------------------------------------------------------------------
% run model
% -------------------------------------------------------------------------
tic                                               % start timing execution of model
sim('ESM_mdl',tdur)                               % run simulation
fprintf('simulation duration = %0.1fs\n',toc)     % echo simulation execution time to MATLAB

% enforce vector notation - columns are time history
t           = tout';
s_b         = s_b';
q_bi        = q_bi';
w_bi        = w_bi';
alpha_error = alpha_error';
beta_error  = beta_error';
wz_error    = wz_error';

npts = length(t);

% -------------------------------------------------------------------------
% Post-processing
% -------------------------------------------------------------------------
% Calculate time history of angle between sun and Z-axis of spacecraft body
% frame (=solar array normal). Mathematically: cos(sun_angle) = dot(s_b,z_b)
% and since z_b = [0 0 1]' (Z-axis of body frame in body frame components)
% this reduces to:
sun_angle       = acos(s_b(3,:));

% compute s/c z-axis time history in inertial reference frame components
zb_eci          = zeros(3,npts);
for i=1:npts
    DCM         = q2dcm(q_bi(:,i))';
    zb_eci(:,i) = DCM * [0 0 1]';
end

% compute attitude deadbands from torque deadbands
attitude_deadband_x = Tdb(1)/Kpx;
attitude_deadband_y = Tdb(2)/Kpy;
rate_deadband_z     = Tdb(3)/Kdz;

disp(' ')
fprintf('attitude deadband X = %0.2fdeg\n', attitude_deadband_x*180/pi) 
fprintf('attitude deadband Y = %0.2fdeg\n', attitude_deadband_y*180/pi)
fprintf('rate deadband Z     = %0.4fdeg/sec\n', rate_deadband_z*180/pi)

% -------------------------------------------------------------------------
% save results MAT file
% -------------------------------------------------------------------------
save ESM_mat


% -------------------------------------------------------------------------
% plot results
% -------------------------------------------------------------------------
ESM_plot_results