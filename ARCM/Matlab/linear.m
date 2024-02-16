function y = linear(E)

bound = 1;
y = zeros(size(E));

for i = 1:length(E)
    if E(i) > bound
        y(i) = bound;
    elseif E(i) < -bound
        y(i) = -bound;
    else
        y(i) = E(i);
    end
end

end