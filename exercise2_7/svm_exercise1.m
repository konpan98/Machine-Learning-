clear all
close all

% C = 10000; % Choose C = 0.01, 0.1, 1, 10, 100, 1000, 10000

load('twofeature1.txt');
n = size(twofeature1, 1) - 1; % leave out the last example
y = twofeature1(1:n, 1);
X = twofeature1(1:n, 2:3);

Xpos = X(y==1, :); % positive examples
Xneg = X(y==-1, :); % negative examples

%  Visualize the example dataset
hold on
plot(Xpos(:, 1), Xpos(:, 2), 'b.');
plot(Xneg(:, 1), Xneg(:, 2), 'r.');
hold off
axis square;

% Form the matrices for the quadratic optimization. See the matlab manual for "quadprog"
H = zeros(n,n);
for i=1:n
    for j=i:n
        H(i,j) = y(i)*y(j)*X(i,:)*X(j,:)';
        H(j,i) = H(i,j);
    end
end

f = -ones(n, 1);
%%% inequality  constraints
A = -diag(ones(n, 1)) ;% take the diag beacause number of columns in a = number of elements in f

b =zeros(n,1);
%%% equality  constraints
Aeq =y' ;

beq =0 ;

lambda = quadprog(H, f, A, b, Aeq, beq); % Find the Lagrange multipliers

indices = find(lambda > 0.0001); % Find the support vectors
Xsup = X(indices,:); % The support vectors only 
ysup =y(indices,:); 
lambdasup = lambda(indices,:);
[sup_vectors,~]=size(indices);
% Find the weights
w=0;
for i=1:sup_vectors
w = w +Xsup(i,:)'.*ysup(i,:).*lambdasup(i);
end

% w = sum(Xsup'*ysup*lambdasup', 1);
% Find the bias term w0
w0 = mean(ysup' - w'*Xsup');



% Plot support vectors
Xsup_pos = Xsup(ysup==1, :);
Xsup_neg = Xsup(ysup==-1, :);

hold on
plot(Xsup_pos(:, 1), Xsup_pos(:, 2), 'bo');
plot(Xsup_neg(:, 1), Xsup_neg(:, 2), 'ro');
hold off


% % Find the width of the margin
width = 2/norm(w);

% Plot decision boundary
x1 = linspace(0.5, 4.5, 100);
%solve s.t x2
x2 = -(w(1)*x1 + w0)/w(2);
hold on
plot(x1, x2, 'k')
plot( x1,x2+width/2 ,'b')  %Plot the Margin of class +1
plot( x1,x2-width/2  ,'r')  %Plot the Margin of class -1
hold off


