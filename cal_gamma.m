function [gamma,distX] = cal_gamma(X,k)
num = size(X,2);


distX = L2_distance_1(X,X);
%distX = sqrt(distX);
[distX1, idx] = sort(distX,2);
A = zeros(num);
rr = zeros(num,1);
for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
end;

%if r <= 0
  %  r = mean(rr);
%end;
gamma = mean(rr);
end