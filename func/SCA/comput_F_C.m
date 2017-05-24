function     Matrix  = comput_F_C(Graph, FCNfeat, params, Superpixel)
    
    edges           = Graph.edges;
    pool5_sup       = FCNfeat.pool5_sup;
    pool1_sup       = FCNfeat.pool1_sup;
    theta           = params.theta;
    alpha           = params.alpha;
    supNum          = Superpixel.supNum;
    
    fprintf('                Compute _Impact Factor Matrix_ and _Coherence Matrix_ ...\n');

    weights                 =   makeweights(edges,pool5_sup,pool1_sup,theta,alpha);
    F                       =   adjacency(edges,weights,supNum);    
    
    % calculate a row-normalized impact factor matrix
    D_sam                   =   sum(F,2);
    D                       =   diag(D_sam);
    Matrix.F_normal         =   D \ F;   % the row-normalized impact factor matrix

    % compute Coherence Matrix 
    C                       =   params.a * normalization(1./max(F),0) + params.b;
    Matrix.C_normal         =   diag(C);