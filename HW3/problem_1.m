%% Homework - 3
%  Question: 1
%  Author: Harsh Bhate
%% Pre-loading and Pre-processing.
%  Loading Data to MATLAB
clear all;
clc;
load ('HW_corr_data.mat');
%% Part 1(a). Estimating Marginal Distribution from Joint Distribution
[px1,py1,px2,py2] = marginal (data1, data2);
marginal_dist = [px1,py1,px2,py2]
%% Part 1(b). Checking for Independence
[p00,p01,p10,p11] = conditional (data1);
conditional_dist = [p00,p01,p10,p11]
actualVsMarginal (px2,py2, conditional_dist)
%% Marginal PDF
function [fx1,fy1,fx2,fy2] = marginal(dist1, dist2)
    %   Function to find the marginal PDF and plot it for 
    %   two distributions dist1 and dist2.
    
    %   Extracting the x and y points for each distribution
    x1 = dist1(:,1);
    y1 = dist1(:,2);
    x2 = dist2(:,1);
    y2 = dist2(:,2);
    %   Computing the PDF
    fx1 = [(length(x1) - sum(x1))/length(x1), sum(x1)/length(x1)];
    fy1 = [(length(y1) - sum(y1))/length(y1), sum(y1)/length(y1)];
    fx2 = [(length(x2) - sum(x2))/length(x2), sum(x2)/length(x2)];
    fy2 = [(length(y2) - sum(y2))/length(y2), sum(y2)/length(y2)];
    %   Setting the labels for plotting
    x1Labels ={'$x_{1} = 0$'; '$x_{1} = 1$'};
    y1Labels ={'$y_{1} = 0$'; '$y_{1} = 1$'};
    x2Labels ={'$x_{2} = 0$'; '$x_{2} = 1$'};
    y2Labels ={'$y_{2} = 0$'; '$y_{2} = 1$'};
    %   Plotting the graph
    figure();
    subplot (2,2,1);
    bar(fx1, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',x1Labels)
    title ('Marginal Distribution of $x_{1}$','Interpreter','latex')
    ylabel ('Probability ($P(x)$)','Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(fx1),fx1,num2str(fx1'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex')
    subplot (2,2,2);
    bar(fy1, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',y1Labels)
    title ('Marginal Distribution of $y_{1}$', 'Interpreter','latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(fy1),fy1,num2str(fy1'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex')
    subplot (2,2,3);
    bar(fx2, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',x2Labels)
    title ('Marginal Distribution of $x_{2}$', 'Interpreter','latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(fx2),fx2,num2str(fx2'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex')
    subplot (2,2,4);
    bar(fy2, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',y2Labels)
    title ('Marginal Distribution of $y_{2}$','Interpreter','latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(fy2),fy2,num2str(fy2'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex') 
end
%% Function to plot continuous PDF
function [p00, p01, p10, p11] = conditional(dist)
    %   Function to plot conditional prob of binomial distribution dist
    
    %   Calculating the conditional PDF
    p00 = sum(dist(:, 1) == 0 & dist(:, 2) == 0)/length(dist);
    p01 = sum(dist(:, 1) == 0 & dist(:, 2) == 1)/length(dist);
    p10 = sum(dist(:, 1) == 1 & dist(:, 2) == 0)/length(dist);
    p11 = sum(dist(:, 1) == 1 & dist(:, 2) == 1)/length(dist);
    %   Labels
    xLabels ={'$P(0,0)$';'$P(0,1)$';'$P(1,0)$'; '$P(1,1)$'};
    %   Plotting
    figure();
    F = [p00, p01, p10, p11];
    bar(F, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',xLabels)
    title ('Joint Probability Distribution', ...
        'Interpreter','latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(F),F,num2str(F'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex')    
end
%% Function to plot Conditional PDF
function actualVsMarginal (Fx, Fy, conditional)
    %   Function to plot the marginal and conditional prob
    
    %   Extracting Distributions
    px0 = Fx(1)
    px1 = Fx(2)
    py0 = Fy(1)
    py1 = Fy(2)
    %   Plotting independence assumed distributions
    p_00 = px0*py0;
    p_01 = px0*py1;
    p_10 = px1*py0;
    p_11 = px1*py1;
    P_ind = [p_00, p_01, p_10, p_11]
    %   Labels
    xLabels ={'$P(0,0)$';'$P(0,1)$';'$P(1,0)$'; '$P(1,1)$'};
    %   Plotting
    figure();
    subplot(2,2,1)
    bar(conditional, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',xLabels)
    title ('Joint Probability Distribution of data2', ...
        'Interpreter','latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(conditional),conditional,num2str(conditional'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex')
    
    subplot(2,2,2)
    bar(P_ind, 'stacked','FaceColor',[1.0 1.0 1.0]);
    set(gca,'xticklabel',xLabels)
    title ('Joint Probability Distribution constructed from Independent Random Variables', ...
        'Interpreter','latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    text(1:length(P_ind),P_ind,num2str(P_ind'),...
        'vert','bottom','horiz','center', 'Interpreter','latex'); 
    set(gca,'TickLabelInterpreter','latex')
    
    subplot(2,2,3)
    bar(conditional, 'stacked','FaceColor',[0.65 0.65 0.65]);
    hold on
    bar(P_ind, 'stacked','FaceColor',[0.0 0.0 0.0]);
    set(gca,'xticklabel',xLabels)
    title ('Actual and Constructed Joint Distributions',...
        'Interpreter', 'Latex')
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    ylim([0.0 1.0])
    set(gca,'TickLabelInterpreter','latex')
    leg = legend('Actual Distribution','Constructed Distribution');
    set(leg,'Interpreter','latex');
    
    subplot(2,2,4)
    diff = conditional - P_ind
    bar(diff, 'stacked','FaceColor',[0.65 0.65 0.65]);
    set(gca,'xticklabel',xLabels)
    title ('Error between Actual vs Constructed Joint Distributions', ...
        'Interpreter','latex')
    ylim([-0.05 0.05])
    ylabel ('Probability ($P(x)$)', 'Interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
end
