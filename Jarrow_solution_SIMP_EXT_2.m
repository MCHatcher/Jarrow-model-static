% Code for solving 2-market model with pessimists and optimists - extension
% for scaled (heterogeneous V matrices)
% Written by M. Hatcher

clc, clear

tic

K = 100;          % No. of investors
J = 2;              % No. of markets
N_bar = ones(J,1);  % Endowments
n_iter = 50;        % No. of price iterations
k_back = 1;         
Iter = 1;           % Turn on price iterations
dum_slack = 0;      %0 = shorting ban; 1 = no shorting ban;

Investors = 1:K;
Var1 = 1; Var2 = 3; CV = -1.5;  %0.5*sqrt(3);  -1.5
Omega_bar = [Var1 CV;CV Var2];   %vcov matrix
V_bar = Omega_bar \ eye(2);

vec = linspace(1e-4,4,K);

% Exponentially bunch points towards the higher end of the 0-to-1 range
%startVal = 0; endVal = 1;
%vec = linspace(0,1,K);

% Square the uniform vector to create non-uniform density, then scale
%vec = startVal + (endVal - startVal) * (vec .^2);

rng(3)
vec = vec(randperm(K));

EP_base = [4;6];
EP = EP_base*vec;  % Price expectations
%EP(:,1) = 1e-4 + [ min(EP(1,:)); min(EP(2,:)) ];
EP1 = EP(1,:); EP2 = EP(2,:);

%---------------
% Sort beliefs
%---------------
[Sort,Index] = sort(EP1);  
EP_adj = [EP1(Index); EP2(Index)];
Gen_V_2

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;

V_sum = sum(V,3); EV_sum = sum(E_weight,3);
P_guess = (V_sum \ eye(2))*(  EV_sum  - N_bar );
    for i = 1:K
        Demands_guess(:,i) = V(:,:,i)*( EP_adj(:,i) - P_guess );
    end
        Demands = sum(E_weight,3) - sum(V,3)*P_guess;

    if min(min(Demands_guess)) >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess
        slack = 1;

        set_out = []; B11 = set_out; B22 = set_out;
        B12 = 1:K; B12_star = B12; 
        B11_star = B11; B22_star = B22; 
        Demands_opt = Demands_guess;
        Dem11 = []; Dem22 = [];
        Check = max(abs( Demands  - N_bar) )

    else

        k_con1 = nnz(Demands_guess(1,:)<0); k_con2 = nnz(Demands_guess(2,:)<0);
        k_con = max(k_con1,k_con2); k_init = max(1,k_con-k_back);

        if Iter==1
            Price_iter_EXT_2
        end

        Constrained_SIMP_EXT_2

            if dum_sol==1
                P_tild = P_guess
                constrained = k-1;  

                B11_star = B11; B22_star = B22;
                B12_star = k:K; set_out = setdiff(1:k-1,B11_star); set_out = setdiff(set_out,B22_star);
                Demands_opt = [];

                for j = B12_star
                    Demands_opt(:,j) = V(:,:,j)*( EP_adj(:,j) - P_guess );
                end

                for j = B11_star
                    Demands_opt(:,j) = V11(:,:,j)*( EP_adj(:,j) - P_guess );
                end

                for j = B22_star
                    Demands_opt(:,j) = V22(:,:,j)*( EP_adj(:,j) - P_guess );
                end
                
                Demands = sum(Demands_opt,2);
                Check = max(abs(Demands - N_bar))
            end


    end


toc

if slack == 1
    Demands_1 = [Demands_opt(1,:)]; 
    Demands_2 = [Demands_opt(2,:)];
else
    Demands_1 = [zeros(1,length(set_out)) Dem11(1,:) Dem22(1,:) Demands_opt(1,:)]; 
    Demands_2 = [zeros(1,length(set_out)) Dem11(2,:) Dem22(2,:) Demands_opt(2,:)];
end

figure(3)
subplot(1,2,1), plot(1:length(Demands_1), Demands_1), hold on, plot(1:length(Demands_2), Demands_2), hold on, title('Asset demands: K = 100')










