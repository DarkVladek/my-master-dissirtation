clear
global s t
Vybor_Signal();

%������ ����
figure(1)
plot(t,s,'LineWidth',1)
grid on
xlabel('t, ��')
xlim([0,t(end)])
title('���')
ylim([-5, 5])

N_Spectr=500;      % ���������� �������� �������
f_max=50e6;        % ������������ ������� ��� ���������� �������
df=f_max/N_Spectr;  % ��� �� �������
f=(0:N_Spectr-1)*df; % ������� �������
omega=2*pi*f;       % �������� �������
N_s=length(s);      % ���������� �������� ����
K_segment=100;      % ���������� ���������
N_segment=floor(N_s/K_segment); % ���������� �������� � ��������
Spectr_segment=zeros(1,N_Spectr);
P_Spectr=zeros(1,N_Spectr);
h_wait=waitbar(0,'������ �������...');
for k=1:K_segment
    waitbar(k/K_segment)
    t_segment=t((k-1)*N_segment+1:k*N_segment);     % ��������� ��������� �������, ���������������� ��������
    t_segment=t_segment-t_segment(1); 
    T_segment=t_segment(end);           % ������������ ��������
    w=sin(pi*(t_segment/T_segment)).^2; % ������� ������� sin^2
    s_segment=s((k-1)*N_segment+1:k*N_segment);  % ��������� ��������
    s_segment=w.*s_segment;  % ��������� �� ������� �������
    dt=diff(t_segment);
    for n=1:N_Spectr
        phi_segment=mod(omega(n)*t_segment,2*pi);
        Spectr_segment(n)=sum(s_segment(1:end-1).*exp(-j*phi_segment(1:end-1)).*dt); % ���������� �������������� ����� ��������
    end
    P_Spectr_segment=(abs(Spectr_segment).^2)/T_segment;    % ������������ ������ �������� ��������
    w_sum2=sum(w.^2)/N_segment;
    P_Spectr_segment=P_Spectr_segment/w_sum2;    % ��������� ������� ������� ������� �� �������� ��������
    P_Spectr_segment=2*P_Spectr_segment;         % ������������� ������ �������� ��������
    P_Spectr=P_Spectr+P_Spectr_segment;          % ���������� ������� ��������
end
close(h_wait)
P_Spectr=P_Spectr/K_segment; % ���������� ������ ��������
figure(2)
plot(f,P_Spectr);
%stem (f,P_Spectr)
grid on
title('������ �������� ����')
std(s)^2