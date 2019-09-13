%% Part 1(a). Blahut-Arimoto Algorithm
% Initializing the two binary channels, r(x),  q(x|y), symbols and
% iterations
function r = BlahutArimoto(nos_symbols, p_yGivenx, max_itr)
    nos_symbols = nos_symbols + 1;
    r_x = unidpdf(1:nos_symbols, nos_symbols);
    q_xGiveny = zeros(nos_symbols);
    % Running the Blahut-Arimoto Update Algorithm
    for itr = 1:max_itr
        % Step - 2: Updating q(x|y)
        for y = 1:nos_symbols
            for x = 1:nos_symbols
                q_xGiveny(x,y) = (r_x(x)*p_yGivenx(y,x));
            end
                q_xGiveny(:,y) = q_xGiveny(:,y)./sum(q_xGiveny(:,y));
        end
        q_xGiveny(isnan(q_xGiveny)) = 0.0001;
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
    r = r_x;
end
