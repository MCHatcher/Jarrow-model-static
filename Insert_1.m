% Insert_1

EV_adj_sum = V_bar*[ sum(EP_adj(1,set12)); sum(EP_adj(2,set12)) ] + V11*[ sum(EP_adj(1,B11)); sum(EP_adj(2,B11)) ];
V_sum = length(set12)*V_bar + length(B11)*V11;
                
P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

Demands_opt = V_bar*( EP_adj(:,set12) - P_guess );
min_opt = min(min(Demands_opt));

Diff = 1:m-1;
P_out = EP_adj(:,Diff) - P_guess;
max_out = max(max(P_out));

Demands_pes = V_bar*( EP_adj(:,B11) - P_guess );
max_pes = max(Demands_pes(2,:));

min_11 = min(EP_adj(1,B11));  

    if min_opt >= 0 && max_pes < 0 && min_11 >= P_guess(1) && max_out <0
        Check1 = sum(Demands_opt,2) + V11*sum(EP_adj(:,B11)-P_guess,2) - N_bar;
        dum_sol = 1; dum_sol1 = 1;
        P_tild1 = P_guess;
    end