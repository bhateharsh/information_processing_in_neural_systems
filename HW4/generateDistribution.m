%% Part (b). 
function p = generateDistribution(N, alpha)
    p_yGivenx = zeros((N+1));
    for x = 0:N
        for y = 0:N
            prob_spike = alpha^x;
            x_ind = x+1;
            y_ind = y+1;
            p_yGivenx(y_ind,x_ind) = binopdf(y,x,prob_spike);
        end
    end
    p = p_yGivenx;
end
