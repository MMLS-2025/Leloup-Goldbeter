function avg_period = period_peak(t_signal, signal)
    % 选择稳定区域
    start_idx = floor(length(t_signal)/4 * 3);
    t = t_signal(start_idx:end);
    y = signal(start_idx:end);
    
    % 寻找峰值
    [~, locs] = findpeaks(y, 'MinPeakDistance', 10); % 峰值间最小距离需调整
    
    % 计算相邻峰值之间的时间间隔
    if length(locs) > 1
        peak_times = t(locs);
        periods = diff(peak_times);
        avg_period = mean(periods);
        
        % 绘制峰值检测结果
        figure;
        plot(t, y);
        hold on;
        plot(t(locs), y(locs), 'ro');
        xlabel('Time (h)');
        ylabel('Signal');
        title('峰值检测法');
        grid on;
        
        for i = 1:length(periods)
            text(peak_times(i), y(locs(i)), ['\downarrow ' num2str(periods(i), '%.2f') 'h'], ...
                 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
        end
        
        fprintf('峰值检测结果：平均振荡周期为 %.2f 小时\n', avg_period);
    else
        fprintf('未检测到足够的峰值，请调整峰值检测参数。\n');
    end
end