% Constrained_main.m

B11 = 1:k-1;
%B22 = m+1:k-1;
             
    if isempty(B22)
        run Insert_1.m
    elseif isempty(B11)
        run Insert_2.m
    elseif ~isempty(B11)*~isempty(B22)==1
        run Insert_3.m
    end

B22 = 1:k-1;
%B11 = m+1:k-1;
             
    if isempty(B22)
        run Insert_1.m
    elseif isempty(B11)
         run Insert_2.m
    elseif ~isempty(B11)*~isempty(B22)==1
         run Insert_3.m
    end
          
