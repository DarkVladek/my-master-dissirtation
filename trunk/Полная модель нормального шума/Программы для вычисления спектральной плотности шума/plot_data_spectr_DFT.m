clear
global s t
Vybor_Signal();

%График шума
figure(1)
plot(t,s,'LineWidth',1)
grid on
xlabel('t, мс')
xlim([0,t(end)])
title('Шум')
ylim([-5, 5])

N_Spectr=500;      % Количество отсчётов спектра
f_max=50e6;        % Максимальная частота при вычислении спектра
df=f_max/N_Spectr;  % Шаг по частоте
f=(0:N_Spectr-1)*df; % Отсчёты частоты
omega=2*pi*f;       % Круговая частота
N_s=length(s);      % Количество отсчётов шума
K_segment=100;      % Количество сегментов
N_segment=floor(N_s/K_segment); % Количество отсчётов в сегменте
Spectr_segment=zeros(1,N_Spectr);
P_Spectr=zeros(1,N_Spectr);
h_wait=waitbar(0,'Расчёт спектра...');
for k=1:K_segment
    waitbar(k/K_segment)
    t_segment=t((k-1)*N_segment+1:k*N_segment);     % Выделение интервала времени, соответствующего сегменту
    t_segment=t_segment-t_segment(1); 
    T_segment=t_segment(end);           % Длительность сегмента
    w=sin(pi*(t_segment/T_segment)).^2; % Оконная функция sin^2
    s_segment=s((k-1)*N_segment+1:k*N_segment);  % Выделение сегмента
    s_segment=w.*s_segment;  % Умножение на оконную функцию
    dt=diff(t_segment);
    for n=1:N_Spectr
        phi_segment=mod(omega(n)*t_segment,2*pi);
        Spectr_segment(n)=sum(s_segment(1:end-1).*exp(-j*phi_segment(1:end-1)).*dt); % Дискретное преобразование Фурье сегмента
    end
    P_Spectr_segment=(abs(Spectr_segment).^2)/T_segment;    % Двусторонний спектр мощности сегмента
    w_sum2=sum(w.^2)/N_segment;
    P_Spectr_segment=P_Spectr_segment/w_sum2;    % Коррекция влияния оконной функции на мощность сегмента
    P_Spectr_segment=2*P_Spectr_segment;         % Односторонний спектр мощности сегмента
    P_Spectr=P_Spectr+P_Spectr_segment;          % Накопление спектра мощности
end
close(h_wait)
P_Spectr=P_Spectr/K_segment; % Усреднённый спектр мощности
figure(2)
plot(f,P_Spectr);
%stem (f,P_Spectr)
grid on
title('Спектр мощности шума')
std(s)^2