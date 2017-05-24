function FCNfeat = extract_fcn_im_feature(Image_info, params, fcnnet)

    global res
    input_im_uint8  = Image_info.im_uint8;
    pool1_ind       = params.pool1_ind;
    pool5_ind       = params.pool5_ind;

    
    img = single(input_im_uint8); % note: 255 range
    img = imresize(img, [fcnnet.meta.normalization.imageSize(1),fcnnet.meta.normalization.imageSize(2)]);
    tmp=single(zeros(500,500,3));
    tmp(:,:,1)=fcnnet.meta.normalization.averageImage(:,:,1);
    tmp(:,:,2)=fcnnet.meta.normalization.averageImage(:,:,2);
    tmp(:,:,3)=fcnnet.meta.normalization.averageImage(:,:,3);
    img = img - tmp;
    
    fprintf('       2. Run FCN Feature...\n');
    tstart = tic;
      fcnnet.eval({'data', img}) ;
    telapsed = toc(tstart);
    fprintf('               Done! Use %f seconds.\n', telapsed);
    
    FCNfeat.pool1           =   res{pool1_ind};
    FCNfeat.pool5           =   res{pool5_ind};