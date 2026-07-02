% Gen_V_2

V = []; V11 = V; V22 = V; Omega = []; E_weight = []; E_weight1 = E_weight; E_weight2 = E_weight; 

for q=1:K

    if q==1
        V(:,:,q) = V_bar;
    elseif q>1
        V(:,:,q) = V(:,:,q-1) + 0.01*rand(2,2);
        V(2,1,q) = V(1,2,q);
    end

    V11(:,:,q) = [ det(V(:,:,q))/V(2,2,q) 0; 0 0];
    V22(:,:,q) = [ 0 0; 0 det(V(:,:,q))/V(1,1,q)];

    Omega(:,:,q) = V(:,:,q) \ eye(2);

    Prod = V(:,:,q)*EP_adj(:,q);
    Prod1 = V11(:,:,q)*EP_adj(:,q);
    Prod2 = V22(:,:,q)*EP_adj(:,q);

    E_weight(:,:,q) = Prod;
    E_weight1(:,:,q) = Prod1;
    E_weight2(:,:,q) = Prod2;

end




