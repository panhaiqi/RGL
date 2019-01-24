clear
% addpath('D:\RPCA\');
load('D:\RPCA\data\YALE_165n_1024d_15c_uni.mat');
X=X';
[m,n]=size(X);
% alphalist=[0.151:0.001:0.169];
alphalist=[1/sqrt(max([m n]))];
%betalist = [ .5  1 2];
betalist = [1e-7 1e-6 1e-5 0.0001 0.001 0.01 0.1 1];
%mulist = [   .5 1 2];
mulist =[0.5 1];

klist=[5 10 15 20];
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
rlist = [0.1 0.3 0.5];
% r = 0.5;
for rr = 1:length(rlist)
    r = rlist(rr);
    for bb = 1:length(betalist)
        beta = betalist(bb);
        for ii = 1:length(alphalist)
            alpha = alphalist(ii);
            for ij = 1:length(mulist)
                mu= mulist(ij);
%             for rr = 1:length(rlist)
%                 r = rlist(rr);
                    for kk = 1:length(klist)
                        k = klist(kk);
                   
                        [result] = slkessemi(X,y,alpha,beta,mu,E,Y1,Y2,Z,k,distX1,r);
                        meanacc=mean(result);
                        stdacc=std(result);
                        disp([alpha,beta,mu,r,k,meanacc,stdacc])

                        dlmwrite('YALE_165n_1024d_15c_uni_new.txt',[alpha,beta,mu,r,k,meanacc,stdacc],'-append','delimiter','\t','newline','pc');
                    end
%             end
            end
        end
    end
end
                    