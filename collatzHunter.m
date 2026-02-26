% collatzHunter.m
%
% Plots Collatz sequences of single positive integer values or outputs data
% for multiple sequences in a structure array
%
% Functionality:
%    - calculates and plots Collatz sequences of single values
%    - gives text description of Collatz sequences of single values
%    - calculates maximum values, total iterations, etc for ranges of values
%    - describes errors when input syntax is not correct
%    - reports total amount of time for calculations
%
% Author: Nehemiah Chavers

function collatz = collatzHunter(range)

tic % Begin timekeeping

[rows, cols, rank] = size(range);

% Prevents function from accepting matrices or tensors as inputs

if rows > 2 || cols > 2 || rank > 1

    collatz = sprintf('Input must be a 1x2 or 2x1 vector, or a scalar.');

else

    % Process for single value

    if isscalar(range) && mod(range, 1) == 0 && range >= 1 % Ensures that inputs are positive integer scalars
    
        num = range;
    
        iterations = 0;
    
        iterationNum = [];
    
        vals = [];
    
            while num ~= 1 % Prevents infinite loop once num reaches 4, 2, 1 loop

                % Logs iterations and values for even case
    
                if mod(num,2) == 0
    
                    num = num/2;
    
                    iterations = iterations + 1;
    
                    iterationNum = [iterationNum iterations];
    
                    vals = [vals num];

                % Logs iterations and values for odd case
    
                elseif mod(num,2) == 1
    
                    num = (num*3) + 1;
    
                    iterations = iterations + 1;
    
                    iterationNum = [iterationNum iterations];
    
                    vals = [vals num];
    
                end
    
            end

        % Concatenate with zero to plot initial starting value of sequence
    
        iterationNum = [0 iterationNum];

        % Concatenate with original input to plot initial value of sequence
    
        vals = [range vals];

        % Find highest value of sequence
    
        [s,i] = max(vals);

        % Find total number of iterations before degeneracy
    
        highestIter = max(iterationNum);

        % Index out iteration at which highest sequence value occurs
    
        maxIter = iterationNum(i);

        % Special case when input scalar is 4, 2, or 1
    
        if range == 4 || range <= 2
    
            collatz = sprintf('The chosen input value, %d, already exists in the 4, 2, 1 infinite loop, so the maximum value of its Collatz sequence is 4 and it begins to degenerate immediately.', range);

        % Description of sequence (maximum value, total iterations before
        % degeneracy, and iteration number at which max value occurs)
    
        else, collatz = sprintf('The maximum value in the Collatz sequence of %d is %d, and occurs at iteration %d. The total number of iterations before degeneracy is %d.', range, s, maxIter, highestIter);

        end

        % Plot sequence values against iterations
    
        figure
        
        plot(iterationNum, vals, 'r-o')
         
        xlabel('Iterations')
        
        ylabel('Values')
        
        title(sprintf('Collatz Sequence for the Number %d', range))

    % Process for range of values
    
    elseif ~isscalar(range) && min(range) >= 1 && mod(range(1),1) == 0 && mod(range(2),1) == 0 && range(1) < range(2) % Ensures all tested values are positive integers and value range is valid

        % Create vector of test values

        A = range(1):range(2);

        % Preallocate structure array for speed

        C = struct('Values', cell(1,length(A)), 'Iterations', cell(1,length(A)), 'MaxVals', cell(1,length(A)), 'MaxValIters', cell(1,length(A)));

        for k = 1:length(A)
            
            iterations = 0;
    
            iterationNum = [];
    
            vals = [];

            num = A(k);

            while num ~= 1 % Prevents infinite loop once sequence reaches 4, 2, 1 loop

                % Log iterations and sequence values for odd case
    
                 if mod(num,2) == 0
            
                     num = num/2;
            
                     iterations = iterations + 1;
    
                     iterationNum = [iterationNum iterations];
        
                     vals = [vals num];

                 % Lot iterations and sequence values for odd case
    
                 elseif mod(num,2) == 1
            
                     num = (num*3) + 1;
            
                     iterations = iterations + 1;
    
                     iterationNum = [iterationNum iterations];
        
                     vals = [vals num];
            
                 end
    
            end

            % Concatenate with zero in case max val is the initial value

            iterationNum = [0 iterationNum];

            % Concatenate with inital starting value in case it is the max val
        
            vals = [A(k) vals];

            % Find max value of sequence
        
            [s,i] = max(vals);

            % Find total number of iterations for each tested value
        
            highestIter = max(iterationNum);

            % Index out iteration at which max val occurs
        
            maxIter = iterationNum(i);

            % Place desired values in structure array
    
            C(k).Values = A(k); % Tested values in input range
    
            C(k).Iterations = highestIter; % Total iterations for each tested value
    
            C(k).MaxVals = s; % Maximum value in sequence for each tested value
    
            C(k).MaxValIters = maxIter; % Iteration at which max val occurs for each tested value

        end

        collatz = C;

    % Descriptions of errors when input syntax is not correct or valid

    elseif isscalar(range) && (mod(range,1) > 0 || range < 1)

        % Description when input is scalar and not a positive integer

        collatz = sprintf('The Collatz conjecture only applies to positive integer values. Change your input value to meet this condition.');

    elseif ~isscalar(range) && rank == 1 && (rows > 1 || cols > 1) && ((mod(range(1),1) > 0 || mod(range(2),1) > 0) || (range(1) <= 0 || range(2) <= 0))

        % Description when input is an nx1 or 1xn vector, or the elements of
        % the input vector are not positive integers

        collatz = sprintf('The elements of input vectors must be positive integers. Change your input to meet this condition.');

        % Description when the first element of the input vector is less
        % than the second element

    elseif ~isscalar(range) && rank == 1 && rows <= 2 && cols <= 2 && range(1) > range(2)

        collatz = sprintf('For ranges of values, the first element of the input vector must be less than the second element.');

    elseif ~isscalar(range) && range(1) == range(2)

        % Description when both input elements are equal

        collatz = sprintf('In order to use this function for single integer values, use a scalar value for the input.');
    
    end

end

toc % End timekeeping

end