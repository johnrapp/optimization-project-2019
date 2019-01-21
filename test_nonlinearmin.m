%% Test DFP quadratic

H = [3, 2; 1, 1]; c = [1,2];

func = @(x) x'*H*x + c*x;

x = nonlinearmin(func,[1;2],'DFP',0.1,1)
func(x)


%% Test BFGS quadratic

H = [3, 2; 1, 1]; c = [1,2];

func = @(x) x'*H*x + c*x;

x = nonlinearmin(func,[1;2],'BFGS',0.1,1)
func(x)

%% Test DFP Rosenbrock

func = @rosenbrock;
x = nonlinearmin(func,[0;0],'DFP',1e-6,0)
func(x)