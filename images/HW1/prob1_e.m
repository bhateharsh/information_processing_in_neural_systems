%%% Base code for an INF neuron model.  Starting place for HW assignment in ECE/BME 6790.
%%% Questions: crozell@gatech.edu

%%% Initialize %%%

C = 1;   % membrane capacitance in nF
R = 10;  % total membrane resistance in MOhms
Vth = -50;  % spiking threshold in mV
Vsp = 50; % spike height in mV
El = -70;  %equilibrium potential in mV
Vre = El;  % reset potential in mV
spikes = [];
% all times are in ms
Ttot = 1;						% length of simulation
Tref = 2;                       % refractory time
DT = 0.001;                         % integration time step
t=(0:DT:Ttot)';                 % time vector
v = zeros(length(t),1);         % voltage trace
v(1) = El;
V = [];                         %Storing outputs
% example current injection stimulus with constant value of 3 nA over the whole simulation
% sampling rate is DT (in ms)
% Iin = 3*ones(1,length(t));
%Part (e)
amp = 4;        %4nA amplitude
freq = [1, 2, 5, 10, 25, 50, 100];       %Frequencies
I = [];
for f = freq
    I = [I, amp*sin(2*pi*f*t)];
end
%%% Simulate cell %%%
for col = 1:7
    Iin = I(:, col);
    spike = 0;
%     v = zeros(length(t),1);         % voltage trace
    for count=2:length(t)                
    
        if((v(count-1) == Vsp))                  % reset voltage if spike just occurred 
            v(count) = Vre;                      % after spike, cell will spend one sample at reset voltage before integration continues 
        else                                
            dvdt = ((El-v(count-1))/R + Iin(count))/C;    % otherwise, evaluate ode using first order Euler method
            v(count) = v(count-1) + dvdt*DT*1000;        
        end
    
        if(v(count) >= Vth)                    % check for threshold
            v(count) = Vsp;                    % if necessary, generate a spike
            spike = spike + 1;
        end
   
    end
    V = [V, v];
    spikes = [spikes, spike];
end

%%%Plot Config
V = V';
I = I';
for i = 2:7
    V(i,:) = V(i,:) + (i-1)*175;
    I(i,:) = I(i,:) + (i-1)*10;
end

%%% Plot results %%%
subplot(211);                     
plot(1000*t,I,'r-');
xlabel('time (ms)');
ylabel('input current (nA)');
title('Injected current');

subplot(212);
plot(t*1000,V,'b-');
xlabel('time (ms)');
ylabel('voltage (mV)');
title('Neuron output');

% figure(2);
% semilogx(freq', spikes');
% xlabel('Frequency (Hz)');
% ylabel('Spike Rate (Hz)');
% title ('Frequency vs Spike Rate');
