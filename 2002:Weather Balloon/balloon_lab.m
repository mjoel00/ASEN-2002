%Constants
q_sun = 1353;
q_earth = 237;
ep_b = 0.8;
sig_sb = 0.0000000576;
alph_sb = 0.6;
alph_eb = ep_b;
sh_he = 5192.6;
Molar_Mass_He = 4.0026;
Molar_Mass_Air = 28.97;
R_Value = 2.0769;
g = 9.81;
FS = 2;
YS = 10000000;
p_gauge = 10;
m_pay = 500;
Rho_film = 1010;

%Vars
h = input('Altitude: ');

[T, a ,p ,Rho] = atmoscoesa(h);

Rho_he = ((p * Molar_Mass_He)/(R_Value*T))/1000;

thckns = (FS * p_gauge)/(2 * YS);

r = (m_pay/((3.14159) * (((4/3)*(Rho - Rho_he))- (4*Rho_film*thckns))))^(1/3);

phe_abs = p_gauge + p;




V = (4*pi/3)*r^3;
Initial_SA = 4*pi*r^2;
Mols_He = (V*Rho_he*1000)/Molar_Mass_He;
m_he = V*Rho_he;

%Time
delta_t = 1;
time = 0:delta_t:3600;

%Thermal Initial
Q_balloon = ep_b*sig_sb*4*pi*r^2*T^4;
Q_solar = alph_sb*q_sun*pi*r^2;
Q_earth = alph_eb*q_earth*pi*r^2;
Q_in = Q_solar+Q_earth;
Q_out = Q_balloon;
Q_tot = Q_in - Q_out;

%Thermal
delta_T = 0;
delta_R = 0;
for t = time
Q_balloon = ep_b*sig_sb*4*pi*(r+delta_R)^2*(T+delta_T)^4;
Q_solar = alph_sb*q_sun*pi*(r+delta_R)^2;
Q_earth = alph_eb*q_earth*pi*(r+delta_R)^2;
Q_in = Q_solar+Q_earth;
Q_out = Q_balloon;
Q_tot = Q_in - Q_out;

delta_T = delta_T + Q_tot*delta_t/(m_he*sh_he);
delta_R = (3*(Mols_He*R_Value*(T+delta_T)/phe_abs)/(4*pi))^(1/3)-r;

end

disp(delta_T);
disp(delta_R);