function alpha = spatial_weight(N)
    %   arranged in a square grid. N must be a perfect square.
    %
    %   The weight between two neurons i and j is defined as:
    %   - alpha(i,i) = 1 (self-connection)
    %   - alpha(i,j) = 1/d, where d is the Euclidean distance between neurons
    %
    %   Neurons are arranged in a square grid, with neuron 1 at top-left (1,1)
    %   and neuron N at bottom-right (sqrt(N), sqrt(N)).
    %   So for neuron 1~N, the coord is:
    %   Row = ceil(i/sqrt(N))
    %   Col = i - (Row-1) * sqrt(N)
    
    sqrtN = sqrt(N);
    if round(sqrtN) ~= sqrtN
        error('N must be a perfect square.');
    end
    
    alpha = zeros(N, N);
    
    coords = zeros(N, 2);
    for i = 1:N
        row = ceil(i/sqrtN);
        col = i - (row-1)*sqrtN;
        coords(i, :) = [row, col];
    end

    for i = 1:N
        for j = 1:N
            if i == j
                % Self-connection
                alpha(i, j) = 1;
            else
                % Calculate Euclidean distance between neurons i and j
                distance = norm(coords(i, :) - coords(j, :));
                
                % Weight is 1/distance
                alpha(i, j) = 1/distance;
            end
        end
    end
end