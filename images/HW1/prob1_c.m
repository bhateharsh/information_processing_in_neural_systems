%%% Base code for an INF neuron model.  Starting place for HW assignment in ECE/BME 6790.
%%% Questions: crozell@gatech.edu
clear all;
clc;
%%% Initialize %%%

C = 1;   % membrane capacitance in nF
R = 10;  % total membrane resistance in MOhms
Vth = -50;  % spiking threshold in mV
Vsp = 50; % spike height in mV
El = -70;  %equilibrium potential in mV
Vre = El;  % reset potential in mV

% all times are in ms
Ttot = 1000;						% length of simulation
DT = 1;                         % integration time step
t=(0:DT:Ttot)';                 % time vector
v = zeros(length(t),1);         % voltage trace
v(1) = El;
tref = 4;
tcounter = tref;
% example current injection stimulus with constant value of 3 nA over the whole simulation
% sampling rate is DT (in ms)
Iin = 3*ones(1,length(t));
I = [];
S = [];
for i = 1:31
    I = [I; (i-1)*ones(1,length(t))];
end
%%% Simulate cell %%%
for i = 1:31
    Iin = I(i, :);
    spike = 0;
    for count=2:length(t);                 
    
    if tcounter <= tref                  % reset voltage if spike just occurred 
        v(count) = Vre;                    % after spike, cell will spend one sample at reset voltage before integration continues 
        tcounter = tcounter + 1;
    else                                
        dvdt = ((El-v(count-1))/R + Iin(count))/C;    % otherwise, evaluate ode using first order Euler method
        v(count) = v(count-1) + dvdt*DT;        
    end
    
    if(v(count) >= Vth)                    % check for threshold
        v(count) = Vsp;                    % if necessary, generate a spike
        tcounter = 0;
        spike = spike + 1;
    end
    
    end
    S = [S; spike];
end

%%%Offset
%%% Plot results %%%
tP = linspace(0,30,31);
plot(tP', S,'r-');
xlabel('Injected Current (nA)');
ylabel('Spike Rate (Hz)');
title('Spike Rate vs Current');

