% ---------------------------------------------------------------------
% The FSE_LSE.dat file contains the date, DAX index values, stock
% prices of 20 largest companies at Frankfurt Stock Exchange (FSE), 
% FTSE 100 index values and stock prices of 20 largest companies at 
% London Stock Exchange (LSE) from 1998 to 2007
% ---------------------------------------------------------------------
%clear variables and close windows
clear all; close all; clc;
% Read dataset
Ydata = load('FSE_LSE.dat');
Price = Ydata(:,2:43);                       % closing prices
y = price2ret(Price);                        % log returns  
date = Ydata(2:end,1);                   % dates vector 
n = length(y);                           % sample size
t =  1:n;                                % time index, t
plot(t, y(:, [1 22])) % DAX and FTSE  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = 0.06;
y1 = y(:,1);
ewma_1 = filter(1, [1 -(1-lambda)], lambda * y1.^2)
plot(t, y1.^2); hold on;
plot(t, ewma_1, 'r'); hold off;
y2 = y(:, 22);
ewma_12 = filter(1, [1 -(1-lambda)], lambda * y1 .* y2)
ewma_2 = filter(1, [1 -(1-lambda)], lambda * y2.^2)
plot(t, y1 .* y2); hold on;
plot(t, ewma_12, 'r'); hold off;
plot(t, ewma_12 ./ sqrt(ewma_1 .* ewma_2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 