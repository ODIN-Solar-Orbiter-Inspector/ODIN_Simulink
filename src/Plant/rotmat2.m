function DCM = rotmat2(angle)
% ROTMAT2   Transformation matrix for pitch rotation.
%  
%   DCM = ROTMAT2(ANGLE) returns the transformation matrix for a pitch
%   rotation through ANGLE.
%
%   Used to calculate new coordinates as old coordinates rotated through
%   angle radians about Y axis.
c         = cos(angle);
s         = sin(angle);
DCM       = [c 0 s; 0 1 0; -s 0 c]';

return