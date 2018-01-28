clear
load('D:\RPCA\data\jaffe_213n_676d_10c_uni.mat');
X=X';
[m,n]=size(X);
%alphalist=[3 5 7];
alphalist=[1/sqrt(max([m n]))];
%betalist = [ .5  1 2];
betalist = [ .5  1 2];
%mulist = [   .5 1 2];
mulist =[.5 1 10 20];

k=10;
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
r = 0.3;
for ii = 1:length(alphalist)
%for ii = 15.241:0.001:15.249
    alpha = alphalist(ii);
    %alpha = ii;
    for jj = 1:length(betalist)
    %for jj = 0.4:0.01:0.5
        beta = betalist(jj);
        %beta = jj;
        for ij = 1:length(mulist)
            mu= mulist(ij);
            disp([alpha,beta,mu])
            [result] = slkessemi(X,y,alpha,beta,mu,E,Y1,Y2,Z,k,distX1,r);
            meanacc=mean(result)
            stdacc=std(result)
            dlmwrite('jaffe_213n_676d_10c_uni.txt',[alpha,beta,mu,r,k,meanacc,stdacc],'-append','delimiter','\t','newline','pc');
        end
    end
end
        
        
        
        
        
        