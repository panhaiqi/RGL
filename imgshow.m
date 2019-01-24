% vec=130;col=160;
 %vec=144;col=176;
%vec=192;col=168;
 vec=128;col=160;
list=[1010 1371];
 for j=1:length(list)
 i=list(j);
   figure(1) 
a=reshape(X(:,i),vec,col);
b=reshape(Z(:,i),vec,col);
% E=X-Z;
c=reshape(E(:,i),vec,col);
subplot(1,3,1)
imshow(a,[],'border','tight')
subplot(1,3,2)
imshow(b,[],'border','tight')
subplot(1,3,3)
imshow(c,[],'border','tight')
pause
 end
