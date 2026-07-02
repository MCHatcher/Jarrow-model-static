% Price_iter_LIN_EXT_2

B12_guess = k_init:K; B11_guess = 1:k_init-1;
V_sum = sum(vec(B12_guess))*V_bar + sum(vec(B11_guess))*V11;
EV_adj_sum = V_bar*[ sum(EP_adj2(1,B12_guess)) ; sum(EP_adj2(2,B12_guess))  ] +  V11*[ sum(EP_adj2(1,B11_guess)) ; sum(EP_adj2(2,B11_guess))  ];          
P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar ); P_g(:,1) = P_guess;
Demands_guess = V_bar*( EP_adj - P_guess ); 
Demands_guess(1,:) = vec.*Demands_guess(1,:); Demands_guess(2,:) = vec.*Demands_guess(2,:);
k_con = nnz(Demands_guess(2,:)<0); k_con = max(2,k_con-k_back);

    for jj=2:n_iter
    
        B12_guess = k_con:K; B11_guess = 1:k_con-1;
        V_sum = sum(vec(B12_guess))*V_bar + sum(vec(B11_guess))*V11;
        EV_adj_sum = V_bar*[ sum(EP_adj2(1,B12_guess)) ; sum(EP_adj2(2,B12_guess))  ] + V11*[ sum(EP_adj2(1,B11_guess)) ; sum(EP_adj2(2,B11_guess))  ];          
        P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar ); P_g(:,jj) = P_guess;
        Demands_guess = V_bar*( EP_adj - P_guess ); 
        Demands_guess(1,:) = vec.*Demands_guess(1,:); Demands_guess(2,:) = vec.*Demands_guess(2,:);
        k_con = nnz(Demands_guess(2,:)<0); k_con = max(2,k_con-k_back);

        if max( abs(P_g(:,jj)-P_g(:,jj-1)) )  / max(abs(P_g(:,jj-1))) < 5e-5
            break
        end

    end

k_init = max(1,k_con-k_back); 