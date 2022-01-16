function y = classify_with_gmms(x, Pm, M, S)
    %
    % INPUT:
    %   x: (1 X d) An example vector of dimension d
    %   Pm: (K X 1) mixing probabilities
    %   M: (K X d) mean vectors
    %   S: (K X d X d) covariance matrices
    %
    % OUTPUT:
    %   y:  The class index  
      
        for k=1 :size(M,1) 
            lhood(k)=Pm(k).*gaussian(x,M(k,:),S(:,:,k));
            if(k==size(M,1))
               [~,class]=max(lhood);
            end
        end
        y=class;

    % your code here

    
