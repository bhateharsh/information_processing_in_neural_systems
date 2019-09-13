function plotR(r, name)
    %   Plotting the graph
    figure();
    x = 0:(length(r)-1);
    bar(x, r,...
        'stacked','FaceColor',[0.65 0.65 0.65]);
    title ('Capacity Achieving Distribution $r(x)$',...
       'Interpreter','latex');
    ylabel ('Probability','Interpreter','latex');
    xlabel ('X','Interpreter','latex');
    ylim([0.0 1.0]);
    text(x,r,num2str(r','%0.4f'),...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom',...
    'Interpreter', 'latex',...
    'FontSize', 20);
    set(gca,'TickLabelInterpreter','latex');
    set(gca,'FontSize',20);
    saveas(gcf, name+".png");
end
