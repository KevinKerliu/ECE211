function [y] = dec(M,x)
y = x(1:M:length(x));
end

% Alternatively:
% y = x(1:M:end);