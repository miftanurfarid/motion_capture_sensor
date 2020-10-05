clearvars; close all; clc;

a = instrfind();
fclose(a);

s = serial('COM3','BAUD', 115200);  % Baud rate and COM port
fopen(s);

while 2 > 1
    out = fscanf(s)
end