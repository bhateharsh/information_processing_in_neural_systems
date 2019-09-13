%% Homework - 4 
% Author: Harsh Bhate
clc;
clear all;
%% Part 1(a). Blahut-Arimoto Algorithm
% Initializing the two binary channels, r(x),  q(x|y), symbols and
% iterations
max_itr = 5000;
symbols = [0 1];
nos_symbols = 2;
p_yGivenx_1 = [0.9 0.1;
               0.1 0.9];
p_yGivenx_2 = [0.99 0.4;
               0.01 0.6];
r_x = unidpdf(1:nos_symbols, nos_symbols);
q_xGiveny = zeros(nos_symbols);
% Choosing the binary channel
choice = 2;
if choice == 1
    p_yGivenx = p_yGivenx_1;
elseif choice == 2
    p_yGivenx = p_yGivenx_2;
else
    disp("Choose either 1 or 2");
end
% Running the Blahut-Arimoto Update Algorithm
for itr = 1:max_itr
    % Step - 2: Updating q(x|y)
    for y = 1:nos_symbols
        for x = 1:nos_symbols
            q_xGiveny(x,y) = (r_x(x)*p_yGivenx(y,x));
        end
            q_xGiveny(:,y) = q_xGiveny(:,y)./sum(q_xGiveny(:,y));
    end
    % Step - 3: Updating r(x)
    for x = 1:nos_symbols
        numerator = 1;
        for y = 1:nos_symbols
            numerator = numerator*(power(q_xGiveny(x,y), p_yGivenx(y,x)));
        end
        r_x(x) = numerator;
    end
    r_x = r_x./sum(r_x);
end
% Displaying the Result
%   Setting the labels for plotting
xLabels ={'$r(x = 0)$'; '$r(x = 1)$'};
%   Plotting the graph
figure();
bar(r_x, 'stacked','FaceColor',[0.65 0.65 0.65]);
set(gca,'xticklabel',xLabels)
title ('Probability distribution of X by Blahut-Arimoto Algorithm',...
       'Interpreter','latex')
ylabel ('Probability','Interpreter','latex')
ylim([0.0 1.0])
text(1:length(r_x),r_x,num2str(r_x'),...
    'vert','bottom','horiz','center', 'Interpreter','latex',...
    'FontSize', 20); 
set(gca,'FontSize',20);
set(gca,'TickLabelInterpreter','latex')
saveas(gcf,"parta_2.png")
set(gca,'FontSize',20);