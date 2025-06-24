function dydt = LG_light(t, y, p)
    dydt = zeros(16, 1);

    M_P = y(1);
    M_C = y(2);
    M_B = y(3);

    P_C = y(4);
    C_C = y(5);
    P_CP = y(6);
    C_CP = y(7);

    PC_C = y(8);
    PC_N = y(9);
    PC_CP = y(10);
    PC_NP = y(11);

    B_C = y(12);
    B_CP = y(13);
    B_N = y(14);
    B_NP = y(15);
    
    I_N = y(16);

    k_1 = p(1);
    k_2 = p(2);
    k_3 = p(3);
    k_4 = p(4);
    k_5 = p(5);
    k_6 = p(6);
    k_7 = p(7);
    k_8 = p(8);
    K_AP = p(9);
    K_AC = p(10);
    K_IB = p(11);
    k_dmb = p(12);
    k_dmc = p(13);
    k_dmp = p(14);
    k_dn = p(15);
    k_dnc = p(16);
    K_d = p(17);
    K_dp = p(18);
    K_p = p(19);
    K_mB = p(20);
    K_mC = p(21);
    K_mP = p(22);
    k_sB = p(23);
    k_sC = p(24);
    k_sP = p(25);
    m = p(26);
    n = p(27);
    V_1B = p(28);
    V_1C = p(29);
    V_1P = p(30);
    V_1PC = p(31);
    V_2B = p(32);
    V_2C = p(33);
    V_2P = p(34);
    V_2PC = p(35);
    V_3B = p(36);
    V_3PC = p(37);
    V_4B = p(38);
    V_4PC = p(39);
    V_phos = p(40);
    v_dBC = p(41);
    v_dBN = p(42);
    v_dCC = p(43);
    v_dIN = p(44);
    v_dPC = p(45);
    v_dPCC = p(46);
    v_dPCN = p(47);
    v_mB = p(48);
    v_mC = p(49);
    v_mP = p(50);
    v_sB = p(51);
    v_sC = p(52);

    if (t<420 && mod(t, 24) < 12) || (t>=420 && mod(t-3, 24) < 12)
        v_sP = p(54);   % Light phase
    else
        v_sP = p(53);   % Dark phase
    end

    dydt(1) = v_sP*(B_N^n)/(K_AP^n + B_N^n) - v_mP*M_P/(K_mP + M_P) - k_dmp*M_P;

    % dM_C
    dydt(2) = v_sC*(B_N^n)/(K_AC^n + B_N^n) - v_mC*M_C/(K_mC + M_C) - k_dmc*M_C;
    % dM_B
    dydt(3) = v_sB*(K_IB^m)/(K_IB^m + B_N^m) - v_mB*M_B/(K_mB + M_B) - k_dmb*M_B;

    % dP_C
    dydt(4) = k_sP*M_P - V_1P*P_C/(K_p + P_C) + V_2P*P_CP/(K_dp + P_CP) + k_4*PC_C - k_3*P_C*C_C - k_dn*P_C;
    % dC_C
    dydt(5) = k_sC*M_C - V_1C*C_C/(K_p + C_C) + V_2C*C_CP/(K_dp + C_CP) + k_4*PC_C - k_3*P_C*C_C - k_dnc*C_C;
    % dP_CP
    dydt(6) = V_1P*P_C/(K_p + P_C) - V_2P*P_CP/(K_dp + P_CP) - v_dPC*P_CP/(K_d + P_CP) - k_dn*P_CP;
    % dC_CP
    dydt(7) = V_1C*C_C/(K_p + C_C) - V_2C*C_CP/(K_dp + C_CP) - v_dCC*C_CP/(K_d + C_CP) - k_dn*C_CP;

    % dPC_C
    dydt(8) = -V_1PC*PC_C/(K_p + PC_C) + V_2PC*PC_CP/(K_dp + PC_CP) - k_4*PC_C + k_3*P_C*C_C + k_2*PC_N - k_1*PC_C - k_dn*PC_C;
    % dPC_N
    dydt(9) = -V_3PC*PC_N/(K_p + PC_N) + V_4PC*PC_NP/(K_dp + PC_NP) - k_2*PC_N + k_1*PC_C - k_7*B_N*PC_N + k_8*I_N - k_dn*PC_N;
    % dPC_CP
    dydt(10) = V_1PC*PC_C/(K_p + PC_C) - V_2PC*PC_CP/(K_dp + PC_CP) - v_dPCC*PC_CP/(K_d +PC_CP) - k_dn*PC_CP;
    % dPC_NP
    dydt(11) = V_3PC*PC_N/(K_p + PC_N) - V_4PC*PC_NP/(K_dp + PC_NP) - v_dPCN*PC_NP/(K_d + PC_NP) - k_dn*PC_NP;

    % dB_C
    dydt(12) = k_sB*M_B - V_1B*B_C/(K_p + B_C) + V_2B*B_CP/(K_dp + B_CP) - k_5*B_C + k_6*B_N - k_dn*B_C;
    % dB_CP
    dydt(13) = V_1B*B_C/(K_p + B_C) - V_2B*B_CP/(K_dp + B_CP) - v_dBC*B_CP/(K_d + B_CP) - k_dn*B_CP;
    % dB_N
    dydt(14) = -V_3B*B_N/(K_p + B_N) + V_4B*B_NP/(K_dp + B_NP) + k_5*B_C - k_6*B_N - k_7*B_N*PC_N + k_8*I_N - k_dn*B_N;
    % dB_NP
    dydt(15) = V_3B*B_N/(K_p + B_N) - V_4B*B_NP/(K_dp + B_NP) - v_dBN*B_NP/(K_d +B_NP) - k_dn*B_NP;

    % dI_N
    dydt(16) = -k_8*I_N + k_7*B_N*PC_N - v_dIN*I_N/(K_d + I_N) - k_dn*I_N;

end