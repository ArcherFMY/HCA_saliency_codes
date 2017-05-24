function conf = HCA_config(varargin)

    ip = inputParser;
    
    % Image scales -- the number of superpixels                                               
    ip.addParameter('spnumber',          200,            @ismatrix);
    
    %% Single-layer Cellular Automata parameters
    % extract feature from pool5 and pool1 in FCN32s
    ip.addParameter('pool5_ind',   32,              @isscalar);
    ip.addParameter('pool1_ind',   6,              @isscalar);
    ip.addParameter('padding',     [0 100 100 100 100 ... 
                                    52 52 52 52 52 ... 
                                    26 26 26 26 26 26 26 ... 
                                    14 14 14 14 14 14 14 ...
                                    7 7 7 7 7 7 7 ...
                                    4],            @ismatrix);

    % control the strength of similarity between neighbors
    ip.addParameter('theta',        15,           @isscalar);
    % % a and b control the strength of coherence
    ip.addParameter('a',   0.6,              @isscalar);
    % Minibatch size
    ip.addParameter('b',      0.2,            @isscalar);
    % control the weights of features
    ip.addParameter('alpha',     [5;3],            @ismatrix);
    % Use horizontally-flipped images during training?
    ip.addParameter('use_prior',     true,           @islogical);
    
    %% Cubic MCA
    % the value of ln(lamda/l-lamda)
    ip.addParameter('v',   0.05,              @isscalar);
    % the number of updating time steps 
    ip.addParameter('N2',      3,            @isscalar);

    ip.parse(varargin{:});
    conf = ip.Results;