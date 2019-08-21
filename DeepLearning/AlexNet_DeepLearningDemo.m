% To add a new cell, type '%%%'
% To add a new markdown cell, type ''

% %%% Deep Learning Example: Transfer Learning using AlexNet and CIFAR-10 Dataset
% Copyright 2017 The MathWorks, Inc.
% You will need to download images in order to run this example.
% Please see the file in this directory: DownloadCIFAR10.m Running this file will help you download CIFAR10 if you choose to use those images.

% %%% Bring in Alex Net
% If this is your first time running this code, this may cause an error message to occur. Follow the link to download AlexNet. You'll only need to download alexnet once.

%%%
net = alexnet;


% %%% Access Layers
% Visualize the layers of AlexNet, what do we see about this architecture? What do we have to change for this to work for our new data?

%%%
layers = net.Layers


% %% Train
% %%% Set up training data

%%%
rootFolder = 'cifar10Train';
categories = {'deer','dog','frog','cat'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');

imds = splitEachLabel(imds, 500, 'randomize') % we only need 500 images per class
imds.ReadFcn = @readFunctionTrain;


% %%% Take layers from Alex Net, then add our own

%%%
layers = layers(1:end-3);

layers(end+1) = fullyConnectedLayer(64, 'Name', 'special_2');
layers(end+1) = reluLayer;
layers(end+1) = fullyConnectedLayer(4, 'Name', 'fc8_2 ');
layers(end+1) = softmaxLayer;
layers(end+1) = classificationLayer()


% %%% Fine-tune learning rates [advanced]

%%%
layers(end-2).WeightLearnRateFactor = 10;
layers(end-2).WeightL2Factor = 1;
layers(end-2).BiasLearnRateFactor = 20;
layers(end-2).BiasL2Factor = 0;


% %%% Other training options

%%%
opts = trainingOptions('sgdm', ...
    'LearnRateSchedule', 'none',...
    'InitialLearnRate', .0001,... 
    'MaxEpochs', 20, ...
    'MiniBatchSize', 128);


% %%% Train! 
% Please note this may take a few minutes or longer depending on hardware. Training with a GPU is strongly encouraged.

%%%
convnet = trainNetwork(imds, layers, opts);


% %%% Test
% Set up test data

%%%
rootFolder = 'cifar10Test';
testDS = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
testDS.ReadFcn = @readFunctionTrain;


% %%% Test classifer

%%%
[labels,err_test] = classify(convnet, testDS, 'MiniBatchSize', 64);


% %%% Determine overall accuracy

%%%
confMat = confusionmat(testDS.Labels, labels);
confMat = confMat./sum(confMat,2);
mean(diag(confMat))


