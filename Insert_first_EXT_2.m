% Insert_first_EXT_2

    Demands_opt = [];

    V_sum = sum(V(:,:,set12),3);
    EV_adj_sum = sum(E_weight(:,:,set12),3);

    P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

    for ind = set12
        Demands_opt(:,ind) = V(:,:,ind)*( EP_adj(:,ind) - P_guess );
    end

    min_opt = min(min(Demands_opt)); min_opt2 = min_opt;
    Diff = 1:k-1;

    if min_opt >= 0 && max(EP_adj(1,Diff)) < P_guess(1) && max(EP_adj(2,Diff)) < P_guess(2)
        Check = sum(Demands_opt,2) - N_bar;
        Demands = sum(Demands_opt,2);
        dum_sol = 1; dum_sol0 = 1;
        P_tild0 = P_guess;
    end

