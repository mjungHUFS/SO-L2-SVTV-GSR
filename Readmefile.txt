1) [x, alphaG] = GSR_Solver_Color_PAMA(ImgInput, Opts);

GSR_Solver_Color_PAMA minimizes the energy:
E(alphaG) = 0.5*Opts.mu*||DG*alphaG-ImgInput||^2 + Opts.lambda*||alphaG||_0 + 0.5*Opts.delta*||alphaG-alphaG^n||^2

** Input:
Opts.tau = 1;                 % this corresponds to "Opts.mu" in GSR_solver
Opts.mus = 0.05;              % this corresponds to "Opts.lambda" in GSR_solver
Opts.delta = 1e-6;            % PAMA (proximal term)
Opts.alphaG = alphaG^n;       % PAMA 
** Output: x=DG*alphaG & alphaG

** Initialziation for alphaG (i.e. alphaG^0):
[m, n, l] = size( f );
N     =  m-PatchSize+1;
M     =  n-PatchSize+1;
L     =  N*M; 
Row     =  [1:SlidingDis:N];
Row     =  [Row Row(end)+1:N];
Col     =  [1:SlidingDis:M];
Col    =  [Col Col(end)+1:M];
I        =   (1:L);
I        =   reshape(I, N, M);
NN       =   length(Row);
MM       =   length(Col);
alphaG = zeros(NN, MM, PatchSize*PatchSize*l, ArrayNo);


2) z = perform_L2_SVTV(z_Init, g, Opts);

SVTV_Solver minimizes the energy: E(z)= 0.5*mu*||z-g||^2 + beta*SVTV(z) 

** Input: 
Opts.xi = 1                % this corresponds to "mu" in SVTV_solver
Opts.alpha = 0.6;          % SVTV (fixed)
Opts.beta = 0.2;           % SVTV (main parameter)
Opts.Maxiter_q = 10;       % N_z (SVTV)
Opts.tol_q = 1e-3;     
** Output: z => resored image "w = HSV_to_RGB(z)"




