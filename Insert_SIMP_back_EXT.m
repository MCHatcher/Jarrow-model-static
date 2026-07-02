% Insert_SIMP_back_EXT

for k=k_init-1:-1:1

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
