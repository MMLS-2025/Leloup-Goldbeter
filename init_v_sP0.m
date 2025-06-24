function v_sP0_array = init_v_sP0(N, disturb_v)
    % disturb_v = 0.1 as default
    v_sP0 = 1.02;
    std_dev = disturb_v * v_sP0;
    v_sP0_array = v_sP0 + std_dev * randn(N,1);
end