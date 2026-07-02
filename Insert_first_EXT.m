% Insert_first_EXT

B11 = []; B22 = [];
EP_adj_new = []; 
EP_adj_new(1,set12) = vec2(1,set12).*EP_adj(1,set12);
EP_adj_new(2,set12) = vec2(1,set12).*EP_adj(2,set12);
EV_adj_sum = V_bar*[ sum(EP_adj_new(1,set12)) ; sum(EP_adj_new(2,set12)) ];
V_sum = sum(vec2(1,set12))*V_bar;
                
P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

Demands_opt = V_bar*( EP_adj(:,set12) - P_guess );
Demands_opt(1,:) = vec2(1,set12).*Demands_opt(1,:);
Demands_opt(2,:) = vec2(1,set12).*Demands_opt(2,:);

min_opt = min(min(Demands_opt));
Diff = 1:k-1;

    if min_opt >= 0 && max(EP_adj(1,Diff)) < P_guess(1) && max(EP_adj(2,Diff)) < P_guess(2)
        Check = sum(Demands_opt,2) - N_bar;
        Demands = sum(Demands_opt,2);
        dum_sol = 1; dum_sol0 = 1;
        P_tild0 = P_guess;
        Demands12 = [ zeros(J,length(Diff)) Demands_opt ];
    end