
function avgPathLength = averagePathLength(AU)
% Computes average Shortest Path Length in a graph
% Author: Fatemeh Delavari 
% Version: 1.0

A = AU + AU' - diag(diag(AU)); % Convert the upper diagonal adjacency matrix to a symmetric adjacency matrix

    n = size(A, 1); % Number of vertices

    % Initialize distance matrix with infinity and 0 for diagonal
    dist = inf(n, n);
    for i = 1:n
        dist(i, i) = 0;
        for j = 1:n
            if A(i, j) ~= 0
                dist(i, j) = A(i, j);
            end
        end
    end

    % Floyd-Warshall Algorithm
    for k = 1:n
        for i = 1:n
            for j = 1:n
                if dist(i, k) + dist(k, j) < dist(i, j)
                    dist(i, j) = dist(i, k) + dist(k, j);
                end
            end
        end
    end

    % Calculate the average shortest path length
    avgPathLength = sum(sum(dist(~isinf(dist)))) / (n * (n - 1));
end
