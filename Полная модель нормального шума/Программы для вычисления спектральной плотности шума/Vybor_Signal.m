%% ����� �������
function Vybor_Signal()
global s t

[FileName,PathName] = uigetfile('*.csv','����� �������'); % ����� �����
Full_FileName=[PathName,FileName];
if FileName==0 % ��������� ������� ������� Cancel � ���� ������ �����
    return
end
[data1,data2]=textread(Full_FileName,'%f %f',...
    'headerlines',6,...       % ������������ 6 ����� ���������
    'delimiter', ',');        % ����������� - �������

t=data1;       % ����� (�)(�������-������)
s=data2;       % ������� ������� (�������-������)