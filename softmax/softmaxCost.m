function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, numClasses, inputSize);

numCases = size(data, 2);

groundTruth = full(sparse(labels, 1:numCases, 1));

thetagrad = zeros(numClasses, inputSize);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.

P = theta * data;
P = bsxfun(@minus, P, max(P, [], 1));
P = exp(P);
P = bsxfun(@rdivide, P, sum(P, 1));

% for i = 1:numClasses
%     thetagrad(i, :) = -1/numCases*sum(bsxfun(@times, data, groundTruth(i, :)-P(i, :)), 2)' + lambda*theta(i, :);
% end

thetagrad = -1/numCases*(groundTruth-P)*data' + lambda*thetagrad;

cost = -1/numCases*sum(sum(groundTruth.*log(P)))+lambda/2*(norm(theta, 'fro')^2);

% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
grad = [thetagrad(:)];
end

