function ddqlimit = qLimit(ddq)

len = length(ddq);
ddqLimit = 0.85;
ddqlimit = ddq;
for i=1:len
    if abs(ddq(i)) > ddqLimit
        ddqlimit(i) = abs(ddq(i))/ddq(i) * ddqLimit;
    end
end


end
