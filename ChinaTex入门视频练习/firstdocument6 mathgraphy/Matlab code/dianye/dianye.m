clc
clear all
X=xlsread('��Һ�ŷ���λ�ÿ�������ʵ��1.xlsx',1,'A2:A452');
Y=xlsread('��Һ�ŷ���λ�ÿ�������ʵ��1.xlsx',1,'B2:B452');
y1=160*1.02;
y2=160*0.98;

plot(X,Y,'b','LineWidth',1.5)
hold on
plot([130,500],[y1,y1],'r--','LineWidth',0.8)
hold on
plot([130,500],[y2,y2],'r--','LineWidth',0.8)
axis([0,500,0,200])
xlabel('ʱ��/ms');
ylabel('λ��/mm');
title('��Һ�ŷ�λ�ÿ���ϵͳ����ʵ��');
set(get(gca,'title'),'FontSize',14,'FontName','����');%���ñ��������С������  
set(get(gca,'xlabel'),'FontSize',14,'FontName','����');%����X������������С������  
set(get(gca,'ylabel'),'FontSize',14,'FontName','����');%����Y������������С������
grid
%���ݴ���
plot(45.5,80,'*')
plot(90,179.9,'*')
plot(188,163.2,'*')
plot(75,160,'*')
%[a,b]=ginput