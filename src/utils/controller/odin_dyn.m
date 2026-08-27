function dX = odin_dyn(X,F_b,T_b,I)
% SATELLITE_DYNAMICS  Computes dx/dt for a rigid-body satellite.
%
%   x  = [q0; q1; q2; q3; wx; wy; wz]   (7×1)
%   u  = [Tx; Ty; Tz]                    control torques (N·m)
%   I  = 3×3 inertia tensor
%   xdot : time derivative of x
 
    % Unpack state
    q  = X(1:4);          % quaternion [q0; qvec]
    w  = X(5:7);          % angular velocity
 
    % --- Quaternion kinematics: qdot = 0.5 * Xi(q) * w ---
    % Xi maps body angular velocity to quaternion rate
    q0 = q(1); qv = q(2:4);
    Xi = [ -qv'         ;   % 1×3 row
            q0*eye(3) + skew(qv) ];  % 3×3 block
    qdot = 0.5 * Xi * w;   % 4×1
 
    % --- Euler's rotational equations: I*wdot = T - w × (I*w) ---
    wdot = I \ (u - cross(w, I*w));   % 3×1
 
    dX = [qdot; wdot];
end