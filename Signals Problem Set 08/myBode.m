%% SECTION TITLE
% DESCRIPTIVE TEXT
function myBode(Q)
% H(w) = (Wn^2) / ((1j*w)^2 + (Wn/Q)*(1j*w) + (Wn^2))
% Clearly |H(0)| = 1, so 20*log10(|H(0)|) = 0
Wn = 1;
w_range = logspace(-1, 1);
b = [0, 0, (Wn)^2];
a = [1, (Wn/Q), (Wn)^2];
H = freqs(b, a, w_range);
magH = 20*log10(abs(H));
figure;
semilogx(w_range,magH);
title(["Bode Plot, Q = ", num2str(Q)]);
xlabel("Frequency (rad/sec)");
ylabel("Magnitude (dB)");
grid on;
hold on;
plot([.1, 1, 10],[0, 0, -40]);
legend("Actual Magnitude Response", "Predicted Magnitude Response");

w_compare = [0.1*Wn, 0.5*Wn, Wn, 2*Wn, 10*Wn];
H_actual = freqs(b, a, w_compare);
H_actual = 20*log10(abs(H_actual));
H_predicted = [0, 0, 0, -12, -40];
w_compare_label = ["One Decade Below Corner","One Octave Below Corner", ...
    "At Corner","One Octave Above Corner","One Decade Above Corner"];
headings = {'Frequencies','Actual_Magnitude_Reponse','Predicted_Magnitude_Response'};
table1 = table(w_compare_label.', H_actual.', H_predicted.', ...
    'VariableNames', headings)


end

