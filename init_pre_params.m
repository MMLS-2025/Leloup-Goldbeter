function p0_array = init_pre_params()
    p0 = struct();
    p0.a = 10;
    p0.b = 4;
    p0.K_D = 2.5;
    p0.v_0 = 0.5;
    p0.v_1 = 5;
    p0.v_2 = 5;
    p0.k = 10;
    p0.V_MK = 8;
    p0.K_a = 2.5;
    p0.K_C = 0.3;
    p0.C_T = 1.1;

    p0_fields = {'a', 'b', 'K_D', 'v_0', 'v_1', 'v_2', 'k', 'V_MK', 'K_a', ...
                'K_C', 'C_T'};
    
    p0_array = zeros(length(p0_fields), 1);
    
    for i = 1:length(p0_fields)
        p0_array(i) = p0.(p0_fields{i});
    end
end