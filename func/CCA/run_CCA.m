function     HCA_map  = run_CCA(SCA_maps, params)

    v   = params.v; % the value of ln(lamda/l-lamda)
    N2  = params.N2; % the number of updating time steps
    
    fprintf('                Run CCA...\n');
    fprintf('                      the number of updating time steps: %d\n', N2);
    fprintf('                      the value of ln(lamda/1-lamda): %f\n', v);
    tstart = tic;
    
    [m,n,M]         = size(SCA_maps);
    index.o         = reshape([1:m*n]',[m,n]);
    SCA_maps        = normalize_1(SCA_maps,0); 
    index.r         = index.o(:,[2:end,end]);
    index.l         = index.o(:,[1,1:end-1]);
    index.u         = index.o([1,1:end-1],:);
    index.d         = index.o([2:end,end],:);
    
 
    
    %%-----------------Multilayer Cellular Automata--------------------%%
    % compute the threshold 
    threshold=zeros(1,M);    
    for i=1:M                 
        threshold(i) = log(graythresh(SCA_maps(:,:,i))/(1-graythresh(SCA_maps(:,:,i))));
    end
    
    % record saliency values in th form of ln()
    SCA_maps    =   log((SCA_maps)./(1-SCA_maps));
        
    % update the saliency maps according to rules
    [m,n,M]     =   size(SCA_maps);

    SCA_maps_       = reshape(SCA_maps,[m*n,M]);
    index_.r        = reshape(index.r,[m*n,1])*ones(1,M)+repmat([0:M-1]*m*n,[m*n,1]);
    index_.l        = reshape(index.l,[m*n,1])*ones(1,M)+repmat([0:M-1]*m*n,[m*n,1]);
    index_.u        = reshape(index.u,[m*n,1])*ones(1,M)+repmat([0:M-1]*m*n,[m*n,1]);
    index_.d        = reshape(index.d,[m*n,1])*ones(1,M)+repmat([0:M-1]*m*n,[m*n,1]);
    index_.all      = [index_.r,index_.l,index_.u,index_.d];
    threshold_      = repmat(threshold,[size(SCA_maps_,1),4]);
    for lap=1:N2
        SCA_maps_ = executeUpdate(SCA_maps_,threshold_,v,index_.all);
    end
    SCA_maps = reshape(SCA_maps_,[m,n,M]);
    % restore saliency values from ln()
    SCA_maps=exp(SCA_maps)./(1+exp(SCA_maps));
    SCA_maps=normalization(SCA_maps,0);

    % integrate M updated saliency maps
    HCA_map=sum(SCA_maps,3);
    HCA_map=normalization(HCA_map,0);
        
    telapsed = toc(tstart);
    fprintf('                      Done! Use %f seconds.\n', telapsed);
