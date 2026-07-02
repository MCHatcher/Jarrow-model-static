% Insert_2_EXT

EP_adj_new = NaN(1,K); 
EP_adj_new(1,set12) = vec2(1,set12).*EP_adj(1,set12);
EP_adj_new(2,set12) = vec2(1,set12).*EP_adj(2,set12);
EP_adj_new(1,B22) = vec2(1,B22).*EP_adj(1,B22);
EP_adj_new(2,B22) = vec2(1,B22).*EP_adj(2,B22);

EV_adj_sum = V_bar*[ sum(EP_adj_new(1,set12)); sum(EP_adj_new(2,set12)) ] + V22*[ sum(EP_adj_new(1,B22)); sum(EP_adj_new(2,B22)) ];
V_sum = sum(vec2(1,set12))*V_bar + sum(vec2(1,B22))*V22;
                
P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

Demands_opt = V_bar*( EP_adj(:,set12) - P_guess );
Demands_opt(1,:) = vec2(1,set12).*Demands_opt(1,:);
Demands_opt(2,:) = vec2(1,set12).*Demands_opt(2,:);

min_opt = min(min(Demands_opt));

Demands_pes = V_bar*( EP_adj(:,B22) - P_guess );
Demands_pes(1,:) = vec2(1,B22).*Demands_pes(1,:);
Demands_pes(2,:) = vec2(1,B22).*Demands_pes(2,:);
max_pes = max(Demands_pes(1,:));

Diff = 1:m-1;
P_out = EP_adj(:,Diff) - P_guess;
max_out = max(max(P_out));

min_22 = min(EP_adj(2,B22)); 

    if min_opt >= 0 && max_pes < 0 && min_22 >= P_guess(2) && max_out < 0
        Check2 = sum(Demands_opt,2) + V22*sum(EP_adj(:,B22)-P_guess,2) - N_bar;    
        dum_sol = 1; dum_sol2 = 1;
        P_tild2 = P_guess;
    end