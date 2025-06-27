function [SI_t, theta] = SI(M_P, t)
% SI - 计算瞬时同步指数 SI(t)，基于波峰提取相位
%
% 输入：
%   M_P  - [T x N] 数组，每列为一个细胞的变量时间序列（如 Per mRNA）
%   t    - [T x 1] 时间向量，所有细胞共用统一时间轴
%
% 输出：
%   SI_t   - [T x 1] 向量，表示每个时间点的同步指数（0~1）
%   theta  - [T x N] 相位矩阵，单位为弧度 [0, 2π]，NaN 表示该时间点未定义

    [T, N] = size(M_P);
    
    if ~isequal(size(t), [T, 1])
        error('输入时间向量 t 必须是 [T x 1] 的列向量，且与 M_P 行数一致。');
    end

    theta = nan(T, N);  % 相位矩阵初始化

    % --- 为每个细胞提取相位 ---
    for j = 1:N
        signal = M_P(:, j);

        % 查找波峰位置
        [~, locs] = findpeaks(signal, t);

        % 至少需要两个波峰定义一个周期
        if length(locs) < 2
            continue;
        end

        % 在线性插值范围内定义相位
        for k = 1:length(locs)-1
            t1 = locs(k);
            t2 = locs(k+1);
            idx = t >= t1 & t <= t2;
            theta(idx, j) = 2 * pi * (t(idx) - t1) / (t2 - t1);
        end
    end

    % --- 计算 SI(t) ---
    SI_t = nan(T, 1);
    for i = 1:T
        phis = theta(i, :);
        if any(isnan(phis))
            continue;
        end
        SI_t(i) = abs(mean(exp(1i * phis)));
    end
end
