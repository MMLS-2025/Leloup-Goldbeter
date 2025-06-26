function dydt = LG_VIP_total(t, y, p_0, p, N, epsilon, alpha, v_sP0, is_LD)
    % for N cells
    % each cell has 17 eqs, 56 params
    num_eq = 17;
    num_param = 56;
    dydt = zeros(num_eq*N, 1);
    
    % get M_P, each y(1)
    M_P = y(1:num_eq:end);

    % get CB_P, each y(17)
    CB_P = y(17:num_eq:end);
    
    % params that need previously
    a = p_0(1);
    b = p_0(2);
    K_D = p_0(3);
    v_0 = p_0(4);
    v_1 = p_0(5);
    v_2 = p_0(6);
    k = p_0(7);
    V_MK = p_0(8);
    K_a = p_0(9);
    K_C = p_0(10);
    C_T = p_0(11);
    CB_T = p(54);

    % if LD
    if is_LD
        if mod(t, 24) < 12
            delta = 1;
        else
            delta = 0;
        end
    else
        delta = 0;
    end

    rho = a .* M_P ./ (M_P + b);
    gamma = 1/epsilon .* (alpha * rho);
    beta = gamma ./ (K_D + gamma);
    Ca = (v_0 + v_1 .* beta + v_2 .* delta)./k;
    v_K = V_MK.*Ca./(K_a+Ca);

    lambda = CB_T.*CB_P./(K_C+CB_T.*CB_P);
    v_sP = v_sP0 + C_T.*lambda;

    for i = 1:N
        dydt(num_eq*(i-1)+1:num_eq*i) = ...
            LG_VIP(t, y(num_eq*(i-1)+1:num_eq*i), ...
            p(num_param*(i-1)+1:num_param*i), v_sP(i), v_K(i));
    end
end
