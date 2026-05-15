function euler = quat2euler_zyx(q)
% QUAT2EULER_ZYX  Converts unit quaternion to ZYX Euler angles.
%   Returns [roll; pitch; yaw] in radians.
    q0 = q(1); q1 = q(2); q2 = q(3); q3 = q(4);
 
    % ZYX (yaw → pitch → roll) rotation matrix elements
    sinp  = 2*(q0*q2 - q3*q1);
    sinp  = max(-1, min(1, sinp));   % clamp for numerical safety
 
    roll  = atan2( 2*(q0*q1 + q2*q3), 1 - 2*(q1^2 + q2^2) );
    pitch = asin( sinp );
    yaw   = atan2( 2*(q0*q3 + q1*q2), 1 - 2*(q2^2 + q3^2) );
 
    euler = [roll; pitch; yaw];
end
