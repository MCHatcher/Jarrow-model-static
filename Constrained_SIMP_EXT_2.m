%Constrained_SIMP_EXT_2.m

B11 = []; B22 = [];

for k=k_init:K

    set12 = k:K;

    Insert_first_EXT_2

    if dum_sol == 1 
        break 
    end

end

if dum_sol ~= 1

    for k=k_init:K

        set12 = k:K;

        Constrained_SIMP_main_EXT_2

        if dum_sol == 1 
            break 
        end

    end

end


if dum_sol ~= 1

    B11 = []; B22 = [];
    back = 1;
    Insert_SIMP_back_EXT_2

end