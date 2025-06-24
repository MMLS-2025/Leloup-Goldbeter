function y_all = init_y(N)
    y = struct();
    y.M_P = 0;
    y.M_C = 0;
    y.M_B = 0;
    
    y.P_C = 0;
    y.C_C = 0;
    y.P_CP = 0;
    y.C_CP = 0;
    
    y.PC_C = 0;
    y.PC_N = 0;
    y.PC_CP = 0;
    y.PC_NP = 0;
    
    y.B_C = 0;
    y.B_CP = 0;
    y.B_N = 0;
    y.B_NP = 0;
    
    y.I_N = 0;

    y.CB_P = 0;
    
    y_fields = {'M_P', 'M_C', 'M_B', 'P_C', 'C_C', 'P_CP', 'C_CP', ...
                'PC_C', 'PC_N', 'PC_CP', 'PC_NP', 'B_C', 'B_CP', ...
                'B_N', 'B_NP', 'I_N', 'CB_P'};
    
    y_array = zeros(length(y_fields), 1);
    
    for i = 1:length(y_fields)
        y_array(i) = y.(y_fields{i});
    end
    y_all = repmat(y_array, N, 1); 
end