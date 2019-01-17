%% Test  DFP

func = @(x) x'*[3, 2; 0, 1]*x + [1,2]*x;

nonlinearmin(func,[1;2],'DFP',0.1,1)


%% Test  DFP
nonlinearmin(@func,[1;2;3;4],'DFP',0.1,1)