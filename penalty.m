function penalty = penalty(f, g_k, mu)

    function q = q(x)
        q = f(x) + mu * penalty_general(g_k, x);
    end
    
    penalty = @q;
end

function val = values(g_k, x)
    for i = 1:numel(g_k)
        g = g_k{i};
        val(i) = g(x);
    end
end

function alpha = penalty_general(g_k, x)
    val = values(g_k, x)
    
    val = max(val, 0)
    val = val.^2;
    
    alpha = sum(val);
end
