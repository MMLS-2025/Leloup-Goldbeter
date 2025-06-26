function [SI_t, theta] = SI(M_P)
% compute_synchronization_index - 计算每个时间点的同步指数 SI(t)
%
% 输入：
%   M_P   - 一个 [T x N] 的实数矩阵，T 是时间点数，N 是细胞数，
%           每列对应一个细胞的 Per mRNA 表达随时间变化的轨迹
%
% 输出：
%   SI_t  - 一个长度为 T 的向量，对应每个时间点的同步指数（取值 0~1）
%   theta - 一个 [T x N] 的相位矩阵，每个元素为对应细胞的瞬时相位（单位：弧度）

    % 检查输入维度
    [T, N] = size(M_P);

    % 初始化相位矩阵
    theta = zeros(T, N);

    % 对每个细胞应用希尔伯特变换以提取相位
    for j = 1:N
        analytic_signal = hilbert(M_P(:, j));
        theta(:, j) = angle(analytic_signal);  % 提取相位
    end

    % 计算每个时间点的同步指数
    SI_t = abs(mean(exp(1i * theta), 2));  % 按行计算平均相量模长

end

