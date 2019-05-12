% ECE211_Problem Set 07
% Kevin Kerliu
clear;
close all;
clc;
%%
%%%

% Question 1 Part C
A = [3/10, 1; 2/5, 0];
B = [3/4; 9/10];
C = [1, 0];
D = [1/2];
[b,a] = ss2tf(A,B,C,D);

% Question 1 Part D
Aprime = A.';
Bprime = C.';
Cprime = B.';
Dprime = D.';
[bprime, aprime] = ss2tf(Aprime,Bprime,Cprime,Dprime);
% a == aprime && b == bprime ... this is true, H(z) has not changed!

%%

% Question 1 Part E
b1 = [1/2, 3/5, 7/10];
a1 = [1, -3/10, -2/5];
[A1,B1,C1,D1] = tf2ss(b1,a1);
% This is something else!

% Question 1 Part F
T = [5, 2; 7, 3];
A1prime = T*A1*inv(T);
B1prime = T*B1;
C1prime = C1*inv(T);
D1prime = D1;

syms z;
H = C1prime*inv((z*eye(2) - A1prime))*B1prime + D1prime;
H = simplify(H)
%  This is our original H(z)!

%%%
%%
%%%

% Question 3 Part A
A = [139.3, -263, -135; ...
     83, -156.7, -80.4; ...
     -18, 34, 17.5];
eigenA = eig(A);

% Question 3 Part B
syms z;
zXformAn = z*inv((z*eye(3) - A)); % z-transform of A^n
phi = iztrans(zXformAn); % A^n

% Question 3 Part C
N = 40;
X = zeros(3,N+1);
X(:,1) = [1; 1; 1];
for k=1:N
    X(:,k+1) = A*X(:,k);
end

% Question 3 Part D
lengthX = sqrt(sum(X.^2));
lengthXdB = 20*log10(lengthX);
% As x approaches 0, the length of |x| in decibels will
% approach negative infinity!
figure;
stem(lengthXdB);
title("");
xlabel("n");
ylabel("Length (dB)");
set(gca, 'XLim', [0 42]);
set(gca, 'YLim', [-200 55]);

% Question 3 Part E
slope = (lengthXdB(end) - lengthXdB(10)) / (N - 10);
% Slope is ~ -6.2669
% To approximate the slope we take the values for which it seems
% like the length of X in decibels converges to a staight line 
% with a negative slope, which is from the 10th vector to the last
% vector.

% Question 3 Part F
An = A^N;
phiN = double(subs(phi, 'n', N));
error = max(max(abs(phiN - An)));
% The difference is neglible.

%%%
%%

% Question 4 Part A
normA = norm(A);
AxposeA = A.'*A;
eigenAxposeA = eig(AxposeA);
maxEigAxposeA = max(eigenAxposeA);
normAcheck = sqrt(maxEigAxposeA);
% The norms are the same!

% Question 4 Part B
n = 5;
Xq = zeros(3,n+1);
Xq(1:3,1) = [1; 1; 1];
for k=1:n
    Xq(:,k+1) = A*Xq(:,k);
% Implementation of quantization:
    Xq(Xq > 127) = 127;
    Xq(Xq < -128) = -128;
end
% The last few xq vectors are exactly the same..!



