%Initialize workspace
clear all;
close all;

%Degree to radian function
d2r = pi/180;
r2d = 180/pi;

%Initialize variables
q_bi0 = [0;0;0;1]; %Initial attitude quaternion
w_bi0 = [1;1;0]*d2r; %Initial rate vector

T_ext = [0;0;0]; %External torque

I_sc = diag([10000 30000 30000]); %S/C inertia matrix

tdur = 500; %Simulation duration
dt_sim = 0.1; %Integration time step, 10 Hz

%Run Simulink model
sim('SADC1.slx',tdur);

%Plot figure 1
hold on %Necessary for Tex interpreter???

plot(q_bi);
title('Quaternion time evolution')
xlabel('time (s)')
ylabel('q_{bi}')
legend('q_1','q_2','q_3','q_4','Location','northeast')

%Plot figure 2
figure
hold on %Necessary for Tex interpreter???

plot(w_bi*r2d);

title('Rate Vector time evolution')
xlabel('time (s)')
ylabel('\omega_{bi} (\circ/s)')
legend('\omega_{bix}','\omega_{biy}','\omega_{biz}','Location','northeast')

%Analytical solution

LAMBDA = (w_bi0(1)*(I_sc(1,1)-I_sc(3,3)))/I_sc(2,2);

tout1 = transpose(tout);

w_an = [w_bi0(1)+0*tout1;... 
    (w_bi0(2)*cos(LAMBDA*tout1) - w_bi0(3)*sin(LAMBDA*tout1));...
    (w_bi0(3)*cos(LAMBDA*tout1) + w_bi0(2)*sin(LAMBDA*tout1))];
w_an = w_an*r2d;
w_an = transpose(w_an);

%Plot figure 3
figure
hold on %Necessary for Tex interpreter???

plot(tout,w_an)
title('Rate Vector analytical solution')
xlabel('time (s)')
ylabel('\omega_{bi} (\circ/s)')
legend('\omega_{bix}','\omega_{biy}','\omega_{biz}','Location','northeast')

w_bidata = w_bi.Data;
err = abs(w_an - w_bidata*r2d);

%Plot figure 4
figure
hold on %Necessary for Tex interpreter???

plot(tout,err)
title('Error')
xlabel('time (s)')
ylabel('\Delta\omega_{bi} (\circ/s)')
legend('\Delta\omega_{bix}','\Delta\omega_{biy}','\Delta\omega_{biz}','Location','northeast')

q_bidata = q_bi.Data;
q_bidata = [tout,q_bidata];
q_bidata = transpose(q_bidata);

Vis3DAnimateAttitude(q_bidata, 10, 'Animation', 2);

% Vis3DAnimateAttitude. Creates animation of spacecraft attitude evolution
% given input quaternion ephemeris. Format:
%
%   [] = Vis3DAnimateAttitude(q_data, nsample, st_title, figure_size)
% Inputs:
%   q_data                [5xn] array of quaternion ephemeris, first row is time
%   nsample               [1] point subsampling integer (larger value, faster
%                         animation, but lower resolution
%   st_title              string label appended to figure window as title
%   figure_size           flag indicating whether figure is standard size (=1) or
%                         maximum supportable by screen (=2)
