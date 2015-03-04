function plot_data()
clear
global s time
Vybor_Signal();

% ������ ���� � �����������
figure(1)
subplot(211)
plot(time,s,'LineWidth',1)
grid on
xlabel('t, ��')
title('���')

subplot(212)
N=length(s);
[n,x]=hist(s,30);
p=n/N;
bar(x,p,'LineWidth',1)
grid on
title('�����������')

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