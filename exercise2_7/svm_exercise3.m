clear all
close all

C = 0.1; % Choose C = 0.01, 0.1, 1, 10, 100, 1000, 10000

load('twofeature2.txt');
n = size(twofeature2, 1); 
y = twofeature2(1:n, 1);
X = twofeature2(1:n, 2:3);

% Form the augmented dataset. 
Xa = [ X , X(:, 1).^2 + X(:, 2).^2];

Xpos = Xa(y==1,  :); % positive examples
Xneg = Xa(y==-1, :); % negative examples

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
A = [ -diag(ones(n, 1)) ; diag(ones(n, 1))];

b = [ zeros(n,1); C*ones(n, 1) ];
%%% equality  constraints
Aeq = y';

beq = 0;
%% low bounds and upper bounds for x1,x2
lb=zeros(n,1);
ub=C*ones(n,1);
lambda = quadprog(H, f, A, b, Aeq, beq,lb,ub); % Find the Lagrange multipliers

indices     = find(lambda > 0.0001); % Find the support vectors
Xsup        = Xa(indices, :);         % The support vectors only 
ysup        = y(indices, :);
lambdasup   = lambda(indices);
[sup_vectors,~]=size(indices);

% Find the weights
w=0;
for i=1:sup_vectors
w = w +Xsup(i,:)'.*ysup(i,:).*lambdasup(i);
end
% Find the bias term w0
w0 = mean(ysup' - w'*Xsup');

% Plot support vectors
Xsup_pos = Xsup(ysup==1, :);
Xsup_neg = Xsup(ysup==-1, :);


hold on
plot(Xsup_pos(:, 1), Xsup_pos(:, 2), 'bo');
plot(Xsup_neg(:, 1), Xsup_neg(:, 2), 'ro');
hold off


% Plot decision boundary
hold on
for x1 = -1:0.01:1
    for x2 = -1:0.01:1
        if (abs(w*[x1, x2, x1^2 + x2^2] + w0) < 0.01) % fill the 3rd coordinate
           plot(x1, x2, 'k.')
        end
    end
end

hold off


