1) [ImgRec, alphaG] = GSR_Solver_Color_PAMA(ImgInput, Opts);

GSR_Solver_Color_PAMA minimizes the energy:
0.5*Opts.mu*||DG*alphaG- ImgInput||^2 + Opts.lambda*||alphaG||_0 + 0.5*Opts.delta*||alphaG - alphaG^n||^2

=> Input:
Opts.delta = 1e-6;            % PAMA (proximal term)
Opts.tau = 1;                   % this corresponds to "Opts.mu" in GSR_solver
Opts.mus = 0.05;              % this corresponds to "Opts.lambda" in GSR_solver
Opts.alphaG = alphaG^n;   % PAMA 
=> Output: x=DG*alpha_G & alphaG


2) z = perform_L2_SVTV(z_Init, g, Opts);

SVTV_solver minimizes the energy: 0.5*mu*(z-g)^2 + beta*SVTV(z) 

=> Input: 
Opts.xi = 1                  % this corresponds to "mu" in SVTV_solver
Opts.alpha = 0.6;          % SVTV (fixed)
Opts.beta = 0.2;            % SVTV (main parameter)
Opts.Maxiter_q = 10;     % N_z (SVTV)
Opts.tol_q = 1e-3;     
=> Output: resored image "w = HSV_to_RGB(z)"

