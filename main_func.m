function [] = main_func(filename)
    % import data from file
    DATA = importdata(filename,',',1);
    % select the points we need
    [x, y, z, vx, vy, vz] = selectPoints(DATA(1),Data(2),DATA(3),DATA(4),DATA(5),DATA(6),1,2,5);
    % next steps:
    % magdir
    % 
end