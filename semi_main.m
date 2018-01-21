clear
load('D:\RPCA\data\COIL20_1440n_1024d_20c.mat');
alphalist=[3 5 7];

betalist = [ .5  1 2];
mulist = [   .5 1 2];
X=X';
[m,n]=size(X);
k=15;
%mu = .5; 
%alpha = 0.01;
%beta = 0.01;
%alphalist=1/sqrt(max([m n]));

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
        for ij = 1:length(mulist)
            mu= mulist(ij);
            disp([alpha,beta,mu])
            [result] = slkessemi('COIL20_1440n_1024d_20c.txt',X,y,alpha,beta,mu,E,Y1,Y2,Z,k,distX1);
        end
    end
end
        
        
        
        
        
        