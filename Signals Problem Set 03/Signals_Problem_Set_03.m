% ECE211 Problem Set 03
% Kevin Kerliu
clear;
close all;
clc;
%%
%%%

% Question 2

h2 = [2,3,4,2,5];
h2_start_time = -1;
h2_length = 5;
% support(h) = {-1 <= n <= 3}
h2_time = h2_start_time:(h2_start_time + h2_length - 1);

x2 = [3,4,5,1,2];
x2_start_time = -2;
x2_length = 5;
% support(x) = {-2 <= n <= 2}
x2_time = x2_start_time:(x2_start_time + x2_length - 1);


figure;
stem(h2_time,h2);
title("Discrete-Time Signal h[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-2 4]);
set(gca, 'YLim', [0 6]);

figure;
stem(x2_time,x2);
title("Discrete-Time Signal x[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-3 3]);
set(gca, 'YLim', [0 6]);

y2 = conv(h2,x2);
% support(y) = {-3 <= n <= 5}
y2_start_time = h2_time(1)+x2_time(1);
y2_end_time = h2_time(end)+x2_time(end);
y2_time = y2_start_time:y2_end_time;

figure;
subplot(2,2,1);
stem(h2_time,h2);
title("Discrete-Time Signal h[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-2 4]);
set(gca, 'YLim', [0 6]);

subplot(2,2,2);
stem(x2_time,x2);
title("Discrete-Time Signal x[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-3 3]);
set(gca, 'YLim', [0 6]);

subplot(2,2,[3,4]);
stem(y2_time,y2);
title("Discrete-Time Signal y[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-4 6]);
set(gca, 'YLim', [0 60]);

%%%
%%
%%%

% Question 3

% PART A

% SEE dec.m AND ups.m

% PART B

universal_start_time = 0;

g3 = [2,1,3,4];
g3_length = 4;
g3_time = universal_start_time:(universal_start_time + g3_length - 1);

h3 = ups(4, g3);
h3_length = 16;
h3_time = universal_start_time:(universal_start_time + h3_length - 1);

x3 = randi([-2 2], 1, 10);
x3_length = 10;
x3_time = universal_start_time:(universal_start_time + x3_length - 1);

figure;
subplot(2,2,1);
stem(g3_time,g3);
title("Discrete-Time Signal g[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 4]);
set(gca, 'YLim', [0 5]);

subplot(2,2,2);
stem(h3_time,h3);
title("Discrete-Time Signal h[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 16]);
set(gca, 'YLim', [0 5]);

subplot(2,2,[3,4]);
stem(x3_time,x3);
title("Discrete-Time Signal x[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 10]);
set(gca, 'YLim', [-3 3]);

% PART C

x3_ups_then_dec = dec(4,ups(4,x3));
x3_dec_then_ups = ups(4,dec(4,x3));

figure;
subplot(2,2,[1,2]);
stem(x3_time, x3_ups_then_dec);
title("Discrete-Time Signal x ups/dec[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 10]);
set(gca, 'YLim', [-3 3]);

subplot(2,2,[3,4]);
stem(0:length(x3_dec_then_ups)-1, x3_dec_then_ups);
title("Discrete-Time Signal x dec/ups[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 10]);
set(gca, 'YLim', [-3 3]);

% PART D

d1 = dec(4,conv(h3,x3));
d2 = conv(g3,dec(4,x3));

figure;
subplot(2,2,[1,2]);
stem(0:length(d1)-1, d1);
title("Discrete-Time Signal d1[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 6]);
set(gca, 'YLim', [-6 6]);

subplot(2,2,[3,4]);
stem(0:length(d2)-1, d2);
title("Discrete-Time Signal d2[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 6]);
set(gca, 'YLim', [-6 6]);

% PART E

u1 = conv(h3,ups(4,x3));
u2 = ups(4,conv(g3,x3));

figure;
subplot(2,2,[1,2]);
stem(0:length(u1)-1, u1);
title("Discrete-Time Signal u1[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 52]);
set(gca, 'YLim', [-15 15]);

subplot(2,2,[3,4]);
stem(0:length(u2)-1, u2);
title("Discrete-Time Signal u2[n]");
xlabel("Time (n)");
ylabel("Voltage (V)");
set(gca, 'XLim', [-1 52]);
set(gca, 'YLim', [-15 15]);

%%%
%%