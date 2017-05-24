function Image_info = removeframe(Image_info)
% $Description:
%    -remove the image frame on the border
% 
% Input;
%    -imPath:       image full path, e.g., imPath = [ imgRoot imnames(ii).name ];
% Output:
%    -Image_info:   original image size and the new. {height, width, height_begin, height_end, width_begin, width_end, new_height, new_width}
%                   uint8 image and double image. {im_uint8, im_double}

imPath = Image_info.path;

fprintf('       1. run a pre-processing to remove the image frame.\n');
threshold=0.5;
im_int = imread(imPath);        % uint8 
im_double=im2double(im_int);    % double 
 [~,~,k] = size(im_double);
% make sure the image has 3 channels (Red,Green,Blue)
if k ~= 3
    im_double(:,:,2) = im_double(:,:,1);
    im_double(:,:,3) = im_double(:,:,1);
    im_int(:,:,2) = im_int(:,:,1);
    im_int(:,:,3) = im_int(:,:,1);
end

gray=rgb2gray(im_double);
edgemap = edge(gray,'canny');
[m,n]=size(edgemap);
flagt=0;
flagd=0;
flagr=0;
flagl=0;
t=1;
d=1;
l=1;
r=1;

for k=1:33 % we assume that the frame is not wider than 33 pixels.
    pbt=mean(edgemap(k,:));
    pbd=mean(edgemap(m-k+1,:));
    pbl=mean(edgemap(:,k));
    pbr=mean(edgemap(:,n-k+1));
    if pbt>threshold
        t=k;
        flagt=1;
    end
    if pbd>threshold
        d=k;
        flagd=1;
    end
    if pbl>threshold
        l=k;
        flagl=1;
    end
    if pbr>threshold
        r=k;
        flagr=1;
    end
end

flagrm=flagt+flagd+flagl+flagr;
% we assume that there exists a frame when one more lines parallel to the image side are detected 
if flagrm>1 
    maxwidth=max([t,d,l,r]);
    % 
    if t==1
        t=maxwidth;
    end
    if d==1
        d=maxwidth;
    end
    if l==1
        l=maxwidth;
    end
    if r==1
        r=maxwidth;
    end    
    im_double = im_double(t:m-d+1,l:n-r+1,:);
    im_int = im_int(t:m-d+1,l:n-r+1,:);
    w=[m,n,t,m-d+1,l,n-r+1];
else
    w=[m,n,1,m,1,n];
end  

Image_info.height               = w(1);
Image_info.width                = w(2);
Image_info.height_begin         = w(3);
Image_info.height_end           = w(4);
Image_info.width_begin          = w(5);
Image_info.width_end            = w(6);
[Image_info.new_height, Image_info.new_width, ~]     =   size(im_double);
Image_info.im_uint8 = im_int;
Image_info.im_double = im_double;
      