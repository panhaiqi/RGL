function [Z] = updateZ(L,beta,mu,D,Y2)
n=size(L,2);
Z =(mu*D+Y2)/(2*beta*L+mu*eye(n));
end