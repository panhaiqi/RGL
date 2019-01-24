clear
load('YALE_165n_1024d_15c_uni.mat');
X=X';
[m,n]=size(X);
%alphalist=[3 5 7];
% alphalist=[0.03];
%betalist = [ .5  1 2];
betalist = [0.01:0.01:0.19];
mulist =[15:1:17];
%mu = .5; 
%alpha = 0.01;
%beta = 0.01;
alphalist=1/sqrt(max([m n]));
k =5;
Y1 =zeros(m,n) ;
Y2 =zeros(m,n) ;
E = zeros(m,n);
Z = X;
c = length(unique(y));
distX = L2_distance_1(X,X);
[distX1, idx] = sort(distX,2);
r = 0.5;
for ii = 1:length(alphalist)
%for ii = 15.241:0.001:15.249
    alpha = alphalist(ii);
    %alpha = ii;
    for jj = 1:length(betalist)
%     for jj = 0.002:0.001:0.009
        beta = betalist(jj);
%         beta = jj;
        for ij = 1:length(mulist)
        %for ij = 11.1:0.1:11.9
            mu= mulist(ij);
            %mu = ij;
            disp([alpha,beta,mu])
            [result] = slkessemi(X,y,alpha,beta,mu,E,Y1,Y2,Z,k,distX1,r);
            meanacc=mean(result)
            stdacc=std(result)
            dlmwrite('binaryalphadigs_1404n_320d_36c.txt',[alpha,beta,mu,r,k,meanacc,stdacc],'-append','delimiter','\t','newline','pc');
        end
    end
end
        
        
        
        
        
        