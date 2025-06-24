function p_array_flat = init_params(N, disturb_k)
    % 生成基础参数 p 为单细胞的默认值
    % disturb_k = 0.2 as default
    p = struct();
    p.k_1 = 0.4;
    p.k_2 = 0.2;
    p.k_3 = 0.4;
    p.k_4 = 0.2;
    p.k_5 = 0.4;
    p.k_6 = 0.2;
    p.k_7 = 0.5;
    p.k_8 = 0.1;
    p.K_AP = 0.7;
    p.K_AC = 0.6;
    p.K_IB = 2.2;
    p.k_dmb = 0.01;
    p.k_dmc = 0.01;
    p.k_dmp = 0.01;
    p.k_dn = 0.01;
    p.k_dnc = 0.12;
    p.K_d = 0.3;
    p.K_dp = 0.1;
    p.K_p = 0.1;
    p.K_mB = 0.4;
    p.K_mC = 0.4;
    p.K_mP = 0.31;
    p.k_sB = 0.12;
    p.k_sC = 1.6;
    p.k_sP = 0.6;
    p.m = 2;
    p.n = 4;
    p.V_1B = 0.5;
    p.V_1C = 0.6;
    p.V_1P = 0.4;
    p.V_1PC = 0.4;
    p.V_2B = 0.1;
    p.V_2C = 0.1;
    p.V_2P = 0.3;
    p.V_2PC = 0.1;
    p.V_3B = 0.5;
    p.V_3PC = 0.4;
    p.V_4B = 0.2;
    p.V_4PC = 0.1;
    p.V_phos = 0.4;
    p.v_dBC = 0.5;
    p.v_dBN = 0.6;
    p.v_dCC = 0.7;
    p.v_dIN = 0.8;
    p.v_dPC = 0.7;
    p.v_dPCC = 0.7;
    p.v_dPCN = 0.7;
    p.v_mB = 0.8;
    p.v_mC = 1.0;
    p.v_mP = 1.1;
    p.v_sB = 1.0;
    p.v_sC = 1.1;
    % new
    p.v_P = 1;
    p.CB_T = 1;
    p.K_1 = 0.01;
    p.K_2 = 0.01;

    p_fields = {...
        'k_1', 'k_2', 'k_3', 'k_4', 'k_5', 'k_6', 'k_7', 'k_8', ...
        'K_AP', 'K_AC', 'K_IB', 'k_dmb', 'k_dmc', 'k_dmp', 'k_dn', 'k_dnc', ...
        'K_d', 'K_dp', 'K_p', 'K_mB', 'K_mC', 'K_mP', 'k_sB', 'k_sC', ...
        'k_sP', 'm', 'n', 'V_1B', 'V_1C', 'V_1P', 'V_1PC', 'V_2B', ...
        'V_2C', 'V_2P', 'V_2PC', 'V_3B', 'V_3PC', 'V_4B', 'V_4PC', 'V_phos', ...
        'v_dBC', 'v_dBN', 'v_dCC', 'v_dIN', 'v_dPC', 'v_dPCC', 'v_dPCN', ...
        'v_mB', 'v_mC', 'v_mP', 'v_sB', 'v_sC', 'v_P', 'CB_T', 'K_1', 'K_2'};

    num_fields = length(p_fields);
    p_base = zeros(1, num_fields);
    for i = 1:num_fields
        p_base(i) = p.(p_fields{i});
    end

    % 为 N 个细胞生成参数矩阵 (num_fields x N)
    p_array_all = zeros(num_fields, N);

    % 仅对 k_1 ~ k_8 (对应 p_fields 中前 8 个) 做随机扰动
    % 标准差 = 平均值的 disturb 比例，采用正态分布 (randn)
    for cell_index = 1:N
        % 先拷贝基础值
        p_array_all(:, cell_index) = p_base;

        for j = 1:8
            avg_val = p_base(j);
            std_dev = disturb_k * avg_val;
            perturbed = avg_val + std_dev * randn(1);
            p_array_all(j, cell_index) = perturbed;
        end
    end
    p_array_flat = p_array_all(:);
end