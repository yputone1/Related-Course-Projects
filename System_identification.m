clc;
clear;
close all;
%%
T0 = 0 ;
Ts = 0.1 ;
Tf = 200 ;
t = T0:Ts:Tf ; t = t' ;
N = numel(t) ;
y = zeros(size(t)) ; y(1) = 1 ;
e = wgn(2001,1,1);
a = 0.5 ;c = 0.6;
Nc = 2 ;
teta = zeros(Nc , N) ; teta(: , 1) = randn(Nc,1) ;
P = 100 * eye(Nc);
phii = zeros(Nc , N) ;
for i = 3:N
    y(i) = -a * y(i-1) + e(i) + c*e(i-1);
    phii(: ,i) = [y(i-1) , y(i-1)-phii(: , i-1)'*teta(: ,i-1)]' ;
    
end
%%
[thm,yhat,P,phi] = rarx([y e],[Nc 0 1],'ff',0.98,[0 0],P, phii(: ,1));%forget factor of 0.98
a=thm(:,1);
c=thm(:,2);

[thm1,yhat1,P1,phi1] = rarx([y e],[Nc 0 1],'ff',0.64,[0 0],P, phi(: ,1));%forget factor of 0.64

a1=thm1(:,1);
c1=thm1(:,2);
%%
figure
subplot(2,2,[1 2])
plot(t,c,'--')
hold on
plot(t,a);
xlabel('Time');
ylabel('Amp');
legend('c','a','location','best');
title('estimates by forget factor of 0.98');

subplot(2,2,[3 4])
plot(t,c1,'--')
hold on
plot(t,a1);
xlabel('Time');
ylabel('Amp');
legend('c','a','location','best');
title('estimates by forget factor of 0.64');

figure
plot(t,yhat,'-.');
hold on
plot(t,y,':');
xlabel('Time');
ylabel('Amp');
legend('estimated Output','Output','location','best');