clear; close all; clc;
Mean=[1.001251621	1.001524037	1.000991917]';

V=[ 0.000341714	0.000200283	0.000210142
    0.000200283	0.000349815	0.000232736
    0.000210142	0.000232736	0.000401844];

Ones=ones(size(Mean));

invV=inv(V);
A=Ones'*invV*Mean;
B=Mean'*invV*Mean;
C=Ones'*invV*Ones;
D=B*C-A^2;

g=(B*(invV*Ones)-A*(invV*Mean))/D;
h=(-A*(invV*Ones)+C*(invV*Mean))/D;
w=@(R) g+h*R;
Variance=@(R) (C*R.^2-2*A*R+B)/D;

figure(1)
R=linspace(0.9999,1.003,100);
plot(Variance(R),R);
xlabel('Variance'); ylabel('Return');
hold on
plot(diag(V),Mean,'+')


%portafoglio a varianza minima globale
w_min= (invV*Ones)/C
sigma2= w_min'*V*w_min;


%pto4 
rf=1.01;
t=  1:100; %ricchezza iniziale
b=0.001;
u = @(x) x-((b/2).*x^2);

w_e = (invV*(Mean-rf*Ones))/ (Ones'* invV*(Mean-rf*Ones))
E= w_e'*Mean;
var_re= w_e' * V * w_e;

w_opt= @(x) ((1-(b*rf*x))*(E - rf))/(b*(var_re + (E-rf)^2))

plot(t,w_opt(t))
xlabel('ricchezza investita'); ylabel('portafoglio ottimo');


%pto 5
a= 0.15;
t=1;
u = @(t) 1- exp(-a.*t);

w_ap= (1.001251621-rf)/(0.000341714*a); %apple = media -rf / varianza*a
w_am= (1.001524037-rf)/(0.000349815*a); 
w_fa= (1.000991917 - rf)/(0.000401844*a);


ue_ap= 1- exp( -a*(w_ap*1.001251621+ rf*(1-w_ap))+ 0.5*a^2*0.000341714*w_ap^2);
ue_am= 1- exp( -a*(w_am*1.001524037+ rf*(1-w_am))+ 0.5*a^2*0.000349815*w_am^2);
ue_fa= 1- exp( -a*(w_fa*1.000991917+ rf*(1-w_fa))+ 0.5*a^2*0.000401844*w_fa^2);

H_ap= (Mean(1,1)-rf)'* (1/(V(1,1)))*(Mean(1,1)-rf); tan_ap= sqrt(H_ap);
H_am= (Mean(2,1)-rf)'* (1/(V(2,2)))*(Mean(2,1)-rf); tan_am= sqrt(H_am);
H_fa= (Mean(3,1)-rf)'* (1/(V(3,3)))*(Mean(3,1)-rf); tan_fa= sqrt(H_fa);

