function [A] = updateS(X, distX,gamma,beta)

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
A = zeros(num);
for i=1:num
     idxa0 = 1:num;
        %dfi = distf(i,idxa0);
    dxi = distX(i,idxa0);
        %ad = -(dxi+lambda*dfi)/(2*r);
    ad = -dxi*beta/(4*gamma);
    A(i,idxa0) = EProjSimplex_new(ad);
end;




