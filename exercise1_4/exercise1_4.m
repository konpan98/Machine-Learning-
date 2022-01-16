data_file = './data/mnist.mat';

data = load(data_file);

images = zeros(size(data.trainX, 1), 28, 28);
labels = zeros(size(data.trainY, 1), 1);

for i = 1:size(data.trainX, 1)
    img = data.trainX(i, :);
    images(i, :, :) = reshape(img, 28, 28)';
    labels(i) = data.trainY(i);
end

digit_C1_indices = find(labels == 1); % digit 1
digit_C2_indices = find(labels == 2); % digit 2

digit_C1_images = images(digit_C1_indices, :, :);
digit_C2_images = images(digit_C2_indices, :, :);

    
aRatios = zeros(size(data.trainX, 1), 1); 
allimages=size(data.trainX,1);
% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)
for i=1:allimages
    icon=reshape(images(i,:,:),28 ,28); %take each image and make it two dimensional in order to compute aRatio
    aRatios(i)=computeAspectRatio(icon);
end
    
aRatiosC1 = aRatios(digit_C1_indices);
aRatiosC2 = aRatios(digit_C2_indices);
allaRatios=[aRatiosC1;aRatiosC2];

minAspectRatio = min(allaRatios);
fprintf('Minimum Aspect Ratio is:%.4f\n',minAspectRatio);
maxAspectRatio = max(allaRatios);
fprintf('Maximum Aspect Ratio is:%.4f\n',maxAspectRatio);
numBins = 3;

binEnds = linspace(minAspectRatio, maxAspectRatio, numBins+1);

C1_bins = zeros(numBins, 1);
C2_bins = zeros(numBins, 1);
all_bins = zeros(numBins, 1);
Low = [minAspectRatio, minAspectRatio+(maxAspectRatio-minAspectRatio)/3];
Medium = [minAspectRatio+(maxAspectRatio-minAspectRatio)/3, minAspectRatio+2*(maxAspectRatio-minAspectRatio)/3];
High = [minAspectRatio+2*(maxAspectRatio-minAspectRatio)/3, minAspectRatio];

% Use the findBin function to get the counts for the histogram
binsC1=findBin(aRatiosC1,binEnds);
binsC1sorted=sort(binsC1,'ascend');
binsC2=findBin(aRatiosC2,binEnds);
binsC2sorted=sort(binsC2,'ascend');
figure
hold on;
histogram(categorical(binsC1sorted,[1 2 3],{'Low','Medium','High'}));
histogram(categorical(binsC2sorted,[1 2 3],{'Low','Medium','High'}));
legend('C1','C2');
title('Histogramms of images from C1 and C2');
hold off;

    
% Prior Probabilities
PC1 = sum(labels == 1)/(sum(labels));
fprintf('\nPrior probability for C1 is %.4f',PC1);
PC2 = sum(labels == 2)/(sum(labels));
fprintf('\nPrior probability for C2 is %.4f',PC2);

% Likelihoods
PLlikeC1 = sum(aRatiosC1<=Low(end))/size(aRatiosC1,1);
PMlikeC1 = sum(aRatiosC1>=Medium(1) & aRatiosC1<=Medium(end))/size(aRatiosC1,1);
PHlikeC1 = sum(aRatiosC1>=High(1))/size(aRatiosC1,1);
fprintf('\n Likelihoods For C1:\t')
fprintf(' P(L|C1)=%.4f  P(M|C1)=%.4f  P(H|C1)=%.4f\n', PLlikeC1,PMlikeC1,PHlikeC1);

PLlikeC2 = sum(aRatiosC2<=Low(end))/size(aRatiosC2,1);
PMlikeC2 = sum(aRatiosC2>=Medium(1) & aRatiosC2<=Medium(end))/size(aRatiosC2,1);
PHlikeC2 = sum(aRatiosC2>=High(1))/size(aRatiosC1,1);
fprintf('\n Likelihoods For C2:\t')
fprintf(' P(L|C2)=%.4f  P(M|C2)=%.4f  P(H|C2)=%.4f\n', PLlikeC2,PMlikeC2,PHlikeC2);


% Evidence 
PL=PLlikeC1*PC1+PLlikeC2*PC2;
PM=PMlikeC1*PC1+PMlikeC2*PC2;
PH=PHlikeC1*PC1+PHlikeC2*PC2;

fprintf('\n Evidence probabilities:\t')
fprintf(' P(L)=%.4f  P(M)=%.4f  P(H)=%.4f\n', PL,PM,PH);

% Posterior Probabilities
PC1givenL = (PLlikeC1*PC1)/PL;
PC2givenL = (PLlikeC2*PC2)/PL;
fprintf('\n Posterior probabilities:\t')
fprintf(' P(C1|x=L=%.4f  P(C2|X=L)=%.4f',PC1givenL,PC2givenL);

