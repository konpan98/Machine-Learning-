function [e]=getWordEntropy(f)
    %Calculate the vector of word entropies e 
    %from the Term Frequency matrix f
    %Add your code here
   for i=1:size(f,1)
       for j=1:size(f,2)
           p(i,j)=f(i,j)/sum(f(:,j));
       end
   end
   
        
     e=1+(sum(p.*log(p+0.000001))/log(size(f,1)));
%         for j=1:size(f,2)
%             e(:,j)=1+ (sum(p(:,j)'*log(p(:,j)+0.0000001))/log(size(f,2)));
%         end
%         
     e=1+e;

end