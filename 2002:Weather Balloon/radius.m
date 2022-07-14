clear
clc

%Constants
Molar_Mass_He = 4.0026;
R_Value = 8.3145;
g = 9.81;
FS = 2;
YS = 10000000;
gage_p = 10;
m_pay = 500;
Rho_film = 1010;

%Vars
h = input('Altitude: ');
[T, a ,p ,Rho] = atmoscoesa(h);

Rho_he = ((p * Molar_Mass_He)/(R_Value*T))/1000;

thckns = (FS * gage_p)/(2 * YS);

r = (m_pay/((3.14159) * (((4/3)*(Rho - Rho_he))- (4*Rho_film*thckns))))^(1/3);

disp(r);
