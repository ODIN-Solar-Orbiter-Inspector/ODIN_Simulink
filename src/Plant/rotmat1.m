function DCM = rotmat1(angle)
% ROTMAT1   Elementary transformation matrix for roll (=X-axis) rotation.
%  
%   DCM = ROTMAT1(ANGLE) returns the transformation matrix for a roll
%   rotation through ANGLE.
%
%   Used to calculate new coordinates as old coordinates rotated through
%   angle radians about X axis.
c         = cos(angle);
s         = sin(angle);
DCM       = [1 0 0;0 c s;0 -s c];

return