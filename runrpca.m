
addpath('D:\RPCA\data\');
addpath('D:\RPCA\result\');
% load('TDT2.mat');
% X=X';
[m,n]=size(X);
k=10;

%alpha = 0.01;
%beta = 0.01;
%   alphalist = [1/sqrt(max([m n]))];
  alphalist = [1e-2 1 10];
betalist = [ .1 10 100 ];
mulist = [  .1 10 100];
Y1 =zeros(m,n) ;
Y2 =zeros(m,n) ;
E = zeros(m,n);
Z = X;
distX = L2_distance_1(X,X);
[distX1, idx] = sort(distX,2);
 count=10;
for ii = 1:length(alphalist)
    alpha = alphalist(ii);
    for jj= 1:length(betalist)
             beta = betalist(jj);
  [gamma] = cal_gamma(X,distX1,beta,k);
        for ij=1:length(mulist)
            mu=mulist(ij);
            count=count+1;
             disp([alpha,beta,mu])
            for i = 1:200
                       D =  updateD(E,X,Y1,Y2,mu,Z,gamma);
            distX = L2_distance_1(D,D);
[distX1, idx] = sort(distX,2);
 [gamma] = cal_gamma(D,distX1,beta,k);
            E = updateE(D,E,X,Y1,mu,alpha);
            S = updateS(X,distX1,idx,k,gamma,beta);
            S=(S+S')/2;
            L = diag(sum(S))-S;
            Z = updateZ(L,beta,mu,D,Y2);
            Y1 = Y1+mu*(D+E-X);
            Y2 = Y2+mu*(D-Z);
            mu=mu*1.1;
                if (norm(D+E-X,'inf')<1e-5) && (norm(D-Z,'inf')<1e-5)
                    break
                end
            end
%             L=(S+S')/2;
%             actual_ids = spectral_clustering(L, c);

save(num2str(count),'E','Z')            
%             result=ClusteringMeasure(actual_ids ,y)
%             disp([alpha,beta,result])
% ids=litekmeans(Z', c,  'Replicates', 500);
% result=ClusteringMeasure(ids ,y)
%             dlmwrite('D:\RPCA\result\TDT2.txt',[alpha,beta,mulist(ij),result],'-append','delimiter','\t','newline','pc')
        end
    end
end







