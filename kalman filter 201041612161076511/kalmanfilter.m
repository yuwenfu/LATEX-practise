% 2010-4-15, luyz23, ��MATLAB��latex�ļ�ʾ��
% >> publish('kalmanfilter.m','latex')
% -*-  �������˲� -*-
% �˷���Դ�ԣ�������̳���ڴ˸�л
clear
N=800; w(1)=0; w=randn(1,N); %ϵͳԤ������������
x(1)=0; a=1;
for k=2:N;
    x(k)=a*x(k-1)+w(k-1); %ϵͳ��Ԥ��ֵ
end
V=randn(1,N); %����ֵ�����������
q1=std(V); Rvv=q1.^2;
q2=std(x); Rxx=q2.^2;
q3=std(w); Rww=q3.^2;
c=0.2;
Y=c*x+V; %����ֵ
p(1)=0; s(1)=0;
for t=2:N;
    p1(t)=a.^2*p(t-1)+Rww; %ǰһʱ��X�����ϵ��
    b(t)=c*p1(t)/(c.^2*p1(t)+Rvv); %����������
    s(t)=a*s(t-1)+b(t)*(Y(t)-a*c*s(t-1)); %�����˲�����ź�
    p(t)=p1(t)-c*b(t)*p1(t);%t״̬��x(t|t)�����ϵ��
end
figure(1); plot(x); title('ϵͳ��Ԥ��ֵ');
figure(2); plot(Y); title('����ֵ');
figure(3); plot(s); title('�˲�����ź�');