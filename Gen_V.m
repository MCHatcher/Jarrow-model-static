% Gen_VCOV
V = []; V11 = V; Omega = []; E_weight = []; E_weight1 = E_weight;

for k=1:K

    V(:,:,k) = V_bar;

    V(1,1,k) = (0.8+0.4*rand)*V_bar(1,1);

    V11(:,:,k) = [ det(V(:,:,k))/V(2,2,k) 0; 0 0];

    Omega(:,:,k) = V(:,:,k) \ eye(2);

    Prod = V(:,:,k)*EP_adj(:,k);
    Prod1 = V11(:,:,k)*EP_adj(:,k);

    E_weight(:,:,k) = Prod;
    E_weight1(:,:,k) = Prod1;


    if k==1

        X = Prod;

    elseif k>1

        X = X + Prod;   

    end

end

SUM_V = sum(V,3)
EV_sum = X;
%SUM_TOT = sum(SM,3)


