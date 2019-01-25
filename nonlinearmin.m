function [x, No_of_iterations] = nonlinearmin(f, start, method, tol, printout)

update_matrix = update_matrix_fn(method);

max_iterations = 5000;
n = numel(start);
x = start;
No_of_iterations = 0;

print_header(printout);

while No_of_iterations < max_iterations
    No_of_iterations = No_of_iterations + 1;

    y = x;
    D = eye(n);
    for j = 1:n
        d = -D*grad(f, y);
        [lambda, ls_iter] = linesearch(f, y, d);
        next_y = y + lambda*d;
        D = update_matrix(f, D, lambda, d, y, next_y);

        y = next_y;
    end
    x_next = next_y;
    
    if should_stop(f, x, x_next, tol)
        break;
    end
    
    print_row(printout, No_of_iterations, x, x_next, f, ls_iter, lambda);
    
    x = x_next;
    
    if No_of_iterations == max_iterations
        error('Too long time in minimization!')
    end
end

x = x_next;
if isnan(f(x)) || f(x) > f(start)
    error('Bad job of the search!')
end

end

function update_matrix = update_matrix_fn(method)
    if method == "DFP"
        update_matrix = @update_DFP;
    elseif method == "BFGS"
        update_matrix = @update_BFGS;
    end
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

function stop = should_stop(f, x, x_next, tol)
    stop = all(abs(x_next - x) <= tol) || abs(f(x_next) - f(x)) < tol;
end

function print_header(printout)
    if (printout) 
        disp("iterations     x       stepsize          f(x)       norm(grad)    ls iters    lambda");  
    end
end

function print_row(printout, No_of_iterations, x, x_next, f, ls_iter, lambda)
    if (printout)
        step_size = norm(x - x_next);
        fprintf('%5.0f %12.4f %12.4f %15.4f %13.4f %8.0f %13.4f\n', ...
            No_of_iterations, ...
            x(1), ...
            step_size, ...
            f(x), ...
            norm(grad(f,x)), ...
            ls_iter, ...
            lambda ...
        );
        for k = 2:numel(x)
          fprintf('%18.4f\n', x(k));
        end 
    end
end