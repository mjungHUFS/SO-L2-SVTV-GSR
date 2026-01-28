
clear all; 
close all;

addpath('data')
addpath('utility')
addpath('Solver_GSR')
addpath('Solver_SVTV')

%% original image
Img = 'barbara256.jpg';
Im0 = double(imread(Img));
img_name = Img(1:end-4);
[m,n,l] = size(Im0);

%% noisy data image
mul_L = 10;                   % multiplicative noise
Gau_noise = 20;               % Gaussian noise
% sigma = 1/sqrt(mul_L);
% multi_noise = gamrnd(1/sigma^2, sigma^2, m, n, l);
% Gaussian = Gau_noise*randn(size(Im0)); 
% f = Im0.*multi_noise + Gaussian;
filename = sprintf('f_%s_mul%d_gau%d.mat', img_name, mul_L, Gau_noise);
g = load(filename);
f = g.f;

%% parameters (almost fixed)
Opts.SearchWin = 20;          % Search window size
Opts.SlidingDis = 4;          % Overlapping 
Opts.ArrayNo = 80;            % # of patches
Opts.PatchSize = 6;           % patch size

Opts.gamma = (mul_L-1)/mul_L; % Fidelity (multiplicative)
Opts.delta = 1e-6;            % PAMA (proximal term)
Opts.lambdas = 0.001;         % v-component (almost fixed)
Opts.tau = 1;                 % GSR (fixed)
Opts.alpha = 0.6;             % SVTV (fixed)
Opts.xi = 1;                  % ADMM (fixed)

%% main regularization parameter
Opts.mus = 0.05;              % GSR ([0.01:0.01:0.12])
Opts.beta = 0.2;              % SVTV ([0.1,0.2,0.3])

%% Stopping condtion
Opts.Maxiter = 15;            % Outer iteration
Opts.tol = 0.005;
Opts.MaxiterU = 5;            % N_u_in (N_u_out=1)
Opts.tolU = 1e-3;
Opts.Maxiter_u = 5;           % N_u_Newton
Opts.tol_u = 1e-3;
Opts.Maxiter_q = 10;          % N_z (SVTV)
Opts.tol_q = 1e-3;

%% SO-L2-SVTV-GSR model 
[u,v,PSNR_plot] = perform_SO_L2_SVTV_GSR(f,Im0, Opts);

%% plot
PSNR_val = PSNR(u(:), Im0(:));
SSIM_val = ssim_index_col(u,Im0);

results_dir = fullfile(sprintf('results', mul_L, Gau_noise));
if ~exist(results_dir, 'dir'), mkdir(results_dir); end

fig=figure;
fig_name= fullfile(results_dir, sprintf('%s_L%d_G%d_results_lamb%d_mu%d_be%d',...
     img_name, mul_L, Gau_noise, round(1000*Opts.lambdas), round(100*Opts.mus), round(10*Opts.beta)));
subplot(221);imshow(uint8(f));title('Data f')
subplot(222);plot(PSNR_plot,'-or');title('PSNR values')
subplot(223);imshow(uint8(u)); title(sprintf('PSNR/SSIM=%.2f/%.4f', PSNR_val, SSIM_val))
subplot(224);imshow(v);title('V component')
print(fig, '-dpng', fig_name);