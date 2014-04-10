function [ count ] = num_sign_changes(routh_table)
% Returns the number of sign changes in the first column of the routh table
f_column = routh_table(:,1);
f_column = sign(f_column(1:size(f_column,1)-1));
len = size(f_column,1);
count = 0;
current = f_column(1);
for i = 1:len
    next = f_column(i);
    if current ~= next
        count = count+1;
    end
    current = next;
end
end
