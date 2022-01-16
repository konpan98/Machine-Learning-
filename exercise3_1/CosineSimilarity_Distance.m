function dists = CosineSimilarity_Distance(testX, trainX)
%     Compute the Cosine Similarity distance between the 
%     current test sample and all training samples
%
% 	  testX: a single feature vector (test)
% 	  trainX: a matrix containing the set of training samples
%     dists: vector of the distances from the training samples

% ADD your code here
for i=1:size(trainX,1)
%     norm(testX)
%     norm(trainX(i,:))
    dists(:,i)=(sum(testX.*trainX(i,:),2))/(sqrt((sum((testX).^2,2)))*sqrt(sum((trainX(i,:)).^2,2)));
end


end
