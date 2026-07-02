% Insert_1_EXT_2

Demands_opt = []; Demands_pes = [];

V_sum = sum(V(:,:,set12),3) + sum(V11(:,:,B11),3);
EV_adj_sum = sum(E_weight(:,:,set12),3) + sum(E_weight1(:,:,B11),3);

P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

    for ind = set12
        Demands_opt(:,ind) = V(:,:,ind)*( EP_adj(:,ind) - P_guess );
    end

min_opt = min(min(Demands_opt));

    for ind = B11
        Demands_pes(ind) = V(2,:,ind)*( EP_adj(:,ind) - P_guess );
    end

Diff = 1:m-1;
P_out = EP_adj(:,Diff) - P_guess;
max_out = max(max(P_out));

max_pes = max(Demands_pes);
min_11 = min(EP_adj(1,B11));

    if min_opt >= 0 && max_pes < 0 && min_11 >= P_guess(1) && max_out <0 
        dum_sol = 1; dum_sol1 = 1;
        P_tild1 = P_guess;
    end

