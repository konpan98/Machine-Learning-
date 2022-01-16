function p = gaussian(x, m, S)
    %  returns the pdf value of point x, where m determines the mean and
    %  S determines the covariance of the multivariate normal distribution.
    
    % your code here
%    p=(1/(sqrt(2*pi*S)))*exp((-(x-m).^2)/(2*S));
     p=mvnpdf(x,m,S);
end
