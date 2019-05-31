
function [coord] = PARSECairfoilforNLF(rle,xup,yup,yxxup,xl,yl,yxxl,yte,dyte,alphate,betate)

%% Creating PARSEC airfoil

%% Airfoil parameter

% rle = 0.04; % leading edge radius
% xup = 0.45; % absis of upper surface
% yup = 0.105; % ordinat of upper surface
% yxxup = -0.25;
% xl = 0.4; % absis of lower surface
% yl = -0.085; % ordinat of lower surface
% yxxl = 0.48; 
% yte = -0.025; % ordinat of trailing edge
% dyte = 0; % gap of the trailing edge
% alphate = deg2rad(-26); % trailing edge wedge angle, deg.
% betate = deg2rad(26.5); % trailing edge wedge angle, deg.

%% Creating airfoil

a1 = (2*rle)^0.5;

%For a specific number of panels 
N = 81;

% Upper surface

A = [1 1 1 1 1; ...
    xup^(1.5) xup^(2.5) xup^(3.5) xup^(4.5) xup^(5.5); ...
    1.5 2.5 3.5 4.5 5.5; ...
    1.5*xup^0.5 2.5*xup^1.5 3.5*xup^2.5 4.5*xup^3.5 5.5*xup^4.5; ...
    0.75*xup^(-0.5) 3.75*xup^0.5 8.75*xup^1.5 15.75*xup^2.5 24.75*xup^3.5];
B = [(yte+0.5*dyte)-a1; ...
    yup-a1*xup^0.5; ...
    tan(alphate-betate/2)-0.5*a1; ...
    -0.5*(a1*xup^-0.5); ...
    yxxup+0.25*(a1*xup^-1.5)];

a = [a1; (inv(A)*B)];

C = [1 1 1 1 1; ...
    xl^(1.5) xl^(2.5) xl^(3.5) xl^(4.5) xl^(5.5); ...
    1.5 2.5 3.5 4.5 5.5; ...
    1.5*xl^0.5 2.5*xl^1.5 3.5*xl^2.5 4.5*xl^3.5 5.5*xl^4.5; ...
    0.75*xl^(-0.5) 3.75*xl^0.5 8.75*xl^1.5 15.75*xl^2.5 24.75*xl^3.5];
D = [(yte-0.5*dyte)+a1; ...
    yl+a1*xl^0.5; ...
    tan(alphate+betate/2)+0.5*a1; ...
    0.5*(a1*xl^-0.5); ...
    yxxl-0.25*(a1*xl^-1.5)];

b = [-a1; inv(C)*D];

%For a specific X coordinates 
fID = fopen('NLF0414F.txt','r');
NLF0414F = (fscanf(fID,'%f',[2 Inf]))';
x = NLF0414F(:,1);
fclose all;

y=zeros(N+1,1);
for j=1:N+1
    if j < N/2+1
        for i=1:6
            y(j) = y(j) + a(i)*x(j)^(i-0.5);
        end
    else
       for i=1:6
            y(j) = y(j) + b(i)*x(j)^(i-0.5);
       end
    end 
end

% x = 0:0.01:1;
% y = zeros(size(x));
% for j=1:101
%     for i=1:6
%          y(j) = y(j) + a(i)*x(j)^(i-0.5);
%     end
% end

coord = [x y];
% plot(x,y,'r');
% hold on
% grid on
% axis equal
