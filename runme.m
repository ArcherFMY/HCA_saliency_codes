clc; clear; close all;
%% 1. addpath
addpath(genpath('matconvnet-1.0-beta19/matlab'));
addpath(genpath('func'));

%% 2. init fcn
global fcnnet; 
fprintf('**********************************************************************\n');
fprintf('Load FCN model...\n');
tic;
fcnnet = dagnn.DagNN.loadobj(load('./matconvnet-1.0-beta19/Data/pascal-fcn32s-dag.mat')) ;
toc;
fprintf('Done!\n');
fprintf('**********************************************************************\n');

%% 3. config parameters for HCA

spnumber        = [200; 170; 140]; 
params          = HCA_config('spnumber',spnumber, 'use_prior', false);
fprintf('Config parameters for HCA.\n');
disp(params);

%% 4. setup path
imgRoot             = './images/';% test image path
priorRoot           = './priors/';
saldir              = './saliencymaps/';
if ~exist(priorRoot, 'dir')
	mkdir(priorRoot)
end
if ~exist(saldir, 'dir')
	mkdir(saldir)
end
im_ext              = 'jpg';
prior_ext           = 'png';
sal_ext             = 'png';

imnames             = dir([ imgRoot '*' 'jpg']);

fprintf('Run HCA for %d images...\n', length(imnames));
fprintf('**********************************************************************\n');

%% 5. Saliency Map Calculation
for ii = 1:length(imnames)
    fprintf('Processing image %d/%d ......\n', ii, length(imnames));
    tTotalStart = tic;

    imname                  = imnames(ii).name(1:end-4);
    imPath                  = [ imgRoot imname '.' im_ext]; 
    
    Image_info.path         =   imPath;
    Image_info.name         =   imname;
    
    Prior_info.fullpath     =   [priorRoot imname '.' prior_ext];
    
    %%run a pre-processing to remove the image frame
    Image_info              =   removeframe(Image_info);
    
    %%extract fcn feature
    FCNfeat                 =   extract_fcn_im_feature(Image_info, params, fcnnet); 
    
    SCA_maps                =   zeros(Image_info.height, Image_info.width, length(params.spnumber));
    
    fprintf('       3. Compute SCA in %d scales...\n', length(params.spnumber));
    for scale = 1 : length(params.spnumber)
        %%-----------------Single-layer Cellular Automata---------------%%
        SCA_maps(:,:,scale) = run_SCA(Image_info, FCNfeat, params, scale, Prior_info);
    end
    
    %%----------------Cubic MCA----------------
    fprintf('       4. Compute CCA, we have %d scales...\n', length(params.spnumber));
    HCA_map                 = run_CCA(SCA_maps, params);
    tTotal = toc(tTotalStart);
    fprintf('       Total time for one image: %f seconds.\n\n', tTotal);

    out_fullpath=[saldir Image_info.name '.' sal_ext];
    imwrite(HCA_map, out_fullpath);
end