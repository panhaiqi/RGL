function [gamma,distX] = cal_gamma(X,distX1,beta,k)
num = size(X,2);



A = zeros(num);
rr = zeros(num,1);
for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = beta/4*(k*di(k+1)-sum(di(1:k)));
end;

%if r <= 0
  %  r = mean(rr);
%end;
gamma = mean(rr);
end