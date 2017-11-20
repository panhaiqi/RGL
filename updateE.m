function [E] = updateE(D,E,X,Y1,mu,alpha)
G = X - D -Y1/mu;
E = max(abs(G)-alpha/mu,0).*sign(G);

end