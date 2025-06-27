function period_distribution = period_peak_distribution(t_signal, signal_matrix)
    % 参数说明：
    % t_signal: 时间向量 (hours)
    % signal_matrix: t×100的矩阵，每列代表一个细胞的信号
    
    % 选择最后200小时的数据
    total_hours = t_signal(end) - t_signal(1);
    if total_hours >= 200
        start_idx = find(t_signal >= t_signal(end)-200, 1);
    else
        start_idx = 1;
        warning('总时长不足200小时，将分析全部数据');
    end
    
    t = t_signal(start_idx:end);
    signals = signal_matrix(start_idx:end, :);
    
    % 初始化存储周期
    all_periods = [];
    cell_labels = [];
    
    % 设置图形
    figure('Position', [100, 100, 1200, 800]);
    
    % 对每个细胞进行分析
    for cell_id = 1:size(signals, 2)
        y = signals(:, cell_id);
        
        % 寻找峰值 (调整MinPeakDistance参数以适应不同振荡周期)
        [~, locs] = findpeaks(y, 'MinPeakDistance', 10);
        
        if length(locs) >= 2
            peak_times = t(locs);
            periods = diff(peak_times);
            
            % 存储结果
            all_periods = [all_periods; periods];
            cell_labels = [cell_labels; repmat(cell_id, length(periods), 1)];
            
        end
    end
    
    % 绘制周期分布直方图
    histogram(all_periods, 'BinWidth', 0.5, 'Normalization', 'probability');
    xlabel('周期长度 (小时)');
    ylabel('出现概率');
    title(sprintf('100个细胞周期分布 (最后200小时)\n平均周期: %.2f±%.2f小时', ...
        mean(all_periods), std(all_periods)));
    grid on;
    
    % 返回周期数据
    period_distribution = struct(...
        'periods', all_periods, ...
        'cell_labels', cell_labels, ...
        'mean_period', mean(all_periods), ...
        'std_period', std(all_periods));
    
    fprintf('分析完成:\n');
    fprintf('总周期数: %d\n', length(all_periods));
    fprintf('平均周期: %.2f ± %.2f 小时\n', mean(all_periods), std(all_periods));
    fprintf('周期变异系数: %.2f%%\n', 100*std(all_periods)/mean(all_periods));
end