function DCM = rotmat3(angle)
% ROTMAT3   Transformation matrix for yaw rotation.
%  
%   DCM = ROTMAT2(ANGLE) returns the transformation matrix for a yaw
%   rotation through ANGLE.
%
%   Used to calculate new coordinates as old coordinates rotated through
%   angle radians about Z axis.
c      = cos(angle);
s      = sin(angle);
DCM    = [c s 0; -s c 0; 0 0 1];

return