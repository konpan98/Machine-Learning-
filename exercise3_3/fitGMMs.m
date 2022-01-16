function [Pm, M, S,kaccuracy] = fitGMMs(X, K)
    %
    % INPUT:
    %   X: (N X d) N example vectors of dimension d
    %   K: number of GMM components
    %
    % OUTPUT:
    %   Pm: (K X 1) mixing probabilities
    %   M: (K X d) mean vectors
    %   S: (K X d X d) covariance matrices 
    
  
      
    [N, d] = size(X);
    convergence=1e-11;
    % Initialize using kmeans. You may use the matlab kmeans.
    % your code here
    [index,centroids]=kmeans(X,K);
    for k=1:K
        cluster_index=find(index==k);
        Pm(k)=length(X(cluster_index, :)) / N;
        M(k,:)=centroids(k,:);
        S(:,:,k)=cov (X(cluster_index,:));
    end
    %compute accuracy for k-means 
    Xspecies=[index(1:50) index(51:100) index(101:150)];
    accuracy=0;
    for k=1:K
        cat=Xspecies(:,k);
        for j=1:K
            more(j)=length(find(cat==j));
        end
        [~,best]=max(more);
        accuracy=accuracy +sum(cat==best);
    end
    kaccuracy=accuracy/N;
    G = zeros(N, K); % likelihood of classes given features
    loglikelihood=zeros(101,1);
    for its = 2:101
        % E-step. Calculation of likelihood 'G'
        % your code here  
        %posterior probabilities
        for k=1:K
            Sreg=reshape(S(:,:,k),d,d);
            p=gaussian(X,M(k,:),Sreg);
            Gbnorm(:,k)=Pm(k).*p;
        end
          
        % Likelihood normalization (of G)
        % your code here 
        responsibilities=sum(Gbnorm,2);
        for k=1:K
            G(:,k)=Gbnorm(:,k)./responsibilities;
        end
        % M-step. Parameter updates
        % your code here
        Nk=sum(G);
        for k=1:K
            %Mknew
%             for i=1:d
            M(k,:)=(1/Nk(k)).*sum(repmat(G(:,k),1,d).*X);
%             end
            %Pmnew
%             Pm(k)=Nk(k)./N;
%             %Sknew
            Snew=zeros(d,d);
            for i=1:N
            Snew=Snew+G(i,k).*(X(i,:)-M(k,:))'*(X(i,:)-M(k,:)); 
            end
            S(:,:,k)=(1/Nk(k))*Snew;
%           S(:,:,k)=zeros(d,d);
%           for i=1:N
%               S(:,:,k)=S(:,:,k)+G(i,k).*(X-repmat(M(k,:),N,1))'*(X-repmat(M(k,:),N,1));
%           end
%           S(:,:,k)=S(:,:,k)./Nk(k);
            %Evaluate log likelihood
            logsumG=log(sum(Gbnorm,2));
            loglikelihood(its)=sum(logsumG);
            if(abs(loglikelihood(its)-loglikelihood(its-1))<convergence*abs(loglikelihood(its)))
                break;
            end

        end
    end 
