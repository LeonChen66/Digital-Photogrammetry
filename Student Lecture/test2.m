[x,y]=meshgrid(1:20:640,1:20:480);
p1 = 0.0015537912;
p2 = 0.0015537912;

x_bar = (x-342.319)*10^(-3);
y_bar = (y-233.464)*10^(-3);
d_square=x_bar.^2+y_bar.^2;
x_delta = (x_bar.*d_square*k1+x_bar.*d_square.^(2)*k2+x_bar.*d_square.^(3)*k3)/10^(-3);
y_delta = (y_bar.*d_square*k1+y_bar.*d_square.^(2)*k2+y_bar.*d_square.^(3)*k3)/10^(-3);
r = sqrt(x_delta.^2+y_delta.^2);
contour(x,y,r,'showtext','on','EdgeColor','k');
hold on;
axis equal;
title('radial lens distortion');
xlabel('x(pixel)');
ylabel('y(pixel)');
quiver(x,y,x_delta,y_delta);
