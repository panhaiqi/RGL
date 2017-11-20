function [Z] = updateZ(L,mu,D,Y2)
n=size(L,2);
Z =(mu*D+Y2)/(2*L+mu*eye(n));
end