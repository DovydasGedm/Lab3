clear all;
clc;

% Aproksimuojama funkcija
x = 0.1:1/22:1;
h = (1 + 0.6*sin(2*pi*x/0.7)) + (0.3*sin(2*pi*x))/2;

% generate random initial values of w1, w2 and b
wR1 = randn(1);
wR2 = randn(1);
bR = randn(1);
wA1 = randn(1);
wA2 = randn(1);
bA = randn(1);

nu = 0.1;
alpha = 0.0001;
gama = 0.00001;

% Centru ir spinduliu reiksmes
c1 = 0.535;
r1 = 0.15;
c2 = 0.45;
r2 = 0.9;

% Apmokomas RBF tinklas, neatnaujinant centru ir spinduliu 
for a = 1:900000
for i = 1:20
FR1 = exp(-(x(i)-c1)^2/(2*(r1^2)));
FR2 = exp(-(x(i)-c2)^2/(2*(r2^2)));
yR(i) = FR1*wR1 + FR2*wR2 + bR;

% calculate the error
eR(i) = h(i) - yR(i);

% Atnaujinimas 
wR1 = wR1 + nu*eR(i)*FR1;
wR2 = wR2 + nu*eR(i)*FR2;
bR = bR + nu*eR(i);
end
end

for j = 1:20
FR1 = exp(-(x(j)-c1)^2/(2*(r1^2)));
FR2 = exp(-(x(j)-c2)^2/(2*(r2^2)));
yR(j) = FR1*wR1 + FR2*wR2 + bR;
end

figure(1);
plot(x,h);
hold on
plot(x,yR);
hold off
title('RBF apmokytas centrus ir spindulius parenkant rankiniu budu')

% Apmokomas RBF tinklas, atnaujinant centrus ir spindulius 
for a = 1:900000
for i = 1:20
FA1 = exp(-(x(i)-c1)^2/(2*(r1^2)));
FA2 = exp(-(x(i)-c2)^2/(2*(r2^2)));
yA(i) = FA1*wA1 + FA2*wA2 + bA;

% calculate the error
eA(i) = h(i) - yA(i);

% Atnaujinimas 
wA1 = wA1 + nu*eA(i)*FA1;
wA2 = wA2 + nu*eA(i)*FA2;
bA = bA + nu*eA(i);
c1 = c1 + alpha * (4*eA(i)/r1*wA1*(x(i) - c1)*FA1);
r1 = r1 + gama * (4*eA(i)/r1*wA1*(x(i)-c1)^2*FA1);
c2 = c2 + alpha * (4*eA(i)/r2*wA2*(x(i) - c2)*FA2);
r2 = r2 + gama * (4*eA(i)/r2*wA2*(x(i)-c2)^2*FA2);
end
end

for j = 1:20
FA1 = exp(-(x(j)-c1)^2/(2*(r1^2)));
FA2 = exp(-(x(j)-c2)^2/(2*(r2^2)));
yA(j) = FA1*wA1 + FA2*wA2 + bA;
end

figure(2);
plot(x,h);
hold on
plot(x,yA);
hold off
title('RBF apmokytas su centru ir spinduliu atnaujinimu naudojant LMS')


  


