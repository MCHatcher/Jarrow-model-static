%Constrained_SIMP_EXT.m

B11 = []; B22 = [];

for k=k_init:K

    set12 = k:K;

    Insert_first_EXT

    if dum_sol == 1 
        break 
    end

    Constrained_SIMP_main_EXT

    if dum_sol == 1 
        break 
    end

end


if dum_sol ~= 1

    back = 1;
    Insert_SIMP_back_EXT

end