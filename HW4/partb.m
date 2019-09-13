%% Part (b)
N = 2;
alpha = 0.9;
max_iter = 5000;
p_xGiveny = generateDistribution(N, alpha);
disp (p_xGiveny);
%% Part (c)
N = 2;
alpha = 0.9;
max_iter = 5000;
p_xGiveny = generateDistribution(N, alpha);
r_x = BlahutArimoto(N, p_xGiveny, max_iter);
% plotR(r_x, "partc");
%% Part (d)
N = 10;
alpha = 0.9;
max_iter = 5000;
p_xGiveny = generateDistribution(N, alpha);
p_xGiveny(isnan(p_xGiveny)) = 0.00001;
r_x = BlahutArimoto(N, p_xGiveny, max_iter);
disp(p_xGiveny);
plotR(r_x, "partd");
%% Part (e)
% N = 10;
% alpha = 1;
% max_iter = 5000;
% p_xGiveny = generateDistribution(N, alpha);
% r_x = BlahutArimoto(N, p_xGiveny, max_iter);
% plotR(r_x, "parte");