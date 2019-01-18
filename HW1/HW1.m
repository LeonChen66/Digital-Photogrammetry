k1 = 6.107*10^(-4);
k2 = (-1.35)*10^(-6);
M = zeros(1920,1280);
for i = 1:1920;
    for j = 1:1280;
    x_bar = (i-960.5)*11.8*10^(-3);
    y_bar = (j-640.5)*11.8*10^(-3);
    d_square=x_bar^2+y_bar^2;
    x_delta = (x_bar*d_square*k1+x_bar*d_square^(2)*k2)/(11.8*10^(-3));
    y_delta = (y_bar*d_square*k1+y_bar*d_square^(2)*k2)/(11.8*10^(-3));
    r = sqrt(x_delta^2+y_delta^2);
    M(j,i) = r;
    end
end


contour(M,'showtext','on','EdgeColor','k');
axis([0,2000,0,1200]);
axis equal;
xlabel('1280 pixel')