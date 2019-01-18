%sort points with Matrix
%load points result first
global xa ya ini  B_dot_ij B_dot2_ij b11 b12 b13 b14 b15 b16 b21 b22 b23 b24 b25 b26 J K cor omega phi kappa   XL YL ZL XA YA ZA delta JK
a = size(pointsresult);
for i = 1:a(1)
    xa(pointsresult(i,3)+1,pointsresult(i,4)) = pointsresult(i,1);
end
for i = 1:a(1)
    ya(pointsresult(i,3)+1,pointsresult(i,4)) = pointsresult(i,2);
end
ini = [40.575;304.516;319.0288;-0.611475;-0.211449;0.579787;
       58.597;314.053;336.849;-0.544;-0.445680;0.540052;
       67.275;310.470;343.09;-0.431433;-0.425272;0.428622;
       72.172958;338.5716;353.1065;-0.082368;-0.582555;0.424740;
       70;354.251;356.387;0.078274;-0.615648;0.464476;
       68.226;358.288398;358.720511;0.238648;-0.608928;0.483167;
       71.1219;13.45688;5.6414;0.447493;-0.633655;0.458841;
       70.78414;20.512373;7.611769;0.605672;-0.637347;0.445706;
       72.7877;31.122;10.310;0.734897;-0.583779;0.448423;
       64.695974;50.148023;20.898955;0.951975;-0.397410;0.439525];
intersection(10,1,1,30)    %photo12 30
intersection(10,2,31,156)  %photo23 126
intersection(10,3,157,250)  %photo34 94
intersection(10,4,251,293)  %photo45 43
intersection(10,5,294,335)  %photo56 42
intersection(10,6,336,352)  %photo67 17
intersection(10,7,353,448)  %photo78 96
intersection(10,8,449,553)  %photo89  105
intersection(10,9,554,654)  %photo9,10  101
