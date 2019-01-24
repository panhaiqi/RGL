function [A] = updateS(X,distX,idx,k,gamma,beta)

num = size(X,2);


%distX = L2_distance_1(X,X);
%distX = sqrt(distX);
%[distX1, idx] = sort(distX,2);
A = zeros(num);

%A0 = (A+A')/2;
%D0 = diag(sum(A0));
%L0 = D0 - A0;
%[F, temp, evs]=eig1(L0, c, 0);



%for iter = 1:NITER
    %distf = L2_distance_1(F',F');

% for i=1:num
%      idxa0 = 1:num;
%         %dfi = distf(i,idxa0);
%     dxi = distX(i,idxa0);
%         %ad = -(dxi+lambda*dfi)/(2*r);
%     ad = -dxi*beta/(4*gamma);
%     A(i,idxa0) = EProjSimplex_new(ad);
% end;



for i=1:num
     di = distX(i,2:k+2);
    sumk=0;
   for j=1:k
    sumk=sumk+di(j);
   end
    for j=1:k
   A(i,idx(i,j+1))=(di(k+1)-di(j))/(k*di(k+1)-sumk);
    end
end


