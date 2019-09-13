%% Homework - 3
%  Question: 2
%  Author: Harsh Bhate
%% Cleaning Up
clear all;
clc;
%% Part 2(a) Generating Dataset
mu = [0 0];
sigma = [1 0; 0 16];
R = chol(sigma);
z = repmat(mu,1000,1) + randn(1000,2)*R;
theta = - pi/4;
A = [cos(theta) -sin(theta); sin(theta) cos(theta)];
data = z*A;
figure();
subplot(1,2,1);
plot (z(:,1),z(:,2),'.k');
title ('\textbf{Data}', ...
        'Interpreter','latex')
ylim([-20 20]);
xlim([-20 20]);
axis square;
subplot(1,2,2);
plot (data(:,1),data(:,2),'.k');
title ('\textbf{Rotated Data}', ...
        'Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
ylim([-20 20]);
xlim([-20 20]);
set(gca,'TickLabelInterpreter','latex')
axis square;

%   Plotting the histograms
figure()
subplot(1,2,1);
h1 = histfit(data(:,1));
set(h1(1),'facecolor',[0.65,0.65,0.65]); set(h1(2),'color','k')
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/100)
title ('\textbf{Marginal Distribution of x ($P_{x}(X)$})', ...
        'Interpreter','latex')  
set(gca,'TickLabelInterpreter','latex')

subplot(1,2,2);
h2 = histfit(data(:,2));
set(h2(1),'facecolor',[0.65,0.65,0.65]); set(h2(2),'color','k')
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/100)
title ('\textbf{Marginal Distribution of x ($P_{y}(Y)$})', ...
        'Interpreter','latex')  
set(gca,'TickLabelInterpreter','latex')
%% Part 2(b) Estimating Covariance
sigma_estimated = cov (data);
disp('The Estimated Covariance is:');
disp(sigma_estimated);
%% Part 2(c) Eigenvalue
[eigenVectors, D] = eig(sigma_estimated);
disp('The Eigenvalues are:');
disp(D);
disp('The Eigenvectors are:');
disp(eigenVectors);
v1 = eigenVectors(:,1);
v2 = eigenVectors(:,2);
eigen = sqrt(diag(D));
figure();
plot (data(:,1),data(:,2),...
    '.', 'color', [0.75 0.75 0.75]);
hold on;
quiver(0, 0, v1(1), v1(2),eigen(1),...
    'LineWidth', 1, 'MaxHeadSize', 1, 'color', [0 0 0]);
hold on;
quiver(0, 0, v2(1), v2(2),eigen(2),...
    'LineWidth', 1, 'MaxHeadSize', 1, 'color', [0 0 0]);
hold on;
title ('\textbf{Data along with eigenvalues (Magnified)}', ...
        'Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
axis square
set(gca,'TickLabelInterpreter','latex')
axis square;
leg = legend('Data','Eigenvector $\mathbf{V} = [\vec{v}_1, \vec{v}_2]$');
    set(leg,'Interpreter','latex');
%% Part (d). Generating New Data 
theta = + pi/4;
A = [cos(theta) -sin(theta); sin(theta) cos(theta)];
data2 = z*A;
merged_data = vertcat(data,data2);

figure();
plot (merged_data(:,1),merged_data(:,2),'.k');
title ('\textbf{Merged Data}', ...
        'Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
ylim([-20 20]);
xlim([-20 20]);
set(gca,'TickLabelInterpreter','latex')
axis square;
%   Plotting the histograms
figure()
subplot(1,2,1);
h1 = histfit(merged_data(:,1));
set(h1(1),'facecolor',[0.65,0.65,0.65]); set(h1(2),'color','k')
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/200)
title ('\textbf{Marginal Distribution of x ($P_{x}(X)$})', ...
        'Interpreter','latex')  
set(gca,'TickLabelInterpreter','latex')

subplot(1,2,2);
h2 = histfit(merged_data(:,2));
set(h2(1),'facecolor',[0.65,0.65,0.65]); set(h2(2),'color','k')
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/200)
title ('\textbf{Marginal Distribution of x ($P_{y}(Y)$})', ...
        'Interpreter','latex')  
set(gca,'TickLabelInterpreter','latex')
%% Part (e) PCA
sigma_new = cov(merged_data);
[Vectors, D] = eig(sigma_new);
disp(Vectors)
v1 = Vectors(:,1);
v2 = Vectors(:,2);
eigen = sqrt(diag(D));
v1 = v1;
v2 = v2;
figure();
plot (merged_data(:,1),merged_data(:,2),...
     '.', 'color', [0.75 0.75 0.75]);
hold on;
quiver(0, 0, v1(1), v1(2), eigen(1), ...
    'LineWidth', 1, 'MaxHeadSize', 1, 'color', [0 0 0]);
hold on;
quiver(0, 0, v2(1), v2(2), eigen(2), ...
    'LineWidth', 1, 'MaxHeadSize', 1, 'color', [0 0 0]);
hold off;
title ('\textbf{Merged Data along with PCA vectors}', ...
        'Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
axis square
set(gca,'TickLabelInterpreter','latex')
axis square;
leg = legend('Data','Eigenvector $\mathbf{V} = [\vec{v}_1, \vec{v}_2]$');
    set(leg,'Interpreter','latex');
