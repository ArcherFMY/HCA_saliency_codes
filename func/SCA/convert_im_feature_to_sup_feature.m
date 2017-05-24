function     FCNfeat                 =   convert_im_feature_to_sup_feature(FCNfeat, Superpixel, params, Image_info)

    fprintf('                Compute features for each superpixel...\n');
    tstart = tic;
    
    pixelList       = Superpixel.pixelList;
    padding         = params.padding;
    height          = Image_info.new_height;
    width           = Image_info.new_width;
    pool1_ind       = params.pool1_ind;
    pool5_ind       = params.pool5_ind;
    
    temp                    =   FCNfeat.pool5;
    feat_pool5_res          =   temp(padding(pool5_ind):end-padding(pool5_ind)+1,...
                                     padding(pool5_ind):end-padding(pool5_ind)+1, : );
    feat_pool5_res          =   double(imresize(feat_pool5_res,...
                                                [height, width]));
    FCNfeat.pool5_sup       =   GetMeanValues(feat_pool5_res,pixelList,'vgg');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

    temp                    =   FCNfeat.pool1;
    feat_pool1_res          =   temp(padding(pool1_ind):end-padding(pool1_ind)+1,...
                                     padding(pool1_ind):end-padding(pool1_ind)+1, : );
    feat_pool1_res          =   double(imresize(feat_pool1_res,...
                                                [height, width]));
    FCNfeat.pool1_sup       =   GetMeanValues(feat_pool1_res,pixelList,'vgg');
    
    telapsed = toc(tstart);
    fprintf('                      Done! Use %f seconds.\n', telapsed);