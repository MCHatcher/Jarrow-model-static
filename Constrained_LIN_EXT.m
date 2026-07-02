%Constrained_LIN_EXT.m

for k=k_init:K

    set12 = k:K;
    B11 = 1:k-1;

    V_sum = sum(V(:,:,set12),3) + sum(V11(:,:,B11),3);
    EV_adj_sum = sum(E_weight(:,:,set12),3) + sum(E_weight1(:,:,B11),3);
                
    EP_bar = ( V_sum \ eye(2) )*EV_adj_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V_bar(2,:)*(EP_bar - EP_adj(:,k)) <= V_bar(2,:)*N_hat && V_bar(2,:)*(EP_bar - EP_adj(:,k-1)) > V_bar(2,:)*N_hat 
        dum_sol = 1;
        set12 = k:K;
        B11 = 1:k-1;

        P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );
    end

    if dum_sol == 1
        break 
    end


end

if dum_sol ~= 1

    for k=k_init-1:-1:1

    set12 = k:K;
    B11 = 1:k-1;

    V_sum = sum(V(:,:,set12),3) + sum(V11(:,:,B11),3);
    EV_adj_sum = sum(E_weight(:,:,set12),3) + sum(E_weight1(:,:,B11),3);
                
    EP_bar = ( V_sum \ eye(2) )*EV_adj_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V_bar(2,:)*(EP_bar - EP_adj(:,k)) <= V_bar(2,:)*N_hat && V_bar(2,:)*(EP_bar - EP_adj(:,k-1)) > V_bar(2,:)*N_hat 
        dum_sol = 1;
        set12 = k:K;
        B11 = 1:k-1;

        P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );
    end

    if dum_sol == 1
        back = 1;
        break 
    end

    end


end