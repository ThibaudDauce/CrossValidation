clear all
close all

% On génère les données
disp('Generation des donnees');
x = [1:10]';
y = randn(10, 1);

% RÉGRESSION LINÉAIRE
teta = polyfit(x, y, 1);

% REGRÉSSION QUADRATIQUE
teta2 = polyfit(x, y, 2);

figure(1)
hold on
plot(x, y, 'o');
plot(x, teta(1)*x + teta(2), 'g')
plot(x, teta2(1)*x.^2 + teta2(2)*x + teta2(3), 'r')
title("Donnees et fonctions de regression lineaire(g) et quadratique(r)");
hold off

% Testset validation
% On prend 30% de l'échantillon (échantillon de test)
% Les 70% restant sont l'échantillon d'apprentissage
disp("TestSet cross-validation")
disp("")
testSet = [];
dataSet = y;
dataX = x;
testX = [];

% On sépare aléatoirement l'échantillon
for i=1:3
    p = ceil(rand(1, 1)*length(dataSet));
    testSet = [testSet dataSet(p)];
    testX = [testX dataX(p)];
    dataSet(p) = [];
    dataX(p) = [];
end

figure(2)
hold on
plot(dataX, dataSet, 'ob')
plot(testX, testSet, 'or')

tetadata = polyfit(dataX, dataSet, 1);
tetadata2 = polyfit(dataX, dataSet, 2);

plot(x, tetadata(1)*x + tetadata(2))
plot(x, tetadata2(1)*x.^2 + tetadata2(2)*x + tetadata2(3))
title("Echantillon de test(r), echantillon d'apprentissage(b)")
hold off

errorLinear = [];
errorQuadratic = [];

for i=1:length(testX)
  errorLinear = [errorLinear (testSet(i) - (tetadata(1)*testX(i) + tetadata(2)))^2];
  valuequad = (testSet(i) - (tetadata2(1)*testX(i).^2 + tetadata2(2)*testX(i) + tetadata2(3)));
  errorQuadratic = [errorQuadratic valuequad^2];
end
disp("Erreur lineaire : ")
disp(mean(errorLinear))

disp("Erreur quadratique: ")
disp(mean(errorQuadratic))



% leave one out  validation
% On prend une valeur de l'échantillon (échantillon de test)
% Le reste est l'échantillon d'apprentissage
disp("Leave-one-out cross-validation")
disp("")

errorLinear = [];
errorQuadratic = [];

for j=1:length(y)
    testSet = [];
    dataSet = y;
    dataX = x;
    testX = [];

    p = j;
    testSet = [testSet dataSet(p)];
    testX = [testX dataX(p)];
    dataSet(p) = [];
    dataX(p) = [];

    figure(3)
    subplot(3, 4, j);
        hold on
        plot(dataX, dataSet, 'ob')
        plot(testX, testSet, 'or')

        tetadata = polyfit(dataX, dataSet, 1);
        tetadata2 = polyfit(dataX, dataSet, 2);

        plot(x, tetadata(1)*x + tetadata(2))
        plot(x, tetadata2(1)*x.^2 + tetadata2(2)*x + tetadata2(3))
        hold off

      errorLinear = [errorLinear (testSet(1) - (tetadata(1)*testX(1) + tetadata(2)))^2];
      valuequad = (testSet(1) - (tetadata2(1)*testX(1).^2 + tetadata2(2)*testX(1) + tetadata2(3)));
      errorQuadratic = [errorQuadratic valuequad^2];
end

disp(mean(errorLinear))
disp(mean(errorQuadratic))









% k-fold  validation
% On découpe l'échantillon en trois échantillons d'apprentissage et trois échantillons de test

disp("K-fold cross-validation")
disp("");

% ON supprime la dernière valeur pour avoir un découpage entier
y(10) = [];
x(10) = [];

meanErrorsLinear = [];
meanErrorsQuadratic = [];

testSet = ones(3, 3);
dataSet = y;
dataX = x;
testX = ones(3, 3);

% On organise les différents parties dans une seule matrice
for j=1:3
    for i=1:3
        p = ceil(rand(1, 1)*length(dataSet));
        testSet(j, i) =  dataSet(p);
        testX(j, i) = dataX(p);
        dataSet(p) = [];
        dataX(p) = [];
    end
end



for i=1:3
    v = [1:3];
    v(i) = [];
    dataSet = [testSet(:,v(1))' testSet(:,v(2))'];
    dataX = [testX(:,v(1))' testX(:,v(2))'];

    % On trie les valeurs
    [dataX, I] = sort(dataX);
    dataSet = dataSet(I);

    figure(4)
        subplot(2, 2, i)
            hold on
            plot(dataX, dataSet, 'ob')
            plot(testX(:, i), testSet(:, i), 'or')

            tetadata = polyfit(dataX, dataSet, 1);
            tetadata2 = polyfit(dataX, dataSet, 2);

            plot(x, tetadata(1)*x + tetadata(2))
            plot(x, tetadata2(1)*x.^2 + tetadata2(2)*x + tetadata2(3))
            hold off

        errorLinear = [];
        errorQuadratic = [];

    for j=1:length(testX(:, i))
        errorLinear = [errorLinear (testSet(j, i) - (tetadata(1)*testX(j, i) + tetadata(2)))^2];
        valuequad = (testSet(j, i) - (tetadata2(1)*testX(j, i).^2 + tetadata2(2)*testX(j, i) + tetadata2(3)));
        errorQuadratic = [errorQuadratic valuequad^2];
    end

end

disp(mean(errorLinear))
disp(mean(errorQuadratic))

