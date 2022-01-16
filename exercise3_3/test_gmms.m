load fisheriris.mat

X = meas;
N = size(X, 1); % number of examples
species

K = 3; % Number of classes

[Pm, M, S,kacc] = fitGMMs(X, K);

Y_hat = zeros(N, 1);
for i = 1:N
    Y_hat(i, 1) = classify_with_gmms(X(i, :), Pm, M, S);
end

Y_hat
Yspecies=[Y_hat(1:50) Y_hat(51:100) Y_hat(101:150)];
accuracy=0;
for k=1:K
    cat=Yspecies(:,k);
    for j=1:K
        more(j)=length(find(cat==j));
    end
    [~,best]=max(more);
    accuracy=accuracy +sum(cat==best);
end
fprintf('EM vs k-means:\n');
fprintf('K-means accuracy is :%4f\n',kacc);
fprintf('EM accuracy is :%4f',accuracy/N);