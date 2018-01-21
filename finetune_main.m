clear
 load('C:\Users\User\Desktop\research\kernelclusteringexp\RMKKM\data\AR_840n_768d_120c_uni.mat');
 X=X';
[m,n]=size(X);
k=15;
%mu = .5; 
%alpha = 0.01;
%beta = 0.01;
%alphalist=1/sqrt(max([m n]));
  alphalist=[3 5 7];

betalist = [ .5  1 2];
mulist = [   .5 1 2];
Y1 =zeros(m,n) ;
Y2 =zeros(m,n) ;
E = zeros(m,n);
Z = X;
c = length(unique(y));
distX = L2_distance_1(X,X);
[distX1, idx] = sort(distX,2);
for ii = 1:length(alphalist)
    alpha = alphalist(ii);
    for jj = 1:length(betalist)
        beta = betalist(jj);
        [gamma] = cal_gamma(X,distX1,beta,k);
        for ij = 1:length(mulist)
        mu= mulist(ij);
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
        end

    actual_ids = spectral_clustering(S, c);

    result=ClusteringMeasure(actual_ids ,y);
    disp([result])
    end
end
end


    

    
    
    