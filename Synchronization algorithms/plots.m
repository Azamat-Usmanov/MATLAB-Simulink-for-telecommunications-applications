clear all; clc
%%
load("Carrier_Synchronizer.mat")
load("desicion_directed.mat")
load("non_data_aided.mat")
%%

Carr = Carrier_Synchronizer.Data.';
Time = Carrier_Synchronizer.Time.';
t = seconds(Time);
res = zeros(1, length(Carr));

for i = 1:length(Carr)
    temp = Carr(i);
    res(i) = mean([temp{:}]);
end
%%
figure
plot(t, res, 'LineWidth', 2)
grid on
title("Carrier Synchronizer")
xlabel('Time, sec')
ylabel('Error Synchronizer')
saveas(gcf, 'Carrier_Synchronizer', 'png')
%%
% Desicion Directed
des = timeseries2timetable(desicion_directed);
Time1 = seconds(des.Time.');
Data1 = des.Data.';
for i = 1:204
   D(i)= mean(Data1(:, i)); 
end

%%
figure
plot(Time1, D)
title('Desicion Directed')
xlabel('Time')
ylabel('Data')
saveas(gcf, 'Desicion_Directed', 'png')
%%
% Non data aided

non = timeseries2timetable(non_data_aided);
Time2 = seconds(non.Time.');
Data2 = non.Data.';
for i = 1:199
   D1(i)= mean(Data2(:, i)); 
end
%%
figure
plot(Time2, D1)
title('Non data aided')
xlabel('Time')
ylabel('Data')
saveas(gcf, 'Non_data_aided', 'png')