%% Homework - 3
%  Question: 3
%  Author: Harsh Bhate
%% Cleaning Stuff
clc;
clear all;
%% Common Declarations
p_xGivenTheta = [0.075 0.025 0 0.025 0.075 0.1375 0.1875 0.2 0.1875 0.125];
p_theta1 = [0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2];
p_theta2 = [0 0.05 0.11 0.21 0.28 0.21 0.11 0.05 0 0];
p_theta3 = [0 0 0 0.2 0.6 0.2 0 0 0 0];
%% Prob 1(a)
p_theta1Givenx = prosteriorProb(p_xGivenTheta, p_theta1);
%% Prob 1(b)
p_theta2Givenx = prosteriorProb(p_xGivenTheta, p_theta2);
%% Prob 1(c)
p_theta3Givenx = prosteriorProb(p_xGivenTheta, p_theta3); 
%% Prob 1(d)
[~, MLE] = max(p_xGivenTheta);
[~, MAP_theta1] = max(p_theta1Givenx);
[~, MAP_theta2] = max(p_theta2Givenx);
[~, MAP_theta3] = max(p_theta3Givenx);
txt1 = sprintf('MLE = %d', MLE);
txt2 = sprintf('MAP(theta1) = %d', MAP_theta1);
txt3 = sprintf('MAP(theta2) = %d', MAP_theta2);
txt4 = sprintf('MAP(theta3) = %d', MAP_theta3);
disp (txt1);
disp (txt2);
disp (txt3);
disp (txt4);
%% Function to compute prosterior probability
function prosterior = prosteriorProb(apriori, parameter)
    prosterior = apriori.*parameter;
    figure();
    X = [1 2 3 4 5 6 7 8 9 10];
    h(1) = subplot(2,2,1);
    stem(X, apriori, 'k')
    title ('Apriori Distribution ($P(x|\theta)$)', ...
        'Interpreter','latex')
    ylabel ('Probability ($P(x|\theta)$)', 'Interpreter','latex') 
    set(gca,'TickLabelInterpreter','latex')
    ylim([0 max(apriori)+0.01])
    
    h(2) = subplot(2,2,2);
    stem(X, parameter, 'k')
    title ('Stimulus Parameter Distribution ($P(\theta)$)', ...
        'Interpreter','latex')
    ylabel ('Probability ($P(\theta)$)', 'Interpreter','latex') 
    set(gca,'TickLabelInterpreter','latex')
    ylim([0 max(parameter)+0.01])
    
    h(3) = subplot(2,2,3);
    stem(X, prosterior, 'k')
    title ('Prosterior Distribution ($P(\theta|x)$)', ...
        'Interpreter','latex')
    ylabel ('Probability ($P(\theta|x)$)', 'Interpreter','latex') 
    set(gca,'TickLabelInterpreter','latex')
    ylim([0 max(prosterior)+0.01])
    
    pos = get(h,'Position');
    new = mean(cellfun(@(v)v(1),pos(1:2)));
    set(h(3),'Position',[new,pos{end}(2:end)])
end