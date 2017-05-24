function meanCol = GetMeanValues(image, pixelList,feat_type)
% Code Author: Wangjiang Zhu
% Email: wangjiang88119@gmail.com
% Date: 3/24/2014
% Modified by Mengyang Feng (4/24/2017)

[h, w, chn] = size(image);
if ~strcmp(feat_type,'vgg')
    image = uint8(image*255);
end
tmpImg=reshape(image, h*w, chn);
spNum = length(pixelList);
meanCol=zeros(spNum, chn);
for i=1:spNum
    meanCol(i, :)=mean(tmpImg(pixelList{i},:), 1);
end
if chn ==1 %for gray images
    meanCol = repmat(meanCol, [1, 3]);
end