function y=Matrix_new(i,j)
global f xa ya XL YL ZL XA YA ZA ini x0 y0 B_dot_ij B_dot2_ij m11 m12 m13 m21 m22 m23 m31 m32 m33 q r s b11 b12 b13 b14 b15 b16 J K b21 b22 b23 b24 b25 b26 omega phi kappa JK allphoto

omega = ini(6*i-5);
phi = ini(6*i-4);
kappa = ini(6*i-3);
XL = ini(6*i-2);
YL = ini(6*i-1);
ZL = ini(6*i);
XA = ini(3*j+allphoto*6-2);
YA = ini(3*j+allphoto*6-1);
ZA = ini(3*j+allphoto*6);
delta_X = XA - XL;
delta_Y = YA - YL;
delta_Z = ZA - ZL;
m11 = cos(phi)*cos(kappa);
m12 = sin(omega)*sin(phi)*cos(kappa)+cos(omega)*sin(kappa);
m13 = -cos(omega)*sin(phi)*cos(kappa)+sin(omega)*sin(kappa);
m21 = -cos(phi)*sin(kappa);
m22 = -sin(omega)*sin(phi)*sin(kappa)+cos(omega)*cos(kappa);
m23 = cos(omega)*sin(phi)*sin(kappa)+sin(omega)*cos(kappa);
m31 = sin(phi);
m32 = -sin(omega)*cos(phi);
m33 = cos(omega)*cos(phi);
q = m31*(delta_X)+m32*(delta_Y)+m33*(delta_Z);
r = m11*(delta_X)+m12*(delta_Y)+m13*(delta_Z);
s = m21*(delta_X)+m22*(delta_Y)+m23*(delta_Z);
b11 = f/q^2*(r*(-m33*delta_Y+m32*delta_Z)-q*(-m13*delta_Y+m12*delta_Z));
b12 = (f/q^2)*((r*(cos(phi)*delta_X+sin(omega)*sin(phi)*delta_Y-cos(omega)*sin(phi)*delta_Z))-(q*(-sin(phi)*cos(kappa)*delta_X+sin(omega)*cos(phi)*cos(kappa)*delta_Y-cos(omega)*cos(phi)*cos(kappa)*delta_Z)));
b13 = -f/q*(m21*delta_X+m22*delta_Y+m23*delta_Z);
b14 = (f/(q^2))*(r*m31-q*m11);
b15 = (f/(q^2))*(r*m32-q*m12);
b16 = (f/(q^2))*(r*m33-q*m13);
%maybe error
J = xa(j,i) -x0 +f*r/q;
b21 = (f/(q^2))*(s*(-m33*delta_Y+m32*delta_Z)-q*(-m23*delta_Y+m22*delta_Z));
b22 = (f/(q^2))*((s*(cos(phi)*delta_X+sin(omega)*sin(phi)*delta_Y-cos(omega)*sin(phi)*delta_Z))-q*(sin(phi)*sin(kappa)*delta_X-sin(omega)*cos(phi)*sin(kappa)*delta_Y+cos(omega)*cos(phi)*sin(kappa)*delta_Z));
b23 = f/q*(m11*delta_X+m12*delta_Y+m13*delta_Z);
b24 = (f/(q^2))*(s*m31-q*m21);
b25 = (f/(q^2))*(s*m32-q*m22);
b26 = (f/(q^2))*(s*m33-q*m23);
K = ya(j,i) -y0+f*s/q;
B_dot_ij(2*j-1:2*j,1:6,i) = [b11 b12 b13 -b14 -b15 -b16;b21 b22 b23 -b24 -b25 -b26];
B_dot2_ij(2*j-1:2*j,1:3,i) = [b14 b15 b16;b24 b25 b26];
JK(2*j-1:2*j,i) = [J;K];
end