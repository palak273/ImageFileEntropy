clc
clear all
close all
myFolder = 'C:\Users\palak\Pictures\Saved Pictures';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);
index = 1;
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArr = im2bw(imread(fullFileName));
  data = imageArr(:);
  min_entropy_MCV(index) = mostCommonValueEst(data);
  min_entropy_markov(index) = markovEst(data);
  min_entropy_collision(index) = collisionEst(data);
  min_entropy_compression(index) = compressionEst(data);
  index = index+1;
end
figure
plot(0:24,min_entropy_MCV)
hold on
plot(0:24,min_entropy_markov)
hold on 
plot(0:24,min_entropy_collision)
hold on
plot(0:24,min_entropy_compression)
legend('MCV','markov','collision','compression')
xlim([0 24])
legend('Location','bestoutside')