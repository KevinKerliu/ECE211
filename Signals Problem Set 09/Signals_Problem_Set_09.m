% ECE211 Problem Set 09
% Kevin Kerliu
clear;
close all;
clc;
%%
%%%
% Question 1 
% Part A
% x is ARMA.

% Part B
% This filter is the innovations filter.

% Part C
% v[n] = x[n] - 0.6x[n-1] + 0.9x[n-2] - v[n-1] - 0.36v[n-2]

% Part D
% Sx(w) = |H(w)|^2 * Sv(w)
% H(z) = (1 + z^-1 + 0.36z^-2)/(1 - 0.6z^-1 + 0.9z^-2)
% H(w) = (1 + e^-jw + 0.36e^-jw2)/(1 - 0.6e^-jw + 0.9e^-jw2)
% Thus: Sx(w) = 4* |(1 + e^-jw + 0.36e^-jw2)/(1 - 0.6e^-jw + 0.9e^-jw2)|^2
%%%
%%
%%%
% Question 2 
% Numerator of H(z)
b = [1, 1, 0.36]; 
% Denominator of H(z)
a = [1, -0.6, 0.9];

% Pole-Zero Plot
figure;
zplane(b,a);
title("Pole-Zero Plot of H(z)");
%%%
%%
%%%
% Question 3
% N is the number of samples
N = 10000;
% v[n] is mean 0, variance 4 white noise
% randn generates random numbers based on the Normal Distribution
% The default mean is 0 and the default variance is 1 
v = sqrt(4)*randn(1, N);
% Apply the filter to v to generate N samples of x
x = filter (b, a, v);
%%%

%%%
% Question 4
m0 = 5;
r = zeros(1, m0+1);
for k = 0:m0
   r(k+1) = dot(x(1:end-k), x(k+1:end))/(N-k+1);
end

%%%
%%
%%%
% Question 5
% We need M = m0 + 1
% Generate the correlation matrix
R = toeplitz(r);
%%%
%%
%%%
% Question 6
% Compute the eigenvalues of R
eigenvaluesR = eig(R);
% R is in fact positive definite as all its eigenvalues are greater than 0
%%%
%%
%%%
% Question 7
% Use pwelch to estimate the power spectral density of x
[s_est, w] = pwelch(x, hamming(512), 256, 512);

%%%
%%
%%%
% Question 8
% H(w)
Hw = freqz(b,a,w);
% Sx(w)
Sx = 4*(abs(Hw)).^2;
% Normalize the actual and estimated power spectral densities
s_est_norm = s_est/mean(s_est);
Sx_norm = Sx/mean(Sx);
% Plot the power spectral densities
figure;
plot(w, Sx_norm);
hold on; 
plot(w, s_est_norm);
legend("PSD", "Estimated PSD");
title("Exact PSD vs Estimated PSD");
xlabel("Normalized Digital Radian Frequency");
ylabel("PSD");
xlim([0, pi]);
    
%%%
%%
%%%
% Question 9
% Get the poles and zeros of the transfer function
[z,p,k] = tf2zp(b,a);
% Compute the angles of the poles of the transfer function
angles = angle(p)
% Determine the maximum of PSD
[peakPSD,maxWindex] = max(s_est_norm);
peak_w = w(maxWindex)
% The angles of the poles and the peak w are very close!
%%%
%%
%%%
% Question 10
% Construct A
col = x(m0+1:-1:1);
rows = x(m0+1:N);
A = toeplitz(col, rows);
% Find the singular values of A
sigma = svd(A);
% Compare A and R
Acomp = sort((sigma.^2)./(N - m0)); 
Rcomp = sort(eigenvaluesR);
diffAandR = Acomp - Rcomp
% Check that the left singular values of A are the eigenvalues of R
[U,~,~] = svds(A);
eigenVecR = (R*U)./U
Rcomp
% Comparing eigenVecR to RComp, the sorted eigenvalues of R, we see that
% all the entries in eigenVecR are in fact very close to each eigenvalue!
%%%