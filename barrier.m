function barrier = barrier(f, g_k, epsilon)

    function q = q(x)
        q = f(x) + epsilon * beta(g_k, x);
    end

    barrier = @q;
end

function val = values(g_k, x)
    val(1) = 0;
    for i = 1:numel(g_k)
        g = g_k{i};
        val(i) = g(x);
    end
end

function beta = beta(g_k, x)
    val = values(g_k, x);
    
    not_feasible = any(val >= 0);
    
    if not_feasible
        beta = 1e200;
    else
        val = 1./val;
        beta = -sum(val);
    end
end