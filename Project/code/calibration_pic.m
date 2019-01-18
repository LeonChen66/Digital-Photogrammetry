%Project Clibration
%Canon EOS 70D 2016/11/20
[x,y]=meshgrid(1:30:720,1:30:480);
k1 = 6.13*10^(-4);
k2 = (-1.3)*10^(-6);
x_bar = (x-360.5)*3.125*10^(-2);
y_bar = (y-240.5)*3.125*10^(-2);
d_square=x_bar.^2+y_bar.^2;
x_delta = (x_bar.*d_square*k1+x_bar.*d_square.^(2)*k2)/(3.125*10^(-2));
y_delta = (y_bar.*d_square*k1+y_bar.*d_square.^(2)*k2)/(3.125*10^(-2));
r = sqrt(x_delta.^2+y_delta.^2);
contour(x,y,r,'showtext','on','EdgeColor','k');
hold on;
axis equal;
axis([0,720,0,480]);
title('Radial lens distortion');
xlabel('x(pixel)');
ylabel('y(pixel)');
quiver(x,y,x_delta,y_delta);

p1 = -6.2*10^(-6);
p2 = 1.2*10^(-5);
x_delta_p = ((2*x_bar.^2+d_square).*p1+2*p2.*x_bar.*y_bar)/(3.125*10^(-2));
y_delta_p = (2*p1.*x_bar.*y_bar+(2*y_bar.^2+d_square).*p2)/(3.125*10^(-2));
r_p = sqrt(x_delta_p.^2+y_delta_p.^2);
figure;
contour(x,y,r_p,'showtext','on','EdgeColor','k');
hold on;
axis equal;
axis([0,720,0,480]);
title('Decentering lens distortion');
xlabel('x(pixel)');
ylabel('y(pixel)');
quiver(x,y,x_delta_p,y_delta_p);