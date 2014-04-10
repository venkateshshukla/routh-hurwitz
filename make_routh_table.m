function [routh_table] = make_routh_table( coeff_vector )
% Given a vector of coefficients, a matrix of routh table
% is returned.
len = size(coeff_vector,2);
degree = len - 1;
x = coeff_vector(1,1:2:len);
y = coeff_vector(1,2:2:len);
if mod(degree,2) == 0              %Even degree. Have to add a 0 at the end
    y(1,ceil(len/2)) = 0;
end
routh_table(1,:) = x;
routh_table(2,:) = y;
routh_table = finish_incomplete_routh(routh_table, degree);
end
