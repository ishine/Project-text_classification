
%% Load and preprocess data
clc;
clear;
close all;

disp('Load data...');

category = [11, 12, 13, 14, 16, 21, 22, 23, 24];
categoryNum = numel(category);
sampleNum = zeros(1, numel(category));
x = [];
y = [];
yy = [];
% color = [];

for i=1:categoryNum
    m = dlmread(['./features/', num2str(category(i)), '.txt']);
    sampleNum(i) = size(m, 1);
    x = [x; m];
    y = [y; ones(size(m, 1), 1)*i];
    indicator = zeros(size(m, 1), categoryNum);
    indicator(:, i) = 1;
    yy = [yy; indicator];
    %     color = [color; ones(size(m, 1), 1)*(2.^(i-1)-1)];
end

disp(['Sample num: ', int2str(sampleNum)]);
featureDim = size(x, 2);

% Remove unuseful features
xx = x(:, sum(x)~=0);
xx = [ones(sum(sampleNum), 1), xx];

% offset = 0;
% centroid = zeros(categoryNum, featureDim);
% for i=1:categoryNum
%     centroid(i, :) = sum(x(offset+1: offset+sampleNum(i), :))/sampleNum(i);
%     offset = offset + sampleNum(i);
% end

% dist = zeros(categoryNum, categoryNum);
% for i=1:categoryNum
%     for j=1:categoryNum
%         dist(i, j) = sum((centroid(i, :) - centroid(j, :)).^2);
%     end
% end

%% parameters
foldNum = 3;
disp('Logistic...');
lambda = 1e-4;
options.maxIter = 10000;
options.display = 'off';
k = 1;

%% Linear, Logistic, kNN
linearMaxAcc = 0;
softmaxMaxAcc = 0;
addpath(genpath('softmax'));
knnMaxAcc = 0;

for i=1:foldNum
    
    fprintf('Fold #%d\n', i);
    trainX = [];
    trainY = [];
    trainYY = [];
    testX = [];
    testY = [];
    %     testYY = [];
    delta = 0;
    for j=1:categoryNum
        randIdx = randperm(sampleNum(j));
        pos = floor(sampleNum(j)/foldNum);
        trainX = [trainX; xx(delta+randIdx(pos+1:end), :)];
        trainY = [trainY; y(delta+randIdx(pos+1:end), :)];
        trainYY = [trainYY; yy(delta+randIdx(pos+1:end), :)];
        testX = [testX; xx(delta+randIdx(1:pos), :)];
        testY = [testY; y(delta+randIdx(1:pos), :)];
        %         testYY = [testYY; yy(delta+randIdx(1:pos), :)];
        delta = delta + sampleNum(j);
    end
    
    % Linear regression
    disp('Linear...');
    beta = (trainX'*trainX)\trainX'*trainYY;
    [~, predictedY] = max(testX*beta, [], 2);
    %     beta = (xx'*xx)\xx'*yy;
    %     [~, yy] = max(xx*beta, [], 2);
    accuracy = mean(predictedY == testY)*100;
    if accuracy > linearMaxAcc, linearMaxAcc = accuracy; end
    
    % Logistic
    disp('Logistic...');
    softmaxModel = softmaxTrain(size(xx, 2), categoryNum, lambda, ...
        trainX', trainY, options);
    predictedY = softmaxPredict(softmaxModel, testX');    
    accuracy = mean(predictedY' == testY)*100;
    if accuracy > softmaxMaxAcc, softmaxMaxAcc = accuracy; end
    
    % kNN
    disp('kNN...');
    d2 = dist2(trainX, testX);
    [~, idx] = min(d2);
    predictedY = trainY(idx);
%     h = hist(predictedY, categoryNum);
%     [~, predictedY] = max(h);
    accuracy = mean(predictedY == testY)*100;
    if accuracy > knnMaxAcc, knnMaxAcc = accuracy; end
end
disp(['Linear acc.: ', num2str(linearMaxAcc, 4), '%']);
disp(['Logistic acc.: ', num2str(softmaxMaxAcc, 4), '%']);
disp(['kNN acc.: ', num2str(knnMaxAcc, 4), '%']);


%% Logistic
% disp('Logistic regression...');
% xx = x(:, sum(x)~=0);
% xx = [ones(sum(sampleNum), 1), xx];
% theta = mnrfit(xx, y);

%% SVM
disp('SVM...');
%addpath(genpath('libsvm'));
svmModel = svmtrain(y, xx, ['-v ', num2str(foldNum), ' -t 0 -q']);
% disp('Classify...');
% [yy] = libsvm_predict(y, x, svmModel, '-q');
% disp(['Accuracy: ', int2str(sum(yy == y)/numel(y)*100), '%']);

%% KMeans
%[idx, centroid, sumD] = kmeans(x, numel(category));

%% Visualization via 2d PCA
%  disp('2d PCA...');
%  [u, d, v] = svd(x);
%  coor = u*d;
%  scatter(coor(:, 1), coor(:, 2), 30, color);
