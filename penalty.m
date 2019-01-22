function penalty = penalty(f, g_k, h_k, mu)

    function q = q(x)
        q = f(x) + mu * alpha(g_k, h_k, x);
    end

    penalty = @q;
end

function val = values(g_k, x)
    val(1) = 0;
    for i = 1:numel(g_k)
        g = g_k{i};
        val(i) = g(x);
    end
end

function alpha = alpha(g_k, h_k, x)
    alpha_g = max(values(g_k, x), 0).^2;
    alpha_h = values(h_k, x).^2;
    
    alpha = sum(alpha_g) + sum(alpha_h);
end
