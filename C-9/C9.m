filename = 'C:\Users\97630\Desktop\IdVgCharacteristics2.txt';
filename1 = 'C:\Users\97630\Desktop\0.01IdVgCharacteristics.txt';
filename2 = '‪C:\Users\97630\Desktop\0.02IdVgCharacteristics2.txt';
filename3 = 'C:\Users\97630\Desktop\0.03IdVgCharacteristics.txt';
filename4 = 'C:\Users\97630\Desktop\0.04IdVgCharacteristics.txt';
fid=fopen(filename);
fid1=fopen(filename1);
fid2=fopen(filename2);
fid3=fopen(filename3);
fid4=fopen(filename4);
cdata=textscan(fid,'%f%f','delimiter',',', 'HeaderLines', 4 );
c1data=textscan(fid1,'%f%f','delimiter',',', 'HeaderLines', 4 );
c2data=textscan(fid2,'%f%f','delimiter',',', 'HeaderLines', 4 );
c3data=textscan(fid3,'%f%f','delimiter',',', 'HeaderLines', 4 );
c4data=textscan(fid4,'%f%f','delimiter',',', 'HeaderLines', 4 );
fclose(fid);
x = cdata{1};
y = cdata{2};
path = 'C:\Users\97630\Desktop';
figure
semilogy(x,y,'LineWidth',1.5,'color','black');
ax = gca; % current axes
ax.FontSize = 18;
ax.FontName = 'Times New Roman';
ax.TickDir = 'in';
ax.YLim = ([1e-25,1e-4]);
ax.LineWidth = 1.5;
xlabel('\it V_g', 'Fontsize', 24,'Fontname','Times New Roman');
ylabel('\it log_{10}(I_D)', 'Fontsize', 24,'Fontname','Times New Roman');
r = y(20,1)./y(1,1);
r1 = round(r,3);
yline(y(1,1),'--',{'Off Current',['\it I_D = ' num2str(y(1,1))]},'Color','r','LineWidth',1.5,'Fontname','Times New Roman','LabelVerticalAlignment','top','LabelHorizontalAlignment','center','Fontsize',12);
yline(y(20,1),'--',{'On Current',['\it I_D = ' num2str(y(20,1))]},'Color','b','LineWidth',1.5,'Fontname','Times New Roman','LabelVerticalAlignment','bottom','LabelHorizontalAlignment','center','Fontsize',12);
ss = 1000.*(x(5,1)-x(1,1))./(log10(y(5,1))-log10(y(1,1)));
line([x(5,1) x(5,1)], [y(1,1) y(5,1)],'LineStyle','--','color','r','LineWidth',1.5);
text(0.4,0.5,['On/Off Ratio = 3.48 \times 10^{18}'],'Units','normalized','color','red','Fontsize',12,'Fontname','Times New Roman')
text(0.22,0.3,['Subthreshold Swing =',num2str(ss),'mvV/dec'],'Units','normalized','color','red','Fontsize',12,'Fontname','Times New Roman')
exportgraphics(gcf,'C:\Users\97630\Desktop\C-9.jpg','Resolution',500)