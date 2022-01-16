function [test_z] = KNN_classify(k, train_f, train_y, test_f, dtype)
   % K-NN classification algorithm
   % k: Number of nearest neighbours
   % train_f: The matrix of training feature vectors
   % train_y: The labels of the training data
   % test_f: The matrix of the test feature vectors
   % dtype: Integer which defines the distance metric
   %    dtype=1: Call the function Euclidean_Distance
   %    dtype=2: Call the function CosineSimilarity_Distance
 
   % Add your code here
   if(dtype==1)
       for i=1:size(test_f,1)
       distance(i,:)=Euclidean_Distance(test_f(i,:),train_f);
       [~,index(i,:)]=sort(distance(i,:));
       end
      
   end
   if(dtype==2)
       for i=1:size(test_f,1)
       distance(i,:)=CosineSimilarity_Distance(test_f(i,:),train_f);
       [~,index(i,:)]=sort(distance(i,:),'descend');
       end
      
   end
   k_nearest=index(:,1:k);
   for i=1:size(k_nearest,1)
       classes=unique(train_y);
       for j=1:length(classes)
           ki(j)=sum(train_y(k_nearest(i,:))==classes(j));
           if(j==length(classes))
               [~,label]=max(ki);
           end
       end
       classified(i)=label;
   end


   
   
  test_z=classified';
   
end
   
 
