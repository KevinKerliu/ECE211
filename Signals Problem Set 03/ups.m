function [y] = ups(M,x)
y = zeros(1,M*length(x));
y(1:M:leny) = x;
end