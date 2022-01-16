%%%%%%%%%%NAIVE BAYES CLASSIFIER
load('digits');
[x,y]=size(train0);
num_digits=10;
images=x;
train = cat(3, train0, train1, train2, train3, train4, train5, train6, train7, train8, train9);
trained = zeros(num_digits,  length(train(1,:,1)));
[training0,training1,training2,training3,training4,training5,training6,training7,training8,training9]=deal(zeros(1,y));
%%%%% prob p to use for bernoulli%%%%%%%%%%%%%%%%%%%%%%%%%%%
training0=mean(train0,1);
training1=mean(train1,1);
training2=mean(train2,1);
training3=mean(train3,1);
training4=mean(train4,1);
training5=mean(train5,1);
training6=mean(train6,1);
training7=mean(train7,1);
training8=mean(train8,1);
training9=mean(train9,1);
%%% concatenate the trained digits in one 'train' array
training=cat(1,training0,training1,training2,training3,training4,training5,training6,training7,training8,training9);

%%%%%%%%%%%%CLASSIFY USING NAIVE BAYES %%%%%%%%%%%%%%%%%%%%%%%
epsilon = 0.0000001; % use it when p=0 or p=1
likelihood=zeros(10,1);
classify=zeros(images,num_digits);

for i=1:num_digits
    test_hlp=take_array(i,test0,test1,test2,test3,test4,test5,test6,test7,test8,test9);
    for j=1:images
        Xi=test_hlp(j,:); %take test sample Xi to calculate bernoulli prob
        for k=1:num_digits
             Pi=(training(k,:)==0).*(training(k,:)+epsilon)+(training(k,:)>0 & training(k,:)<1).*training(k,:) + ...
               (training(k,:)==1).*(training(k,:)-epsilon);
            %Likelihood with log for better numbers
            likelihood(i)=sum( Xi .*log(Pi) + (1-Xi) .*log( 1-Pi));
            if(k==num_digits)
                [ML,class]=max(likelihood);
                classify(j,i)=class-1;
            end
            
        end
        
    end
end
 classify=classify-1;
%%visualize the samples using the estimators%%%%%%%%%%%%%%%%%
for i=1: num_digits
    subplot(2,5,i)
    A=reshape(training(i,:), 28, 28)';
    imagesc(A)
end

actual_classes=zeros(images,num_digits);
for i=1 : num_digits
    actual_classes(:,i) = i*ones(500,1);
end
actual_classes=actual_classes-1;

confusion_matrix=zeros(10,10);
for i=1:10
    for j=1:10
        for k=1:500
            actual_class=actual_classes(k,j);
            predicted_class=classify(k,j);
            confusion_matrix(predicted_class+1,actual_class+1)=confusion_matrix(predicted_class+1,actual_class+1)+1;
        end  
    end
end
fprintf('Confusion matrix:');
confusion_matrix
total_samples=500;
hlp=diag(confusion_matrix);
accuracy=sum(diag(confusion_matrix))/(100*total_samples);
fprintf('Accuracy is: %.4f %',accuracy);

