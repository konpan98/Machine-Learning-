function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA

	%A=zeros(NumFeatures,NewDim);
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes)  %The number of classes

    %For each class i
	%Find the necessary statistics
     Sw=zeros(NumFeatures);
     Sb=zeros(NumFeatures);
     
     m0=mean(Samples);
    
    for i=1:NumClasses
      %Calculate the Class Prior Probability
        P(i) = sum(Labels==i-1)/NumSamples;
        %Calculate the Class Mean 
        mu = mean(Samples(Labels==i-1,:));
      
        %Calculate the Within Class Scatter Matrix
        Sw = Sw + P(i)*cov(Samples(Labels==i-1,:));      
        %Calculate the Between Class Scatter Matrix
        Sb = Sb + P(i)*(mu-m0)'*(mu-m0);  
    end
    
    
    
  
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = inv(Sw)*Sb;
    %Perform Eigendecomposition
    [eigenvectors,eigenvalues]=eig(EigMat);
    [sortedeigvalues,index]=sort(diag(eigenvalues),'descend');%return the index in order to get the bigger newdim eigenvalues
    bigeigval=index(1:NewDim);
    
    
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	%A=zeros(NumFeatures,NewDim);  % Return the LDA projection vectors
     A=eigenvectors(:,bigeigval);
