% ECE211 Problem Set 05
% Kevin Kerliu
clear;
close all;
clc;
%%
%%%
% Question 2 
% Part A
syms z;
H_numerator = 2*(z-3)*((3*z-2)^(2))*(2*z-1);
H_denominator = ((4*z-3)^(2))*((2*z+1)^(2));

H_numerator = sym2poly(expand(H_numerator)); 
H_denominator = sym2poly(expand(H_denominator));

[z, p, k] = tf2zp(H_numerator,H_denominator);
[b, a] = zp2tf(z, p, k);


% Part B
figure;
zplane(b,a);
title("Pole-Zero Plot");


% Part C
n1 = 0:19;
x = ((0.8).^(n1)).*cos((4*pi*n1)/5);
y = filter(b, a, x);

figure;
subplot(2,1,1);
stem(n1,x);
title("x[n]");
xlabel("n");
ylabel("x[n]");
subplot(2,1,2);
stem(n1,y);
title("y[n]");
xlabel("n");
ylabel("y[n]");


% Part D
fs = 20000;
f2 = linspace(0, fs/2, 1000);
h = freqz(b, a, f2, fs);
mag_h = 20*log10(abs(h));
phase_h = unwrap(angle(h))*180/pi;

figure;
subplot(2,1,1);
plot(f2,mag_h)
title("Magnitude Response");
xlabel("Frequency (Hz)");
ylabel("Amplitude (dB)");

subplot(2,1,2);
plot(f2,phase_h)
title("Phase Response");
xlabel("Frequency (Hz)");
ylabel("Phase (Degrees)");
%%%
%%
%%%

% Question 3

% Part A
% See splane.m function

% Part B
fpass = 50000;
[z1,p1,k1] = cheby1(4,3,fpass*2*pi,'low','s');
[b1,a1] = zp2tf(z1,p1,k1);
[z2,p2,k2] = ellip(4,3,30,fpass*2*pi,'low','s');
[b2,a2] = zp2tf(z2,p2,k2);
% Half of an ellipse!

% Part C
figure;
subplot(2,1,1);
splane(z1,p1);
title("Chebyshev I Analog Filter");
xlabel("Real");
ylabel("jw");

subplot(2,1,2);
splane(z2,p2);
title("Elliptic Analog Filter");
xlabel("Real");
ylabel("jw");

% Part D & E
N = 1000;
[H1,w1] = freqs(b1, a1, N);
mag_H1 = 20*log10(abs(H1));
phase_H1 = unwrap(angle(H1))*180/pi;
f1 = w1 / (2000*pi);

[H2,w2] = freqs(b2, a2, N);
mag_H2 = 20*log10(abs(H2));
phase_H2 = unwrap(angle(H2))*180/pi;
f2 = w2 / (2000*pi);

figure;
subplot(2,1,1);
plot(f1,mag_H1);
hold on;
plot(f2,mag_H2);
title("Magnitude Response");
xlabel("Frequency (kHz)");
ylabel("Amplitude (dB)");
legend("Chebyshev", "Elliptical");

subplot(2,1,2);
plot(f1,phase_H1);
hold on;
plot(f2,phase_H2);
title("Phase Response");
xlabel("Frequency (kHz)");
ylabel("Phase (Degrees)");
legend("Chebyshev", "Elliptical");

% Part F
% Chebyshev I stopband edge frequency: 79.5247 kHz
% Elliptic stopband edge frequency: 57.3009 kHz
Compare1 = logical(mag_H1 < -30);
Index1 = find(Compare1 == 1);
ChebyshevIStopbandEdgeFrequency = f1(Index1(1))
Compare2 = logical(mag_H2 < -30);
Index2 = find(Compare2 == 1);
EllipticalStopbandEdgeFrequency = f2(Index2(1))
%%%
%%