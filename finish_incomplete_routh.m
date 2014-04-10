function [ routh_table ] = finish_incomplete_routh( routh_table, degree)
% This function completes the incomplete routh table
% provided
len = size(routh_table, 1);
bre = size(routh_table, 2);
divisor = routh_table(len,1);
x = routh_table(len-1,:);
y = routh_table(len,:);
z = zeros(1, bre);
j = 1;
while divisor
    for i = 1:bre-1
        a1 = x(1);
        a2 = x(1+i);
        b1 = y(1);
        b2 = y(1+i);
        c = (b1*a2 - b2*a1)/divisor;
        c(c<0.00000001 & c>-0.00000001) = 0; %eliminate negative zeros
        z(1,i) = c;
    end
    routh_table(len+j,:) = z;
    x = y;
    y = z;
    divisor = y(1,1);
    j = j+1;
end

end
