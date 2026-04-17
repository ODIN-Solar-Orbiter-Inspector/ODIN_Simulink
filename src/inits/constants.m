%{

Ideally, everytime we redownload updated mass properties from MECH Team,
our whole sim. updates aswell.

MP = read(massproperties.csv)

m = MP.mass;
I = MP.I;
% Calculate the center of mass and inertia tensor
com = MP.centerOfMass;
inertiaTensor = I; % Assuming I is already the inertia tensor

%}