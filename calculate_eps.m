function epsilon = calculate_eps(N, alpha)
    epsilon = N * mean(alpha(:));
end