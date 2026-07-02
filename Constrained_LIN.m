%Constrained_LIN.m

for k=k_init:K

    set12 = k:K;
    B11 = 1:k-1;

    EV_adj_sum = V_bar*[ sum(EP_adj(1,set12)); sum(EP_adj(2,set12)) ] + V11*[ sum(EP_adj(1,B11)); sum(EP_adj(2,B11)) ];
    V_sum = length(set12)*V_bar + length(B11)*V11;
                
    EP_bar = ( V_sum \ eye(2) )*EV_adj_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V_bar(2,:)*(EP_bar - EP_adj(:,k)) <= V_bar(2,:)*N_hat && V_bar(2,:)*(EP_bar - EP_adj(:,k-1)) > V_bar(2,:)*N_hat 
        dum_sol = 1;
        set12 = k:K;
        B11 = 1:k-1;
        
        %EV_adj_sum = V_bar*[ sum(EP_adj(1,set12)); sum(EP_adj(2,set12)) ] + V11*[ sum(EP_adj(1,B11)); sum(EP_adj(2,B11)) ];
        %V_sum = length(set12)*V_bar + length(B11)*V11;            
        %EP_bar = ( V_sum \ eye(2) )*EV_adj_sum;
        %N_hat =  ( V_sum \ eye(2) )*N_bar;

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

    EV_adj_sum = V_bar*[ sum(EP_adj(1,set12)); sum(EP_adj(2,set12)) ] + V11*[ sum(EP_adj(1,B11)); sum(EP_adj(2,B11)) ];
    V_sum = length(set12)*V_bar + length(B11)*V11;
                
    EP_bar = ( V_sum \ eye(2) )*EV_adj_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V_bar(2,:)*(EP_bar - EP_adj(:,k)) <= V_bar(2,:)*N_hat && V_bar(2,:)*(EP_bar - EP_adj(:,k-1)) > V_bar(2,:)*N_hat 
        dum_sol = 1;
        set12 = k:K;
        B11 = 1:k-1;
        
        EV_adj_sum = V_bar*[ sum(EP_adj(1,set12)); sum(EP_adj(2,set12)) ] + V11*[ sum(EP_adj(1,B11)); sum(EP_adj(2,B11)) ];
        V_sum = length(set12)*V_bar + length(B11)*V11;            
        EP_bar = ( V_sum \ eye(2) )*EV_adj_sum;
        N_hat =  ( V_sum \ eye(2) )*N_bar;
        
        P_guess = ( V_sum \ eye(2) )*( EV_adj_sum  - N_bar );
    end

    if dum_sol == 1
        back = 1;
        break 
    end

    end


end