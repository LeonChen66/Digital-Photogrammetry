global ini xa ya JK f  x0 y0  B_dot_ij B_dot2_ij allphoto
allphoto = 10;
load('ini.mat');
load('xa.mat');
load('ya.mat');
f = 18.378;   
%Center of Picture
y0 = 0;
x0 = 0;
%for the initial 
B_dot_ij = 0;
B_dot2_ij = 0;
JK = 0;
n_photo = 10;  %for example
n_point =  658; %for test and example
%ini(4:6)=ini(4:6)/100;
%ini(10:12)=ini(10:12)/100;
%ini(16:18) = ini(16:18)/100;
%ini(22:24) = ini(22:24)/100;
%ini(28:30) = ini(28:30)/100;
%ini(34:36) = ini(34:36)/100;
%ini(40:42) = ini(40:42)/100;
%ini(43:end) = ini(43:end)/100;



ini(1:3) = deg2rad(ini(1:3));  %photo 1 
ini(7:9) = deg2rad(ini(7:9));   %photo 2
ini(13:15) = deg2rad(ini(13:15));  %photo3
ini(19:21) = deg2rad(ini(19:21));   %photo4
ini(25:27) = deg2rad(ini(25:27));   %photo5
ini(31:33) = deg2rad(ini(31:33));   %photo 6
ini(37:39) = deg2rad(ini(37:39));   %photo7
ini(43:45) = deg2rad(ini(43:45));   %photo8
ini(49:51) = deg2rad(ini(49:51));   %photo9
ini(55:57) = deg2rad(ini(55:57)); %photo10
ini_new = ini;
for iter = 1:100
%matching points
for i = 1:2  % number of photo
    for j = 1:30   %number of point
    Matrix_new(i,j)
    end
end

for i = 2:3  % number of photo
    for j = 31:156   %number of point
    Matrix_new(i,j)
    end
end

for i = 3:4  % number of photo
    for j = 157:250   %number of point
    Matrix_new(i,j)
    end
end

for i = 4:5  % number of photo
    for j = 251:293   %number of point
    Matrix_new(i,j)
    end
end

for i = 5:6  % number of photo
    for j = 294:335   %number of point
    Matrix_new(i,j)
    end
end

for i = 6:7  % number of photo
    for j = 336:352   %number of point
    Matrix_new(i,j)
    end
end

for i = 7:8  % number of photo
    for j = 353:448   %number of point
    Matrix_new(i,j)
    end
end

for i = 8:9  % number of photo
    for j = 449:553   %number of point
    Matrix_new(i,j)
    end
end

for i = 9:10  % number of photo
    for j = 554:654   %number of point
    Matrix_new(i,j)
    end
end
%==============================================
%Control points
for i = 1:2
    for j = 655:656
        Matrix_new(i,j)
    end
end

for i = 2:3
    for j = 655:656
        Matrix_new(i,j)
    end
end

for i = 3:4
    for j = 655:658
        Matrix_new(i,j)
    end
end

for i = 4:5
    for j = 655:658
        Matrix_new(i,j)
    end
end

for i = 5:6
    for j = 655:658
        Matrix_new(i,j)
    end
end

for i = 6:7
    for j = 655:658
        Matrix_new(i,j)
    end
end

for i = 7:8
    for j = 655:658
        Matrix_new(i,j)
    end
end

for i = 8:9
    for j = 657:658
        Matrix_new(i,j)
    end
end

for i = 9:10
    for j = 657:658
        Matrix_new(i,j)
    end
end
control_points_start = 655;

%=======================================================================

N_2doti = 0;
N_doti = 0;
%W1 = [0.01 0 0 0 0 0;0 0.01 0 0 0 0;0 0 0.01 0 0 0;0 0 0 0.01 0 0;0 0 0 0 0.01 0;0 0 0 0 0 0.01];
W2 = [5 0 0;0 5 0;0 0 5];
W1 = 0 ;
Wij = [0.5 0;0 0.5];
%N11
for m = 1:n_photo
    for n = 1:n_point
    Bnew1 = B_dot_ij(2*n-1:2*n,1:6,m);
    N_doti = N_doti + Bnew1'*Wij*Bnew1;
    end
    N11(6*m-5:6*m,6*m-5:6*m) = N_doti;
    N_doti = 0;
end

%N22
for i = 1:n_point
    for j = 1:n_photo
        Bnew21 = B_dot2_ij(2*i-1:2*i,1:3,j);
        Bnew22 = B_dot2_ij(2*i-1:2*i,1:3,j);
        N_2doti = N_2doti + Bnew21'*Wij*Bnew22;
    end 
        if i > 654
            N22(3*i-2:3*i,3*i-2:3*i) = N_2doti+W2;
        else
            N22(3*i-2:3*i,3*i-2:3*i) = N_2doti;
        end
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
N21 = N12';
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
W3 = [W2 zeros(3,3) zeros(3,3) zeros(3,3);zeros(3,3) W2 zeros(3,3) zeros(3,3);zeros(3,3) zeros(3,3) W2 zeros(3,3);zeros(3,3) zeros(3,3) zeros(3,3) W2];
k(2023:2034) = k(2023:2034)+W3*(ini_new(2023:2034)-ini(2023:2034));
delta = inv(N)*k;
V = k-N*delta;
delta_(iter) = delta(1);
ini = ini + delta;
end

%standard deviation of uint weight

S0 = 0;
for i = 1:10
    for j = 1:658
        S0 = S0 + JK(2*j-1:2*j,i)'*Wij*JK(2*j-1:2*j,i);
    end
end
S0 = ini(2023:2034)'*W3*ini(2023:2034)+S0;
sqrt(S0/606)
