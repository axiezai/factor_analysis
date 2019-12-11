
%-----------------------------------------------------------------------

function [a,lam,xbar]=bfa(y,nl,nem,a_init,lam_init);

% vb-em algorithm for inferring the factor analysis model   y = a*x + v
%
% y(nk,nt) = data
% a(nk,nl) = mixing matrix
% lam(nk,nk) = diagonal noise precision matrix 
% alp(nl,nl) = diagonal hyperparmaeter matrix 
% xbar(nl,nt) = posterior means of the factors 
%
% nk = number of data points
% nt = number of time points
% nl = number of factors
% nem = number of em iterations

% use no more than 5 factors

nk=size(y,1);
nt=size(y,2);

% initialize by svd

ryy=y*y';
if a_init==0
   [p d q]=svd(ryy/nt);d=diag(d);
   a=p*diag(sqrt(d));
   a=a(:,1:nl);
   lam=diag(nt./diag(ryy));
else
   a=a_init;
   lam=lam_init;
end

% em iteration

like=zeros(nem,1);
alapsi=a'*lam*a; % intermediate variable, a lambda a transposed psi

for iem=1:nem
   gam=alapsi+eye(nl);
   igam=inv(gam);
   xbar=igam*a'*lam*y;

   ldlam=sum(log(diag(lam/(2*pi))));
   ldgam=sum(log(svd(gam)));
   like(iem)=.5*nt*(ldlam-ldgam)-.5*sum(sum(y.*(lam*y)))+.5*sum(sum(xbar.*(gam*xbar)));

   subplot(3,3,7);plot((1:iem)',like(1:iem));title('bfa');ylabel('bfa');
   subplot(3,3,9);plot(1./diag(lam));
   drawnow;

   ryx=y*xbar';
   rxx=xbar*xbar'+nt*igam;
   psi=inv(rxx);
   a=ryx*psi;
   lam=diag(nt./diag(ryy-a*ryx'));
   alapsi=a'*lam*a;
end

return



%-----------------------------------------------------------------------




