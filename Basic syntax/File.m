%% Analisys of text from file
% to-do
% 1) Reading the file as a text of array of chars
% 2) Create array of cells which consist of three columns
% "char"->"amount of meetings"->"probobilities"
% 3) Save the chars and probobalities to file *.mat and *.xls as the cell
% variables. Name the files shouold be:
% Data_Analisys.mat
% Data_Analisys.xls
% Data_Analisys.png
% 4) Plot the distribution of probability of symbols in text. 
% Be careful to the labels on the axis.
% Recommendation use xticks(), xticklabels().
% 5) Save the plot as figure and PNG image with resolution at least 400 px. The name
% of files should be: Data_Analisys.png
%% Reading the file
% TO-DO 1
% Read the file from *.txt as a char stream



%% Analysis
% TO-DO 2 
% Use ony char from file
% Use  lowercase string
% Try to use the "Cell" as a data containers;
% Name the varible Data_Analisys
% The cell should consist of 3 columns:
% "Symbol" | "Amount of meeting" | "Probolitie"

% You can use only 1 cycle for this task
% Avoid the memmory allocation in cycle



%% Plot Data
% TO-DO 3
% Illustrate the results from Analysis block
% There should be lable of axis, title, grid



%% Save the file
% TO-DO 4
% Save the figure as Data_Analisys.fig

% Save the figure as image Data_Analisys.png

% Save the data as MAT-file Data_Analisys.mat

% Save the data as Excel table Data_Analisys.xls



%%
clear all; clc; close all;

% Открытие файла и запись символов в массив
fid = fopen('stix.txt', 'r+');
[Char_from_File, Size_from_file] = fscanf(fid, '%c');
fclose(fid);

% Транспонирование матрицы
poem = Char_from_File.';

% Использование функции для подсчета и выделения уникальных символов
[Amount_of_meeting, Symbol] = groupcounts(lower(poem));

% Подсчет уникальных символов
count_of_symbols = strlength(Symbol.');

% Создание массива ячеек с тремя стобцами
Data_Analisys = cell(count_of_symbols, 3);

% Заполнение массива ячеек
for itter = 1 : count_of_symbols
    Probolitie = Amount_of_meeting(itter, 1)/Size_from_file;
    Data_Analisys{itter, 1} = Symbol(itter, 1);
    Data_Analisys{itter, 2} = Amount_of_meeting(itter, 1);
    Data_Analisys{itter, 3} = Probolitie;
end

% Построение графика
x = linspace(1, count_of_symbols, count_of_symbols);
y = Data_Analisys(:, 3).';

bar(x, cell2mat(y));

grid on;
title('Вероятность встречи символов в тексте');
xlabel('Символы');
ylabel('Вероятность');

xticks(0:count_of_symbols + 1)
xticklabels(Symbol)

% Сохранение данных в файлы
savefig('Data_Analisys.fig');
saveas(gcf,'Data_Analisys.png');
save('Data_Analisys.mat', "Data_Analisys");
writecell(Data_Analisys, 'Data_Analisys.xls');