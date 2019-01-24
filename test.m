addpath('D:\RPCA\data\');
addpath('D:\RPCA\CAN code\funs\');
addpath('D:\RPCA\CAN code\');
load('jaffe_213n_676d_10c_uni.mat');
c = length(unique(y));
[la, A, evs] = CAN(X', c);

result_can = ClusteringMeasure(y, la)
dlmwrite('D:\RPCA\result\CAN_jaffe_213n_676d_10c_uni.txt',[result_can],'-append','delimiter','\t','newline','pc')