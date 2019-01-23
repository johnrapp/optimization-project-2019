%% Test DFP quadratic

H = [3, 2; 1, 1]; c = [1,2];

func = @(x) x'*H*x + c*x;

[x, No_of_iterations] = nonlinearmin(func,[1;2],'DFP',0.1,1)
func(x)


%% Test BFGS quadratic

H = [3, 2; 1, 1]; c = [1,2];

func = @(x) x'*H*x + c*x;

[x, No_of_iterations] = nonlinearmin(func,[1;2],'BFGS',0.1,1)
func(x)

%% Test DFP Rosenbrock

func = @rosenbrock;
method = 'DFP';

[x, No_of_iterations] = nonlinearmin(func,[0;0],method,1e-6,0)
func(x)

[x, No_of_iterations] = nonlinearmin(func,[200;200],method,1e-6,0)
func(x)

[x, No_of_iterations] = nonlinearmin(func,[-100;200],method,1e-6,0)
func(x)

[x, No_of_iterations] = nonlinearmin(func,[-10;0.00001],method,1e-6,0)
func(x)

%% Test BFGS Rosenbrock

func = @rosenbrock;
method = 'BFGS';

[x, No_of_iterations] = nonlinearmin(func,[0;0],method,1e-6,0)
%func(x)

[x, No_of_iterations] = nonlinearmin(func,[200;200],method,1e-6,0)
%func(x)

[x, No_of_iterations] = nonlinearmin(func,[-100;200],method,1e-6,0)
%func(x)

[x, No_of_iterations] = nonlinearmin(func,[-10;0.00001],method,1e-6,0)
%func(x)