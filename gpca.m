  load('D:\kernelpreserve\data\tr45_690n_8261d_10c_tfidf_uni.mat');

X=X';
[m,n]=size(X);
k=10;
alphalist = [1/sqrt(max([m n]))];
 betalist = [1e-1 10 ];
 mulist=[ .1 10];
% betalist=1;
% mulist=1;
Y1 =zeros(m,n);
Y2 =zeros(m,n);
E = zeros(m,n);
Z = X;
  c = length(unique(y));
 L = diag(sum(K))-K;
% [gamma,distX] = cal_gamma(X,k);
for ii = 1:length(alphalist)
    alpha = alphalist(ii);
    for jj = 1:length(betalist)
        beta = betalist(jj);
       for ij=1:length(mulist)
           mu=mulist(ij);
            disp([alpha,beta,mu])
        for i = 1:200
            H = (X+Z-E-(Y1+Y2)/mu)/2;
           [U,sigma,V] = svd(H,'econ');
         D = U*(diag(max(diag(sigma)-1/(2*mu),0)))*V';   
           G = X - D -Y1/mu;
          E = max(abs(G)-alpha/mu,0).*sign(G);
           Z =(mu*D+Y2)/(2*beta*L+mu*eye(n));
            Y1 = Y1+mu*(D+E-X);
            Y2 = Y2+mu*(D-Z);
            mu=mu*1.1;
            if (norm(D+E-X,'inf')<1e-5) && (norm(D-Z,'inf')<1e-5)
            break
            end
            
        end
       
 ids=litekmeans(Z', c, 'Replicates', 500);
    result=ClusteringMeasure(ids ,y)
 dlmwrite('D:\kernelpreserve\gpcares\tr45.txt',[alpha,beta,mulist(ij),result],'-append','delimiter','\t','newline','pc');
%  
    end
    end
end
