function alpha = penalty(g_k, x)
    val = values(g_k, x)
    
    val = max(val, 0)
    val = val.^2;
    
    alpha = sum(val);
end

function val = values(g_k, x)
    s = size(g_k);
    n = s(2);
    for i = 1:n
        g = g_k{i};
        val(i) = g(x);
    end
end

