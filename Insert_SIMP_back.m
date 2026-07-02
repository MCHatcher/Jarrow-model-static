% Insert_SIMP_back

if dum_sol ~= 1

    for k=k_init-1:-1:1

        set12 = k:K;

        Insert_first

        if dum_sol == 1 
            break 
        end

        Constrained_SIMP_main

        if dum_sol == 1 
            break 
        end

    end

end