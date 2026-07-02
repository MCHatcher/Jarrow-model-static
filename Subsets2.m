%Find all subsets

n = 10;
x = 1:n; % Your input vector
numSubsets = 2^n; % Total number of subsets (2^n)

allSubsetsBin = cell(1, numSubsets); % Preallocate cell array

for i = 0:(numSubsets - 1)
    % Convert index to binary string, then to logical indices
    binaryString = dec2bin(i, n);
    % '0' converts char '0' to numeric 0, '1' to numeric 1
    indices = binaryString - '0'; % Logical array (e.g., [0 1 1])
    
    % Use logical indexing to get the subset
    allSubsetsBin{i+1} = x(logical(indices)); 
end

disp(allSubsetsBin);