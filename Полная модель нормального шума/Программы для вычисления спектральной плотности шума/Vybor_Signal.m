%% Выбор сигнала
function Vybor_Signal()
global s t

[FileName,PathName] = uigetfile('*.csv','Выбор сигнала'); % Выбор файла
Full_FileName=[PathName,FileName];
if FileName==0 % Обработка нажатия клавиши Cancel в окне выбора файла
    return
end
[data1,data2]=textread(Full_FileName,'%f %f',...
    'headerlines',6,...       % пропускаются 6 строк заголовка
    'delimiter', ',');        % разделитель - запятая

t=data1;       % Время (с)(матрица-строка)
s=data2;       % Отсчёты сигнала (матрица-строка)