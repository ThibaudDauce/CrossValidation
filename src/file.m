clear all
close all

% On génère les données
x = [1:10]';
y = randn(10, 1);

% RÉGRESSION LINÉAIRE
teta = polyfit(x, y, 1);
% teta(1) : coefficient directeur
% teta(2) : coordonnée à l'origine
teta2 = polyfit(x, y, 2);

figure(1)
hold on
plot(x, y, 'o');
plot(x, teta(1)*x + teta(2))
plot(x, teta2(1)*x.^2 + teta2(2)*x + teta2(3), 'r')
hold off


