%Find all subsets

n = 10;
x = 1:n; % Your input vector
allSubsets = {}; % Initialize an empty cell array to store subsets

% Include the empty set
allSubsets{1} = []; 

% Loop through sizes from 1 to n
for k = 1:n
    % Get all combinations of size k
    kCombinations = nchoosek(x, k); 
    
    % Add these combinations to the cell array (each row is a subset)
    for i = 1:size(kCombinations, 1)
        allSubsets{end+1} = kCombinations(i, :); 
    end
end

% Display the results (optional, each cell is a subset)
disp(allSubsets); 