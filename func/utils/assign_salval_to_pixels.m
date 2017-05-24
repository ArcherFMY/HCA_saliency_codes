function        saliency_map = assign_salval_to_pixels(Image_info, Superpixel, S_N)

    image_sam=zeros(Image_info.new_height, Image_info.new_width);
    image_sam(:)=S_N(Superpixel.sulabel(:));
    saliency_map = zeros(Image_info.height, Image_info.width);
    saliency_map(Image_info.height_begin:Image_info.height_end, Image_info.width_begin:Image_info.width_end) = image_sam;