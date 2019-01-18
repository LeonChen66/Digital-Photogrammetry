%M7410 HW2 Leon Chen
A = [0 0 -1 0 -1 -1 0;0 0 0 -1 -1 0 -1;-1 -1 -1 0 0 0 0;0 1 0 0 0 0 1];
f = [0.1;0.1;-0.4;0.2];
sigma_p = [0.5 0.1 0.1 0.3 0.2 0.3 0.1];
l = [1.1 2.3 -3.8 -0.3 2.9 1 -2.5]';
w = zeros(length(sigma_p),length(sigma_p))
for i = 1:length(sigma_p)
    w(i,i)=1/(sigma_p(i))^2;
end
Q = inv(w);
k = inv(A*Q*A')*f;
V = Q*A'*k;

Q=inv(w^2);
k = inv(A*Q*A')*f;
V = Q*A'*k;