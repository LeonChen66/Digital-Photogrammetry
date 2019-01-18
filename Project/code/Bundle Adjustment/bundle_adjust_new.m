%basic parameter
%initail value and camera parameter
global ini xa ya JK f  x0 y0 B_dot_ij B_dot2_ij  b11 b12 b13 b14 b15 b16 J K b21 b22 b23 b24 b25 b26 omega phi kappa XL YL ZL ini_new
load('ini.mat');
load('xa.mat');
load('ya.mat');



ini(1:3) = deg2rad(ini(1:3));
ini(7:9) = deg2rad(ini(7:9));
ini(13:15) = deg2rad(ini(13:15));
ini(19:21) = deg2rad(ini(19:21));
ini(25:27) = deg2rad(ini(25:27));
ini(31:33) = deg2rad(ini(31:33));
ini(37:39) = deg2rad(ini(37:39));
%Remember to set xa ya
n_photo = 7;  %for example
n_point =  612; %for test and example

for iter = 1:1
f = 18.6;   %Remeber test data is 153.11
%Center of Picture
y0 = 0;
x0 = 0;
%for the initial 
B_dot_ij = 0;
B_dot2_ij = 0;
JK = 0;

%example
%above is just for test
%afterward change into function
for i = 1:n_photo  % number of photo
    for j = 1:n_point   %number of point
    Matrix_new(i,j)
    end
end
% Matrix
N_2doti = 0;
N_doti = 0;
%W1 = [0.01 0 0 0 0 0;0 0.01 0 0 0 0;0 0 0.01 0 0 0;0 0 0 0.01 0 0;0 0 0 0 0.01 0;0 0 0 0 0 0.01];
W2 = [1/0.09^2 0 0;0 1/0.09^2 0;0 0 1/0.09^2];
W1 = 0 ;

Wij = [100 0;0 100];
%N11
for m = 1:n_photo
    for n = 1:n_point
    Bnew1 = B_dot_ij(2*n-1:2*n,1:6,m);
    N_doti = N_doti + Bnew1'*Wij*Bnew1;
    end
    N11(6*m-5:6*m,6*m-5:6*m) = N_doti+W1;
    N_doti = 0;
end

%N22
for i = 1:n_point
    for j = 1:n_photo
        Bnew21 = B_dot2_ij(2*i-1:2*i,1:3,j);
        Bnew22 = B_dot2_ij(2*i-1:2*i,1:3,j);
        N_2doti = N_2doti + Bnew21'*Wij*Bnew22;
    end 
       % if i > 3 
        %N22(3*i-2:3*i,3*i-2:3*i) = N_2doti+W2;
        %else
        N22(3*i-2:3*i,3*i-2:3*i) = N_2doti+W2;
        %end
        N_2doti = 0;
end
N12 = 0;
N21 = 0;
%N12 
for i = 1:n_photo
    for j = 1:n_point
        N12(6*i-5:6*i,3*j-2:3*j) = B_dot_ij(j*2-1:j*2,1:6,i)'*Wij*B_dot2_ij(j*2-1:j*2,1:3,i);
    end
end
%N21
for i=1:n_photo
    for j = 1:n_point
        N21(3*j-2:3*j,6*i-5:6*i) = (B_dot_ij(j*2-1:j*2,1:6,i)'*Wij*B_dot2_ij(j*2-1:j*2,1:3,i))';
    end
end
k1_doti=0;
%K1
for i = 1:n_photo
    for j = 1:n_point
        Bnew1 = B_dot_ij(2*j-1:2*j,1:6,i);
        Bnew2 = JK(2*j-1:2*j,i);
        k1_doti = k1_doti + Bnew1'*Wij*Bnew2;
    end
        k1(i*6-5:i*6,1) = k1_doti;
        k1_doti=0;
end
%K2
k2_doti = 0;
for i = 1:n_point
    for j = 1:n_photo
        Bnew1 = B_dot2_ij(2*i-1:2*i,1:3,j);
        Bnew2 = JK(2*i-1:2*i,j);
        k2_doti = k2_doti + Bnew1'*Wij*Bnew2;
    end
    k2(i*3-2:3*i,1) = k2_doti;
    k2_doti = 0;
end

N = [N11 N12;N21 N22];
 %control point

k = [k1;k2];
%k(1:6) = k(1:6)+W1*100*[0;0;0;0;0;152.1130];
%k(7:12) = k(7:12)+W1*100*[2.4099;0.5516;-0.2067;91.9740;-1.7346;148.3015];
%k(22:24) = k(22:24) + W2*(ini_new(22:24)-ini(22:24));
%k(25:27) = k(25:27) + W2*(ini_new(25:27)-ini(25:27));
%k(28:30) = k(28:30) + W2*(ini_new(28:30)-ini(28:30));
delta = inv(N)*k;
V = k-N*delta;
delta_(iter) = delta(1);
%ini = ini_new + delta; %unif
ini = ini + delta;

end