function v = fisherLinearDiscriminant(X1, X2)

    m1 = size(X1, 1);
    m2 = size(X2, 1);

    mu1 = mean(X1);% mean value of X1
    mu2 = mean(X2); % mean value of X2

    S1 = cov(X1); % scatter matrix of X1
    S2 = cov(X2); % scatter matrix of X2

    Sw = (1/2)*(S1+S2); % Within class scatter matrix

    v = inv(Sw)/(mu1-mu2); % optimal direction for maximum class separation 

    v = v/norm(v); % return a vector of unit norm
