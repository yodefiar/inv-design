clear all
close all

%Defining the baseline airfoil: NLF(1)-0414F
fID = fopen('NLF0414F.txt','r');
airfoil = (fscanf(fID,'%f',[2 Inf]))';
fclose all;

%Defining flight conditions
Cl1 = 0.409;
Alpha1 = 0.626;
Re = 10000000;
M = 0.12;

%Defining GA
lb = [0.01, 0.35, 0.08, -0.9, 0.3, -0.06, 0.3, -0.001, deg2rad(-5), deg2rad(0.08)];
ub = [0.02, 0.6, 0.12, -0.4, 0.6, -0.03, 0.9, 0.003, deg2rad(-1), deg2rad(2)];
gaoptions = optimoptions('ga');
gaoptions.MaxGenerations = 100;
gaoptions.PopulationSize = 100;
gaoptions.PlotFcn = @gaplotbestf;
[best,fval] = ga(@EnhancedInv,10,[],[],[],[],lb,ub,[],gaoptions);

%Evaluating results
parsec=PARSECairfoilforNLF(best(:,1),best(:,2),best(:,3),best(:,4),best(:,5),best(:,6),best(:,7),best(:,8),0,best(:,9),best(:,10));
[pol,foil]=xfoilCl(parsec,Cl1,Re,M);
[poltarget,foiltarget]=xfoilCl(airfoil,Cl1,Re,M);

figure(1)
plot(airfoil(:,1),airfoil(:,2),'k--',parsec(:,1),parsec(:,2),'b');axis equal;
title('Airfoil');xlabel('x/c');ylabel('y/c');legend('Baseline','Optimized');

fID = fopen('XPartialTgt.txt','r');
target = (fscanf(fID,'%f',[2 Inf]))';
fclose all;

figure(2)
plot(foiltarget.xcp,foiltarget.cp,'k--',foil.xcp,foil.cp,'b',target(:,1),target(:,2),'r');
title('Pressure Distribution');xlabel('x/c');ylabel('Cp');legend('Baseline','Optimized','Target');

%LAST RESULT FROM GA
lastresult = PARSECairfoilforNLF(0.016928405,0.466566348,0.095046708,-0.492677631,0.334575377,-0.034025444,0.569911117,-0.000610133,-0.076933218,0.03146624);
