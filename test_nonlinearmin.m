%% Test  DFP

H = [3, 2; 1, 1]; c = [1,2];

func = @(x) x'*H*x + c*x;

nonlinearmin(func,[1;2],'DFP',0.1,1)


%% Test  BFGS

H = [3, 2; 1, 1]; c = [1,2];

func = @(x) x'*H*x + c*x;

nonlinearmin(func,[1;2],'BFGS',0.1,1)