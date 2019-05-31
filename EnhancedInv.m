function [error_cp]=EnhancedInv(x)

%Generating PARSEC airfoil 
[coord] = PARSECairfoilforNLF(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7),x(:,8),0,x(:,9),x(:,10));
%N is set to default as 81 in PARSECairfoilforNACA.m 
% x(:,1) = rle = Leading edge radius
% x(:,2) = xup = Absis of upper surface
% x(:,3) = yup = Ordinat of upper surface
% x(:,4) = yxxup 
% x(:,5) = xl = Absis of lower surface
% x(:,6) = yl = Ordinat of lower surface
% x(:,7) = yxxl 
% x(:,8) = yte = Ordinat of trailing edge
% x(:,9) = alfate = Trailing edge direction, deg.
% x(:,10) = betate = Trailing edge wedge angle, deg.
% dyte is set to default as 0 

%Or manual coordinates input
% coord = x;

%Running Xfoil with flight condition as follows: 
% Cl = 0.409;
% Re = 10000000;
% M = 0.12;
[pol,foil] = xfoilCl(coord,0.409,10000000,0.12);

%Removing unconvergent results
if isnan(pol.CL)==1 
    error_cp = 100;
    return
end

if length(foil.cp)<=80
    error_cp = 100;
    return
end

%Defining upper laminar region
szfoil = size(foil.xcp);
halfsz = round(szfoil(1,1)/2);
xcp = foil.xcp(1:halfsz); cp = foil.cp(1:halfsz);
lamxcp = zeros(halfsz(1,1),1); lamcp = zeros(halfsz(1,1),1);
for n=1:halfsz(1,1)
    if (xcp(n)>=0.1 && xcp(n)<=0.75)
        lamxcp(n) = xcp(n);
        lamcp(n) = cp(n);
    else
        lamxcp(n) = NaN;
        lamcp(n) = NaN;
    end
end
[row,~]=find(isnan(lamxcp));
lamxcp(row)=[]; lamcp(row)=[];

%Calculating the error compared to a target partial CP
fID = fopen('PartialTgt.txt','r');
target = (fscanf(fID,'%f',[1 Inf]))';
fclose all;

error_cp_point = lamcp-target;

szlam = size(lamcp);
MAEn = 0;
for j=1:szlam(1,1)
    MAEn = MAEn + abs(error_cp_point(j,:));
end

x
error_cp = MAEn/szlam(1,1)