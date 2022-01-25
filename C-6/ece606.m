clc 
clear all

%data for C6

% d100 = [                   0,        5.6480867e-17
%                 0.05,        3.6090207e-16
%                  0.1,        2.6009028e-15
%                 0.15,         1.891973e-14
%                  0.2,        1.3257241e-13
%                 0.25,        9.2256355e-13
%                  0.3,        6.3898857e-12
%                 0.35,        4.4122071e-11
%                  0.4,        3.0521883e-10
%                 0.45,        2.0865687e-09
%                  0.5,        1.3725642e-08
%                 0.55,        7.7040858e-08
%                  0.6,        3.1383694e-07];
%              
% d111 = [0,         2.202596e-17
%                 0.05,          1.74691e-16
%                  0.1,        1.3134378e-15
%                 0.15,        9.3564617e-15
%                  0.2,        6.2734563e-14
%                 0.25,        4.5480996e-13
%                  0.3,        2.1225137e-12
%                 0.35,        1.7123206e-11
%                  0.4,        9.8817493e-11
%                 0.45,        1.0139444e-09
%                  0.5,        5.5860855e-09
%                 0.55,        3.9301346e-08
%                  0.6,        1.2151535e-07];
%              
%              
% d110 = [0,        2.9805825e-14
%                 0.05,        2.0548642e-13
%                  0.1,        1.4156159e-12
%                 0.15,        9.7273491e-12
%                  0.2,        6.6582255e-11
%                 0.25,        4.5181111e-10
%                  0.3,        3.0186982e-09
%                 0.35,        1.9320004e-08
%                  0.4,        1.0795536e-07
%                 0.45,        4.4274434e-07
%                  0.5,        1.2563719e-06
%                 0.55,        2.5991227e-06
%                  0.6,        4.3651854e-06];
             
%data for C7 

d100 = []
d110 = []
d111 = []


% yoff = d111(1,2)
% yon = d111(13,2)
% onoff = yon/yo

             
% Begin 
x = d100(:,1)
y = d100(:,2)



figure(2)
semilogy(x,y,'-b')
title('Drain Current vs Gate Voltage')
legend('Wire Direction: [100]')
grid on 
xlabel('V_g (V)')
ylabel('log(I_d) (A)')

figure(4)
semilogy(x, gradient(y)./gradient(x),'-r')
title('Subthreshold swing vs gate voltage')
xlabel('V_g (V)')
ylabel('Subthreshold Swing (mV/dec)')
legend('Wire Direction: [111]')
grid on 

% 
% % figure(3)
% % plot(x, gradient(y)./gradient(x))
% % title('ss in linear')
% % % legend('seilog y','ss')
% 

% 
% figure(1)
% plot(x,y)
% hold on 
% plot(x, gradient(y)./gradient(x))
% legend('original (linear scale)','ss')
% title('linear scale')
% grid on 
% xlabel('Gate Voltage, Vg (V)')
% ylabel('Drain Current, Id (A)')
% hold off

             