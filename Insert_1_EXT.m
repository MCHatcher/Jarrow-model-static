% Insert_1_EXT

EP_adj_new = NaN(2,K); 
EP_adj_new(1,set12) = vec2(1,set12).*EP_adj(1,set12);
EP_adj_new(2,set12) = vec2(1,set12).*EP_adj(2,set12);
EP_adj_new(1,B11) = vec2(1,B11).*EP_adj(1,B11);
EP_adj_new(2,B11) = vec2(1,B11).*EP_adj(2,B11);

EV_adj_sum = V_bar*[ sum(EP_adj_new(1,set12)); sum(EP_adj_new(2,set12)) ] + V11*[ sum(EP_adj_new(1,B11)); sum(EP_adj_new(2,B11)) ];
V_sum = sum(vec2(1,set12))*V_bar + sum(vec2(1,B11))*V11;
                
P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );

Demands_opt = V_bar*( EP_adj(:,set12) - P_guess );
Demands_opt(1,:) = vec2(1,set12).*Demands_opt(1,:);
Demands_opt(2,:) = vec2(1,set12).*Demands_opt(2,:);

min_opt = min(min(Demands_opt));

Demands_pes = V_bar*( EP_adj(:,B11) - P_guess );
Demands_pes(1,:) = vec2(1,B11).*Demands_pes(1,:);
Demands_pes(2,:) = vec2(1,B11).*Demands_pes(2,:);
max_pes = max(Demands_pes(2,:));

Diff = 1:m-1;
P_out = EP_adj(:,Diff) - P_guess;
max_out = max(max(P_out));

min_11 = min(EP_adj(1,B11)); %max_11 = max(EP_adj(2,B11));  

    if min_opt >= 0 && max_pes < 0 && min_11 >= P_guess(1) && max_out < 0 
        Check1 = sum(Demands_opt,2) + V11*sum(EP_adj(:,B11)-P_guess,2) - N_bar;
        dum_sol = 1; dum_sol1 = 1;
        P_tild1 = P_guess;
        %Demands12 = Demands_opt;
        %Demands11 = V11*(EP_adj(:,B11)-P_guess);
        %Demands22 = V22*(EP_adj(:,B22)-P_guess);
    end