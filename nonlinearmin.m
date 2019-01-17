function [x, No_of_iterations] = nonlinearmin(f, start, method, tol, printout)

if method == "DFP"
    update_matrix = @update_DFP;
elseif method == "BFGS"
    update_matrix = @update_BFGS;
end

n = numel(start);

x_next = start;

No_of_iterations = 0;

for k = 1:1
No_of_iterations = No_of_iterations + 1;

y = x_next;
D = eye(n);
for j = 1:n
    d = -D*grad(f, y);
    lambda = linesearch(f, y, d);
    next_y = y + lambda*d;
    D = update_matrix(f, D, lambda, d, y, next_y);
    
    y = next_y;
    x_next = next_y;
end
end

x = x_next;

if isnan(func(x)) || func(x) > func(start)
    error('Bad job of the search!')
end

indiana_jones();

end

function [p, q] = get_pq(f, lambda, d, y, next_y)
    p = lambda * d;
    q = grad(f, next_y) - grad(f, y);
end
function D = update_DFP(f, D, lambda, d, y, next_y)
	[p, q] = get_pq(f, lambda, d, y, next_y);
    D = D + (p*p')/(p'*q) - (D*(q*q')*D)/(q'*D*q);
end
function D = update_BFGS(f, D, lambda, d, y, next_y)
	[p, q] = get_pq(f, lambda, d, y, next_y);
    D = D + (1 + q'*D*q/(p'*q))*(p*p')/(p'*q)-(p*q'*D+D*q*p')/(p'*q);
end