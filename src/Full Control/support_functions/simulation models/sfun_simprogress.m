function sfun_simprogress(block)
% SFUN_SIMPROGRESS A Level-2 MATLAB S-function that outputs the current
% simulation time to MATLAB at regular intervals.

setup(block);

%=============================================================================
% Function: setup
%=============================================================================
function setup(block)

% Register number of dialog parameters
block.NumDialogPrms = 1;  % update_interval

% Set up the basic characteristics
block.NumInputPorts  = 0;
block.NumOutputPorts = 0;
block.NumContStates  = 0;
%block.NumDiscStates  = 0;

% Set direct feedthrough
%block.SetDirectFeedthrough(0);

% Set the sample time
update_interval = block.DialogPrm(1).Data;
block.SampleTimes = [update_interval 0];

% Set block methods
block.RegBlockMethod('Outputs', @Outputs);
block.RegBlockMethod('Start', @Start);

%=============================================================================
% Function: Start
%=============================================================================
function Start(block)
disp('----------------------------------------------------------------');

%=============================================================================
% Function: Outputs
%=============================================================================
function Outputs(block)
t = block.CurrentTime;
disp(['time = ', num2str(t, '%0.0f'), 's']);