%% Download the CIFAR-10 dataset
%

if ~exist('cifar-10-batches-mat','dir')
cifar10Dataset = 'cifar-10-matlab';
disp('Downloading 174MB CIFAR-10 dataset...');   
websave([cifar10Dataset,'.tar.gz'],...
['https://www.cs.toronto.edu/~kriz/',cifar10Dataset,'.tar.gz']);
gunzip([cifar10Dataset,'.tar.gz'])
delete([cifar10Dataset,'.tar.gz'])
untar([cifar10Dataset,'.tar'])
delete([cifar10Dataset,'.tar'])
end

%% Prepare the CIFAR-10 dataset
if ~exist('cifar10Train','dir')
disp('Saving the Images in folders. This might take some time...');
saveCIFAR10AsFolderOfImages('cifar-10-batches-mat', pwd, true);
end

% Load training data
% note: these are 4 of the 10 categories available
categories = {'airplane','automobile','bird','horse'};

rootFolder = 'cifar10Train';
imds = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');

%%
%

varSize = 32;
conv1 = convolution2dLayer(5,varSize,'Padding',2,'BiasLearnRateFactor',2);
conv1.Weights = gpuArray(single(randn([5 5 3 varSize])*0.0001));
fc1 = fullyConnectedLayer(64,'BiasLearnRateFactor',2);
fc1.Weights = gpuArray(single(randn([64 576])*0.1));
fc2 = fullyConnectedLayer(4,'BiasLearnRateFactor',2);
fc2.Weights = gpuArray(single(randn([4 64])*0.1));

%%
%

layers = [
imageInputLayer([varSize varSize 3]);
conv1;
maxPooling2dLayer(3,'Stride',2);
reluLayer();
convolution2dLayer(5,32,'Padding',2,'BiasLearnRateFactor',2);
reluLayer();
averagePooling2dLayer(3,'Stride',2);
convolution2dLayer(5,64,'Padding',2,'BiasLearnRateFactor',2);
reluLayer();
averagePooling2dLayer(3,'Stride',2);
fc1;
reluLayer();
fc2;
softmaxLayer()
classificationLayer()];


%%
%

opts = trainingOptions('sgdm', ...
'InitialLearnRate', 0.001, ...
'LearnRateSchedule', 'piecewise', ...
'LearnRateDropFactor', 0.1, ...
'LearnRateDropPeriod', 8, ...
'L2Regularization', 0.004, ...
'MaxEpochs', 10, ...
'MiniBatchSize', 100, ...
'Verbose', true);

%%
%

[net, info] = trainNetwork(imds, layers, opts);

%%
%

rootFolder = 'cifar10Test';
imds_test = imageDatastore(fullfile(rootFolder, categories), ...
'LabelSource', 'foldernames');

labels = classify(net, imds_test);

%%
%

ii = randi(4000);
im = imread(imds_test.Files{ii});
imshow(im);
if labels(ii) == imds_test.Labels(ii)
   colorText = 'g'; 
else
colorText = 'r';
end
title(char(labels(ii)),'Color',colorText);

%%
%

confMat = confusionmat(imds_test.Labels, labels);
confMat = confMat./sum(confMat,2);
mean(diag(confMat))