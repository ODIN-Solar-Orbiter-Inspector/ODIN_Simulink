function DCM = E1212DCM(phi, theta, psi)
% E121 to DCM function

DCM = rotmat1(psi)*rotmat2(theta)*rotmat3(phi);

end

