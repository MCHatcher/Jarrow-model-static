% Price_iter_LIN_EXT

B12_guess = k_init:K;
V_sum = sum(V(:,:,B12_guess),3);
EV_adj_sum = sum(E_weight(:,:,B12_guess),3);

P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar ); P_g(:,1) = P_guess;
Demands_guess = V_bar(2,:)*( EP(:,1:K) - P_guess );
k_con = nnz(Demands_guess<0);

    for jj=2:n_iter
    
        B12_guess = k_con:K;
        V_sum = sum(V(:,:,B12_guess),3);
        EV_adj_sum = sum(E_weight(:,:,B12_guess),3);
        P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar ); P_g(:,jj) = P_guess;
        Demands_guess = V_bar(2,:)*( EP(:,1:K) - P_guess );
        k_con = nnz(Demands_guess<0);

        if max( abs(P_g(:,jj)-P_g(:,jj-1)) )  / max(abs(P_g(:,jj-1))) < 5e-5
            break
        end

    end

k_init = max(2,k_con-k_back); 