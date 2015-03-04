function plot_data_spectr()
close all;clear all;clc;
clear
global s time
Vybor_Signal();

% ������ �������
figure(1)
subplot(211)
plot(time,s,'LineWidth',1)
grid on
xlabel('t, ��')
title('������')
%ylim([-3, 3])

subplot(212)
r=min(diff(time));%������� ������������ ���������� �������� ��������� �������� �� ��10
t=0:r:max(time);%������ �������
z=spline(time,s,t);%������������ ���� ��� ���������� ������������� ������������� �� �������
plot(t,z,'LineWidth',1)%������ ������������������ �������
grid on
xlabel('t, ��')
title('���������������� ������')

y=fft(z);%�������������� ����� �� ������� � 0
m=abs(y);%������ ���������
f=0:65535;% 65535 - ������ ������� y.
df=(1/r)/65535;%(1/��� �� �������)/���������� ��������
ff=f*df;% ������� �� �������.
figure
plot(ff,m,'LineWidth',1);
grid on
title('������ �������')

std(s)
end

%% ����� �������
function Vybor_Signal()
global s time

[FileName,PathName] = uigetfile('*.csv','����� �������'); % ����� �����
Full_FileName=[PathName,FileName];
if FileName==0 % ��������� ������� ������� Cancel � ���� ������ �����
    return
end
[data1,data2]=textread(Full_FileName,'%f %f',...
    'headerlines',6,...       % ������������ 6 ����� ���������
    'delimiter', ',');        % ����������� - �������

time=1000*data1;       % ����� (��)(�������-������)
s=data2;             % ������� ������� (�������-������)
end