%% Demo: collatzHunter
% Demonstrates how to use the collatzHunter function and some of its outputs

%% Scalar Positive Integer 

collatz1 = collatzHunter(223)

pause(1)

%% Range of Values (row vector)

collatz2 = collatzHunter([90 900])

pause(1)

%% Range of Values (column vector)

collatz3 = collatzHunter([60; 150])

pause(1)

%% Error Description (noninteger/nonpositive scalar)

collatz4 = collatzHunter(1.1)

pause(1)

collatz5 = collatzHunter(-3)

pause(1)

%% Error Description (tensor/1xn vector)

collatz6 = collatzHunter(cat(3,1,1,1))

pause(1)

collatz7 = collatzHunter([1 2 3])

pause(1)

%% Error Description (elements of vector are not positive integers)

collatz8 = collatzHunter([-1 2])

pause(1)

%% Error Description (vector elements are equal)

collatz9 = collatzHunter([10 10])

%% Note About the Definition of Degeneracy

% I define degeneracy as the point at which the Collatz sequence reaches
% the value 1, after which the sequence will loop between 4, 2, and 1
% forever. The number of iterations before degeneracy given in the first
% example and the values in the Iterations field of the output structures
% in the second and third examples are the number of iterations taken to 
% reach the value of 1 for the first time.