function [phi, theta, psi] = dcm2e121(A)

phi   = atan2(A(1,2),-A(1,3));
theta = acos( sign(A(1,1))*min(abs(A(1,1)),1) );
psi   = atan2(A(2,1),A(3,1));

limit = 1e-6;
if abs(sin(theta)*sin(phi)-A(1,2))>limit | abs(-sin(theta)*cos(phi)-A(1,3))>limit
    theta = -theta;
end

phi    = phi   + 2*pi*(phi<0);
theta  = theta + 2*pi*(theta<0);
psi    = psi   + 2*pi*(psi<0);
