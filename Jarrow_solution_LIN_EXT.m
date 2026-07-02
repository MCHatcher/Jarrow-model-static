% Code for 2-market model with short-selling constraint on asset 2 only
% Written by M. Hatcher

clc, clear

K = 1000;          % No. of investors
J = 2;              % No. of markets
N_bar = ones(J,1);  % Endowments
n_iter = 50;        % No. of price iterations
k_back = 0;         
Iter = 1;           % Turn on price iterations
dum_slack = 0;      %0 = shorting ban; 1 = no shorting ban;

Investors = 1:K;
Var1 = 3; Var2 = 1; CV = 1;  %0.5*sqrt(3);  -1.5
Omega_bar = [Var1 CV;CV Var2];   %vcov matrix
V_bar = Omega_bar \ eye(2); 

rng(3)
EP_base = [4;4]; EP=NaN(2,K); mat = [1 -0.5; -0.5 1];
for k=1:K
    %EP(:,k) = (1 + 1*rand*mat)*EP_base;  % Price expectations
    EP(:,k) = (mat + 0.01*rand(2,2))*EP_base;  % Price expectations
end
EP1 = EP(1,:); EP2 = EP(2,:);

%---------------
% Sort beliefs
%---------------
mult = V_bar*EP;
[Sort,Index] = sort(mult(2,:));
EP_adj = [EP1(Index); EP2(Index)];
Gen_V

tic

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;

%Check for slack constraints
P_guess = (SUM_V \ eye(2))*(  EV_sum  - N_bar );
    for k = 1:K
        Demands_opt(:,k) = E_weight(:,:,k) - V(:,:,k)*P_guess;
    end
        Demands_guess = Demands_opt;
        Demands = sum(Demands_guess,2);

    if V(2,:,1)*(EP_adj(:,1)-P_guess) >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess
        slack = 1; 
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = 1:K; B12_star = B12; 
        B11_star = B11; B22_star = B22; 
        Dem11 = []; Dem22 = [];
        Check = max(abs( Demands  - N_bar) )

    else

        k_con = nnz(Demands_guess(1,:)<0); 
        k_init = max(2,k_con-k_back);

        if Iter==1
            Price_iter_LIN_EXT
        end

        Constrained_LIN_EXT

            if dum_sol==1
                P_tild = P_guess
                constrained = k-1;  

                B11_star = B11; 
                B12_star = k:K; set_out = 1:k-1; 

                for k = B12_star
                    Demands_opt(:,k) = E_weight(:,:,k) - V(:,:,k)*P_guess;
                end
                for k = B11_star
                    Demands_opt(:,k) = E_weight1(:,:,k) - V11(:,:,k)*P_guess;
                end

                %Demands_opt(2,set_out) = zeros(1,k-1);

                Dem11 = Demands_opt(:,set_out);
                
                Demands = sum(Demands_opt,2);
                Check = max(abs(Demands - N_bar))
            end


    end


toc

    Demands_1 = Demands_opt(1,:);
    Demands_2 = Demands_opt(2,:);

    min_Demands = min(Demands_2);
if min_Demands<0 && dum_slack==0
    disp('"Warning: Demands are not non-negative!!"')
end

figure(1)
subplot(1,2,1), plot(1:length(Demands_1), Demands_1), hold on, plot(1:length(Demands_2), Demands_2), hold on, title('Asset demands: K = 100')
        










