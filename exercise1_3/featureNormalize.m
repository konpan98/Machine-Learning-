function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.



[rows,nFeature]=size(X);
mu =mean(X); % mean of each column (feature)
sigma =std(X); % standart deviation of each column

i=0;
j=0;
for i=1:nFeature
    for j=1:rows
        X_norm(j,i)=(X(j,i)-mu(1,i))/sigma(1,i);
        j=j+1;
    end
    i=i+1;
end

% ============================================================

end
