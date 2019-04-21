clc
clear all
X=xlsread('sj3.xlsx',1,'A2:A452');
Y=xlsread('sj3.xlsx',1,'B2:B452');
y1=200*1.05;
y2=200*0.95;

plot(X,Y,'b','LineWidth',1.5)
hold on
%plot([130,500],[y1,y1],'r--','LineWidth',0.8)
%hold on
%plot([130,500],[y2,y2],'r--','LineWidth',0.8)
axis([0,500,0,200])
xlabel('时间/ms');
ylabel('位移/mm');
title('电液伺服位置控制系统性能实验');
set(get(gca,'title'),'FontSize',14,'FontName','宋体');%设置标题字体大小，字型  
set(get(gca,'xlabel'),'FontSize',14,'FontName','宋体');%设置X坐标标题字体大小，字型  
set(get(gca,'ylabel'),'FontSize',14,'FontName','宋体');%设置Y坐标标题字体大小，字型
grid
%数据处理
%plot(45.5,80,'*')
%plot(90,179.9,'*')
%plot(188,163.2,'*')
%plot(75,160,'*')
%[a,b]=ginput