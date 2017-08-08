function Updated = executeUpdate(S_M,threshold,v,index)

    Sigma.o             = sign(S_M - threshold(:,1:size(S_M,2)));
    Sigma.all           = sign(S_M(index)- threshold);

    Updated             = S_M + (repmat(sum(Sigma.o,2) + sum(Sigma.all,2),[1,size(S_M, 2)]) - Sigma.o)*v;

