%Costruisci la frontiera dei portafogli B utilizzando solo Facebook ed Apple
clc; clear all; close all;

Mean=[1.001251621	1.000991917]';

V=[0.000341714	0.000210142
    0.000210142	0.000401844];

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
sigma2= w_min'*V*w_min