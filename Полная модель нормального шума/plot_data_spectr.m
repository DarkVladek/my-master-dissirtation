function plot_data_spectr()
close all;clear all;clc;
clear
global s time
Vybor_Signal();

% График сигнала
figure(1)
subplot(211)
plot(time,s,'LineWidth',1)
grid on
xlabel('t, мс')
title('Сигнал')
%ylim([-3, 3])

subplot(212)
r=min(diff(time));%подсчёт минимального расстояния дискрета временных отсчётов из МС10
t=0:r:max(time);%вектор частоты
z=spline(time,s,t);%Интерполяция шума для устранения неравномерной дискретизации по времени
plot(t,z,'LineWidth',1)%График интерполированного сигнала
grid on
xlabel('t, мс')
title('Итерполированный сигнал')

y=fft(z);%преобразование фурье со сдвигом в 0
m=abs(y);%вектор амплитуды
f=0:65535;% 65535 - размер массива y.
df=(1/r)/65535;%(1/шаг по времени)/количество отсчётов
ff=f*df;% отсчёты по частоте.
figure
plot(ff,m,'LineWidth',1);
grid on
title('Спектр сигнала')

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