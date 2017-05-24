function  saliency_map = run_SCA(Image_info, FCNfeat, params, scale, Prior_info)


    fprintf('          %d-th scale, number of superpixels: %d\n', scale, params.spnumber(scale));
    %%segment image into superpixels
    Superpixel              =   SLIC_Split(Image_info.im_double, params.spnumber(scale));
    
    %%conver image feature to superpixel feature
    FCNfeat                 =   convert_im_feature_to_sup_feature(FCNfeat, Superpixel, params, Image_info);
    
    %%build graph model
    [Superpixel, Graph]     =   build_graph(Superpixel);

    %%compute _Impact Factor Matrix_ and _Coherence Matrix_
    Matrix                  =   comput_F_C(Graph, FCNfeat, params, Superpixel);
    
    fprintf('                Getting the prior map...\n');

    if params.use_prior == true
        imprior         = im2double(imread(Prior_info.fullpath));
        sal_prior       = imprior(Image_info.height_begin:Image_info.height_end, Image_info.width_begin:Image_info.width_end); 
        S_prior         = GetMeanValues(sal_prior, Superpixel.pixelList,'vgg');
        S_prior         = S_prior(:,1);
    else
        S_prior = ones(Superpixel.supNum,1)*0.5; 
    end
    
    %%run Single-layer Cellular Automata
    fprintf('                Run SCA...\n');
    tstart = tic;
    
    S_N = S_prior;
    
    % step1: decrease the saliency value of boundary superpixels
    diff = setdiff(1:Superpixel.supNum, Graph.bdIds);
    for lap=1:5
        S_N(Graph.bdIds) = S_N(Graph.bdIds) - 0.6;
        neg_Ind = find(S_N < 0);
        if numel(neg_Ind) > 0
           S_N(neg_Ind) = 0.001; 
        end
        S_N=Matrix.C_normal*S_N+(1-Matrix.C_normal).*diag(ones(1,Superpixel.supNum))*Matrix.F_normal*S_N;
        S_N(diff)=normalization(S_N(diff),0);
    end  
    
    % step2: control the ratio of foreground larger than a threshold
    for lap = 1:5
        S_N(Graph.bdIds) = S_N(Graph.bdIds) - 0.6;
        neg_Ind = find(S_N < 0);
        if numel(neg_Ind) > 0
           S_N(neg_Ind) = 0.001; 
        end
        most_sal_sup = find(S_N >0.93);
        if numel(most_sal_sup) < 0.02*Superpixel.supNum
            sal_diff = setdiff(1:Superpixel.supNum, most_sal_sup);
            S_N(sal_diff) = normalization(S_N(sal_diff),0);
        end
        S_N=Matrix.C_normal*S_N+(1-Matrix.C_normal).*diag(ones(1,Superpixel.supNum))*Matrix.F_normal*S_N;
        S_N(diff)=normalization(S_N(diff),0);
    end  
    
    % step3: simply update the saliency map according to rules
    for lap = 1:10
        S_N = Matrix.C_normal*S_N+(1-Matrix.C_normal).*diag(ones(1,Superpixel.supNum))*Matrix.F_normal*S_N;
        S_N = normalization(S_N, 0);
    end
    
    saliency_map = assign_salval_to_pixels(Image_info, Superpixel, S_N);
    
    telapsed = toc(tstart);
    fprintf('                      Done! Use %f seconds.\n', telapsed);
    fprintf('             ***********************************\n');