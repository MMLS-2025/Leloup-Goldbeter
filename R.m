function R_t = R(X)
% compute_order_parameter - 计算秩序参数 R（同步性度量）
%
% 输入：
%   X : [T x N] 实数矩阵，每列是一个细胞在 T 个时间点上的变量（如 M_P）
%
% 输出：
%   R : 秩序参数（0~1），衡量整个时间段内的整体同步性

    [T, N] = size(X);

    % 时间平均：每个细胞
    mean_Xi = mean(X, 1);             % ⟨X_i⟩，1 x N
    mean_Xi2 = mean(X.^2, 1);         % ⟨X_i^2⟩，1 x N

    % 分子：⟨X^2⟩ - ⟨X̄⟩^2
    mean_Xbar = mean(mean(X, 2));     % ⟨X̄⟩，先在空间上平均，再对时间平均
    mean_X2 = mean(mean(X, 2).^2);    % ⟨X̄^2⟩
    numerator = mean_X2 - mean_Xbar^2;

    % 分母：1/N ∑ (⟨X_i^2⟩ - ⟨X_i⟩^2)
    denominator = mean(mean_Xi2 - mean_Xi.^2);

    % R 值
    R_t = numerator / denominator;
end
