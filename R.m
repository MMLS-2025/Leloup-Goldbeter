function R = R(X, t)
% R - 计算秩序参数 R，衡量变量 X 的整体同步性
%
% 输入：
%   X - [T x N] 的变量矩阵（每列是一个细胞的时序数据）
%   t - [T x 1] 的列向量，共用的时间轴（单位：小时）
%
% 输出：
%   R - 秩序参数（标量），取值范围 [0, 1]
%       R ≈ 1 表示强同步，R ≈ 0 表示完全失步

    [T, N] = size(X);
    
    if ~isequal(size(t), [T, 1])
        error('时间向量 t 应为 [T x 1] 的列向量，且与 X 行数一致');
    end

    % Step 1: 每个细胞的时间平均和平方平均（⟨X_j⟩ 和 ⟨X_j²⟩）
    mean_Xj  = trapz(t, X) ./ (t(end) - t(1));        % [1 x N]
    mean_Xj2 = trapz(t, X.^2) ./ (t(end) - t(1));     % [1 x N]

    % Step 2: 每个时间点全体细胞的平均值 X̄(t)
    X_bar = mean(X, 2);  % [T x 1]

    % Step 3: X̄(t) 的时间平均和平方平均
    mean_Xbar  = trapz(t, X_bar)      / (t(end) - t(1));  % 标量
    mean_Xbar2 = trapz(t, X_bar.^2)   / (t(end) - t(1));  % 标量

    % Step 4: R 值计算
    numerator   = mean_Xbar2 - mean_Xbar^2;
    denominator = mean(mean_Xj2 - mean_Xj.^2);

    R = numerator / denominator;

    % 避免除以 0 的情况
    if isnan(R) || isinf(R)
        R = 0;
    end
end
