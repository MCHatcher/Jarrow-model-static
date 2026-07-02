% Insert_2_EXT_2

Demands_opt = []; Demands_pes = [];

V_sum = sum(V(:,:,set12),3) + sum(V22(:,:,B22),3);
EV_adj_sum = sum(E_weight(:,:,set12),3) + sum(E_weight2(:,:,B22),3);

P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

    for ind = set12
        Demands_opt(:,ind) = V(:,:,ind)*( EP_adj(:,ind) - P_guess );
    end

min_opt = min(min(Demands_opt));

    for ind = B22
        Demands_pes(ind) = V(1,:,ind)*( EP_adj(:,ind) - P_guess );
    end

max_pes = max(Demands_pes);
min_22 = min(EP_adj(2,B22)); 

Diff = 1:m-1;
P_out = EP_adj(:,Diff) - P_guess;
max_out = max(max(P_out));

    if min_opt >= 0 && max_pes < 0 && min_22 >= P_guess(2) && max_out < 0 
        dum_sol = 1; dum_sol2 = 1;
        P_tild2 = P_guess;
    end
