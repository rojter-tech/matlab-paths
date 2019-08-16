ii = randi(4000);
im = imread(imds_test.Files{ii});
imshow(im);
if labels(ii) == imds_test.Labels(ii)
   colorText = 'g'; 
else
colorText = 'r';
end
title(char(labels(ii)),'Color',colorText);

confMat = confusionmat(imds_test.Labels, labels);
confMat = confMat./sum(confMat,2);
mean(diag(confMat))