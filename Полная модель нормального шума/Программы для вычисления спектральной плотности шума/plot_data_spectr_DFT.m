clear , close all
global s t
Vybor_Signal();

% %������ ����
% figure(1)
% plot(t,s,'LineWidth',1)
% grid on
% xlabel('t, ��')
% xlim([0,t(end)])
% title('���')
% ylim([-5, 5])

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
h_wait=waitbar(0,'2','Name','������ �������...');
for k=1:2*(K_segment-1)
    waitbar(k/(2*(K_segment-1)),h_wait,sprintf('%0.1f %%',100*k/(2*(K_segment-1))))
    t_segment=t(floor(N_segment*(k-1)/2+1):floor(N_segment*(k+1)/2));% ��������� ��������� �������, ���������������� ��������
    t_segment=t_segment-t_segment(1);
    T_segment=t_segment(end);% ������������ ��������
    w=sin(pi*(t_segment/T_segment)).^2; % ������� ������� sin^2
    s_segment=s(floor(N_segment*(k-1)/2+1):floor(N_segment*(k+1)/2));  % ��������� ��������
    s_segment=w.*s_segment;  % ��������� �� ������� �������
    dt=diff(t_segment);
    for n=1:N_Spectr
        phi_segment=mod(omega(n)*t_segment,2*pi);
        Spectr_segment(n)=sum(s_segment(1:end-1).*exp(-1j*phi_segment(1:end-1)).*dt); % ���������� �������������� ����� ��������
    end
    P_Spectr_segment=(abs(Spectr_segment).^2)/T_segment;    % ������������ ������ �������� ��������
    w_sum2=sum(w.^2)/N_segment;
    P_Spectr_segment=P_Spectr_segment/w_sum2;    % ��������� ������� ������� ������� �� �������� ��������
    P_Spectr_segment=2*P_Spectr_segment;         % ������������� ������ �������� ��������
    P_Spectr=P_Spectr+P_Spectr_segment;% ���������� ������� ��������
end
close(h_wait)
P_Spectr=P_Spectr/K_segment; % ���������� ������ ��������
%P_Spectr_norm=P_Spectr/P_Spectr(1);%������������� ������ ��������
tau=4e-9;
P_Spectr_korr=P_Spectr.*(1+(2*pi*f.*tau).^2);%��������� �������
figure(2)
subplot(211);
plot(f,P_Spectr);
xlabel ('f, ��')
ylabel ('S, ��/��')
grid on
title('������ �������� ����')
sprintf('��������� ���������� ���� �����: %0.3f',std(s)^2)% �������� ���������
subplot(212);
plot(f,P_Spectr_korr);
% stem (f,P_Spectr)
xlabel ('f, ��')
ylabel ('S, ��/��')
grid on
title('������������������ ������ �������� ����')