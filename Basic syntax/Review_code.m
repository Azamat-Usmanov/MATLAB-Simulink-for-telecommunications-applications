% Clear workspace. Clear command window. Close all figure
clear all; clc; close all;
%% task
% 0) Create a function
% 1) Create the random matrix
% 2) Analyse the code. Insert the calculation of runtime of code
% 3) rewrite the code in more optimised form in matlab
% 4) Provide the evidence that results matrix and legacy matrix is the same
% 5) calculate the runtime of new code. Compare it with legacy code. Make
% an conclusion about code. Which one is the more optimised? Which code do
% you suggest to use in matlab? And why?
%% Config the system

% Fixed random generator
rng(110);
% TO-DO 1%
% Create function, which generate 
% create Input_Matrix matrix 650-to-80 size and
% with normal distributed numbers from -75 to 92
%


Input_Matrix = Matrix_generator();
Legacy_Matrix = Input_Matrix;
Ethalon_Matrix = Input_Matrix;




%% Run legacy code
% TO-DO 2
% Measure the runtime of current function
num_of_measurements = 1000;

time_1 = 0;
Matrix_Time_1 = 1:num_of_measurements;
for i_time = 1 : num_of_measurements
    tic
    Legacy_output_Matrix = Legacy_Instruction(Input_Matrix);
    % Save the runtime in variable
    time_1 = time_1 + toc;
    Matrix_Time_1(i_time) = toc;
end

average_time_1 = time_1/num_of_measurements;

%% Run optimised code
% TO-DO 3
% Measure the runtime of your function
% Create function New_Instruction()
% Rewrite and optimised function Legacy_Instruction()
% Use matrix operation, logical indexing
% Try not to use the cycle
time_2 = 0;
Matrix_Time_2 = 1:num_of_measurements;
for j_time = 1 : num_of_measurements
    tic
    Optimised_Output_Matrix = New_Instruction(Input_Matrix);
    % Save the runtime in variable;
    time_2 = time_2 + toc;
    Matrix_Time_2(j_time) = toc;
end

average_time_2 = time_2/num_of_measurements;
%% Checking the work of student
% TO-DO 4
% Compare the matrix and elapsed time for instruction
% Matrix must be equal each other, but the runtime sill be different

% Runtime comparison
Identity_Matrix = ones(650, 80);
Epsilon_Machine = power(10, -13);

if average_time_2 / average_time_1 < 1
    bool_time_result = 1;
    time_difference = average_time_1 - average_time_2;
else
    bool_time_result = 0;
end

% Разброс данных вокруг среднего
D_1 = sum((Matrix_Time_1(1:num_of_measurements) - average_time_1).^2)/num_of_measurements;
D_2 = sum((Matrix_Time_2(1:num_of_measurements) - average_time_2).^2)/num_of_measurements;

x = linspace(1, num_of_measurements, num_of_measurements);
plot(x, Matrix_Time_2, x, Matrix_Time_1, 'LineWidth', 2);

grid on;
title('Зависимость времени выполнения от количества измерений')
ylabel('Время');
xlabel('Количество измерений');

legend('Новый код','Старый код')

saveas(gcf,'Time_Spread.png');
% Comparison of matrix
    % Matrix size and value


if size(Optimised_Output_Matrix) == size(Legacy_output_Matrix)
    disp('Матрицы совпали по размеру');
    if abs(Optimised_Output_Matrix - Legacy_output_Matrix) < Identity_Matrix*Epsilon_Machine
        disp('Элементы матрицы совпали');
    else
        disp('Элементы матрицы не совпали');
    end
else
    disp('Матрицы не совпали по размеру');
end

Old_time = ['Среднее время работы старого кода: ',num2str(average_time_1), '+-', num2str(sqrt(D_1))];
New_time = ['В то время как нового кода: ', num2str(average_time_2), '+-', num2str(sqrt(D_2))];
Comparison = ['Одна реализация лучше другой в: ', num2str(average_time_1/average_time_2)]; 
Count_of_meas = ['Подсчет проводился по ',num2str(num_of_measurements), ' количеству измерений.'];


disp(Old_time);
disp(New_time);
disp(Comparison);
disp(Count_of_meas);


%% Function discribing

function Random_float_matrix = Matrix_generator()
    Random_float_matrix = -75 + (92+75)*rand(650, 80);
end

function Output_Matrix = New_Instruction(Matrix)

    Matrix(26:end, :) = abs(Matrix(26:end, :));

    Matrix = 7*Matrix;
    Matrix(:, 9:9:end) = Matrix(:, 9:9:end)/7.0;

    N_Matrix = Matrix < -50;
    Matrix(N_Matrix) = -Matrix(N_Matrix);

    Output_Matrix = Matrix;
end


function Output_Matrix = Legacy_Instruction(Matrix)
   
    for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if itter_rows > 25
                Matrix(itter_rows,itter_column) = abs(Matrix(itter_rows,itter_column));
            end
        end
    end

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_column,9) ~= 0
                Matrix(itter_rows,itter_column) = 7*Matrix(itter_rows,itter_column);
            end
        end
   end

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if Matrix(itter_rows,itter_column) < -50
                Matrix(itter_rows,itter_column) = -Matrix(itter_rows,itter_column);
            end
        end
    end

    Output_Matrix = Matrix;
end

%%
% Вывод: 
% Я думаю, новая функци лучше для матлаба, чем старая. 
% Так как она использует векторизованные операции, функция abs, 
% которая может обрабатывать целые блоки данных за один раз, 
% вместо обработки каждого элемента отдельно. Так же я умножаю целую матрицу на семь, 
% и делю отдельные столбцы на число, так как матлаб обеспечивает простой способ извлечь 
% диапазон элементов.

% Старая функция использует циклы, причем вложенные, а это медленно, O(n^2). 
% Причем мы пробегаемся по каждому элементу матрицы. Функция mod замедляет выполнение программы.

