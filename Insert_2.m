% Insert_2

EV_adj_sum = V_bar*[ sum(EP_adj(1,set12)); sum(EP_adj(2,set12)) ] + V22*[ sum(EP_adj(1,B22)); sum(EP_adj(2,B22)) ];
V_sum = length(set12)*V_bar + length(B22)*V22;
                
P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

Demands_opt = V_bar*( EP_adj(:,set12) - P_guess );
min_opt = min(min(Demands_opt));

Diff = 1:m-1;
P_out = EP_adj(:,Diff) - P_guess;
max_out = max(max(P_out));

Demands_pes = V_bar*( EP_adj(:,B22) - P_guess );
max_pes = max(Demands_pes(1,:));

min_22 = min(EP_adj(2,B22)); 

    if min_opt >= 0 && max_pes < 0 && min_22 >= P_guess(2) && max_out <0
        Check2 = sum(Demands_opt,2) + V22*sum(EP_adj(:,B22)-P_guess,2) - N_bar;    
        dum_sol = 1; dum_sol2 = 1;
        P_tild2 = P_guess;
    end