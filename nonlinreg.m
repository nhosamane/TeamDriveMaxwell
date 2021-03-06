function [a b c d] = nonlinreg(flux)

clear all
tf=2*pi;
t=0:tf/100:tf;
flux=2.*sin(.00001.*t+1);
%parameters should be a=25, b=4, c=11,d=-12
x=t;
% Nonlinear regression by minimization of error
Sr=@(a,b,c,d) sum((flux-a*sin(b*t+c)+d).^2);
ig=flux(length(t-10));
sol=fminsearch(@(sol) Sr(sol(1),sol(2),sol(3),sol(4)),[2.1 .0004 1.5 -.2]);
% initial guess based on experimenting with values in excell

a=sol(1)
b=sol(2)
c=sol(3)
d=sol(4)

nonlinreg=@(x) a*sin(b*x+c)-d;
error=Sr(a,b,c,d)



plot(t,flux)
hold on
plot(t,nonlinreg(t),'r--')
hold off