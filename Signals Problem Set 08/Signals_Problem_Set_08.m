% ECE211_Problem Set 08
% Kevin Kerliu
clear;
close all;
clc;
%%
%%%

% Question 3 Part A
% See attached function!

% Question 3 Part B
Q1 = 4;
myBode(Q1);
Q2 = 10;
myBode(Q2);

% Question 3 Part C
Wn = 1;
w_range = logspace(-1, 1, 1000);
b1 = [0, 0, (Wn)^2];
a1 = [1, (Wn/Q1), (Wn)^2];
H_Q1 = freqs(b1, a1, w_range);
phaseH_Q1 = unwrap(angle(H_Q1))*180/pi;
b2 = [0, 0, (Wn)^2];
a2 = [1, (Wn/Q2), (Wn)^2];
H_Q2 = freqs(b2, a2, w_range);
phaseH_Q2 = unwrap(angle(H_Q2))*180/pi;

figure;
semilogx(w_range, phaseH_Q1);
hold on;
semilogx(w_range, phaseH_Q2);
title("Phase Response");
xlabel("Frequency (rad/sec)");
ylabel("Phase (degrees)");
legend("Q = 4","Q = 10");
    
%%