
load('YALE_165n_1024d_15c_uni.mat');
X=X';
[m,n]=size(X);
k=10;
mu = .5; 
alpha = 100;
beta = 1;
Y1 =zeros(m,n) ;
Y2 =zeros(m,n) ;
E = zeros(m,n);
Z = X;
c = length(unique(y));
[gamma,distX] = cal_gamma(X,k);
for i = 1:200
    D =  updateD(E,X,Y1,Y2,mu,Z,gamma);
    E = updateE(D,E,X,Y1,mu,alpha);
    S = updateS(X,distX, gamma,beta);
    L = diag(sum(S))-S;
    Z = updateZ(L,mu,D,Y2);
    Y1 = Y1+mu*(D+E-X);
    
    Y2 = Y2+mu*(D-Z);
    mu=mu*1.1;
end

L=(S+S')/2;
actual_ids = spectral_clustering(L, c);

result=ClusteringMeasure(actual_ids ,y)
    

    
    
    