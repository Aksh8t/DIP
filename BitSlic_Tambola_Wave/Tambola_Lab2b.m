clc;
clear;
close all;

% STEP 1: Decide how many numbers each column will have (1–3)
% Total numbers must be exactly 15

valid = false;

while ~valid
    % Randomly assign 1–3 numbers per column
    col_counts = randi([1 3], 1, 9);

    % Total numbers must be exactly 15
    if sum(col_counts) == 15
        valid = true;
    end
end

% STEP 2: Create empty ticket
ticket = zeros(3,9);

% STEP 3: Define number ranges for each column
ranges = {1:9, 10:19, 20:29, 30:39, 40:49, ...
          50:59, 60:69, 70:79, 80:90};

% STEP 4: Decide row positions (each row must have exactly 5 numbers)

row_counts = zeros(1,3);   % count numbers per row

for col = 1:9
    k = col_counts(col);   % how many numbers in this column

    % Find rows that still have space (<5 numbers)
    available_rows = find(row_counts < 5);

    % Randomly choose k rows from available ones
    perm = randperm(length(available_rows), k);
    chosen_rows = available_rows(perm);

    % Mark positions as 1 temporarily
    ticket(chosen_rows, col) = -1;

    % Update row counts
    for r = chosen_rows
        row_counts(r) = row_counts(r) + 1;
    end
end

% STEP 5: Fill numbers column-wise (top to bottom increasing)

for col = 1:9
    rows = find(ticket(:,col) == -1);   % rows to fill
    k = length(rows);

    % Pick k random numbers from the column range
    range_vals = ranges{col};
    perm = randperm(length(range_vals), k);
    nums = sort(range_vals(perm));      % sort for top-to-bottom order

    % Assign numbers
    ticket(rows, col) = nums;
end

% STEP 6: Display ticket
disp('Valid Tambola Ticket:');
disp(ticket);
