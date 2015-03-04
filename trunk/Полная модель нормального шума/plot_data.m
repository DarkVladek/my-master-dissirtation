function plot_data()
clear
global s time
Vybor_Signal();

% График шума и гистограмма
figure(1)
subplot(211)
plot(time,s,'LineWidth',1)
grid on
xlabel('t, мс')
title('Шум')

subplot(212)
N=length(s);
[n,x]=hist(s,30);
p=n/N;
bar(x,p,'LineWidth',1)
grid on
title('Гистограмма')

std(s)
end

%% Выбор сигнала
function Vybor_Signal()
global s time

[FileName,PathName] = uigetfile('*.csv','Выбор сигнала'); % Выбор файла
Full_FileName=[PathName,FileName];
if FileName==0 % Обработка нажатия клавиши Cancel в окне выбора файла
    return
end
[data1,data2]=textread(Full_FileName,'%f %f',...
    'headerlines',6,...       % пропускаются 6 строк заголовка
    'delimiter', ',');        % разделитель - запятая

time=1000*data1;       % Время (мс)(матрица-строка)
s=data2;             % Отсчёты сигнала (матрица-строка)
end