function complete_routh(coeff_vector)
% Prints result after solving the Routh Hurwitz Stability 
% Criterion for given coefficient vector

degree = size(coeff_vector,2) - 1;

%Print the given characteristic equation
fprintf('\n Characteristic Equation\n=========================\n');
for i = 0:degree-1
    fprintf('%ds^%d + ', coeff_vector(i+1), degree-i);
end
fprintf('%d = 0\n', coeff_vector(degree+1));

%Make initial Routh Hurwitz table
routh_table = make_routh_table(coeff_vector);
len = size(routh_table,1);
bre = size(routh_table, 2);
last_row = routh_table(len,:);
nonzeros = find(last_row);

%Analyse the cases
if size(nonzeros,2) == 0
    %either all zero or complete Routh table made
    if len == degree + 2
        % complete Routh formed
        fprintf('\nComplete routh table has been formed. Checking for sign changes.\n\n');
    else
        % all elements are zero. Make auxiliary matrix
        fprintf('\nAll elements are zero. We should make auxiliary matrix.\n\n');
        pwr = degree - len + 2;
        for i = 1:bre-1
            routh_table(len, i) = routh_table(len-1, i)*pwr;
            pwr = pwr - 2;
        end
        routh_table = finish_incomplete_routh(routh_table, degree);
    end
else
    %First element is zero, not all are zero
    format long
    fprintf('\nFirst element is zero.');
    fprintf('We have to further solve using limits and then check for sign changes.\n\n');
    routh_table(len,1) = 0.000001;
    routh_table = finish_incomplete_routh(routh_table, degree);
end

% Display the routh table formed in a pretty format
fprintf(' Routh Table\n=============\n');
for i = 1:degree+1
    fprintf('S%d\t', degree + 1 - i);
    fprintf('%15.6f ', routh_table(i, :));
    fprintf('\n');
end

%Check for number of sign changes occurring in the first column
num_sign = num_sign_changes(routh_table);
fprintf('\nNumber of sign changes in First Column = %d\n', num_sign);

%Print the results
if num_sign ~= 0
    fprintf('\nAs the sign changes in the first column, the system is UNSTABLE\n');
else
    fprintf('\nAs there are no sign changes, the system is STABLE\n');
end

end
