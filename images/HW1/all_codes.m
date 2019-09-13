%% (b)Refractory Period
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
    end
    
end
%% (c)Varying Constant Current Inputs
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
%% (d) Code modification for adding noise to part (c)
for i = 1:31
    I = [I; (i-1)*ones(1,length(t)) + 3*randn(1,length(t))];
end
%% (e) Modification for time varying inputs
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


