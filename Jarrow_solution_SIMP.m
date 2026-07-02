% Code for solving 2-market model with pessimists and optimists
% Written by M. Hatcher

clc, clear

tic

K = 10000;          % No. of investors
J = 2;              % No. of markets
N_bar = ones(J,1);  % Endowments
n_iter = 50;        % No. of price iterations
k_back = 0;         
Iter = 1;           % Turn on price iterations
dum_slack = 0;      %0 = shorting ban; 1 = no shorting ban;

Investors = 1:K;
Var1 = 1; Var2 = 3; CV = -1.5;  %0.5*sqrt(3);  -1.5
Omega_bar = [Var1 CV;CV Var2];   %vcov matrix
V_bar = Omega_bar \ eye(2);
vec = linspace(1e-4,4,K); 

rng(3)
vec = vec(randperm(K));
EP_base = [4;6];
EP = EP_base*vec;  % Price expectations
EP1 = EP(1,:); EP2 = EP(2,:);

%---------------
% Sort beliefs
%---------------
mult = V_bar*EP;
[Sort,Index] = sort(mult(1,:));  [Sort1,Index1] = sort(mult(2,:));
[Sort2,Index2] = sort(EP1);  
EP_adj = [EP1(Index2); EP2(Index2)];

V11 = [det(V_bar)/V_bar(2,2) 0; 0 0];
V22 = [0 0; 0 det(V_bar)/V_bar(1,1)];

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;

%Check for slack constraints
EV_sum = [ ones(1,K)*EP_adj(1,:)'; ones(1,K)*EP_adj(2,:)' ];
P_guess = (1/K)*EV_sum  - Omega_bar/K*N_bar;

Demands_guess = V_bar*( EP - P_guess );
min_slack = min(min(Demands_guess));

    if min_slack >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess
        slack = 1; 
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = 1:K; B12_star = B12; 
        B11_star = B11; B22_star = B22; 
        Demands = V_bar*( EP_adj(:,B12) - P_guess );
        Demands_opt = Demands; sum_Dem = [ones(1,K)*Demands(1,:)'; ones(1,K)*Demands(2,:)'];
        Check = max(abs( sum_Dem  - N_bar) )

    else

        k_con1 = nnz(Demands_guess(1,:)<0); k_con2 = nnz(Demands_guess(2,:)<0);
        k_con = max(k_con1,k_con2); k_init = max(1,k_con-k_back);

        if Iter==1
            Price_iter
        end

        Constrained_SIMP

            if dum_sol==1
                P_tild = P_guess
                constrained = k-1;  

                if dum_sol1 ==1
                    B22 = [];
                elseif dum_sol2 ==1
                    B11 = [];
                end

                B11_star = B11; B22_star = B22;
                B12_star = k:K; set_out = setdiff(1:k-1,B11_star); set_out = setdiff(set_out,B22_star); 

                Demands_opt = V_bar*( EP_adj(:,k:K) - P_guess );
                
                Dem11 = V11*(EP_adj(:,B11)-P_guess);
                Dem22 = V22*(EP_adj(:,B22)-P_guess);


                Demands = sum(Demands_opt,2) + V11*sum(EP_adj(:,B11)-P_guess,2) +  V22*sum(EP_adj(:,B22)-P_guess,2);
                Check = max(abs(Demands - N_bar))
                %Demands12 = Demands_opt;
                %Demands11 = V11*(EP_adj(:,:)-P_guess);
                %Demands22 = V22*(EP_adj(:,:)-P_guess);
            end


    end


toc

Index_diff = sum(abs(Index - Index1)); 
Index_diff2 = sum(abs(Index - Index2)); 

if Index_diff>0 || Index_diff2>0
    disp('"NOTE: Expectations condition not satsified. Algorithm may not find a solution."')
end

if slack == 1
    Demands_1 = [Demands_opt(1,:)]; 
    Demands_2 = [Demands_opt(2,:)];
else
    Demands_1 = [zeros(1,length(set_out)) Dem11(1,:) Dem22(1,:) Demands_opt(1,:)]; 
    Demands_2 = [zeros(1,length(set_out)) Dem11(2,:) Dem22(2,:) Demands_opt(2,:)];
end

min_Demands = min(min([Demands_1; Demands_2]));
if min_Demands<0 && dum_slack==0
    disp('"Warning: Demands are not non-negative!!"')
end

figure(1)
subplot(1,2,1), plot(1:length(Demands_1), Demands_1), hold on, plot(1:length(Demands_2), Demands_2), hold on, title('Asset demands: K = 100')

figure(2)
subplot(1,2,2), plot(1:length(Demands_1), Demands_1), hold on, plot(1:length(Demands_2), Demands_2), hold on, title('Asset demands: K = 100')












