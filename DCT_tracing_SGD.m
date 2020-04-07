clc;clear;close all;
% Shivani Dhok
% Date: March 5, 2020
% Digital Image Processing
% Program for: DCT Tracing

x = [1 2 6 7 ; 3 5 8 13; 4 9 12 14; 10 11 15 16];
[row col] = size(x);
if rem(row,2) == 0
    N = row-1;
else 
    N = row-1;
end
XX = DctTracing(x);
n = -N:N;
X = [];
for ii = 1:length(n)
    if rem(ii,2) == 0
        X = [X fliplr(transpose(diag(flipud(x),n(ii))))];
    else
        X = [X transpose(diag(flipud(x),n(ii)))];
    end
end

