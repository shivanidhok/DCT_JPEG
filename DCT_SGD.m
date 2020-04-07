clc;clear;close all;
% Shivani Dhok
% Date: March 12, 2020
% Digital Image Processing
% Program for: DCT Tracing
I = imread('lena2.png');
I_gray = rgb2gray(I);
I_gray = double(I_gray) - (128.*ones(512));

I_changed = zeros(512,512);
I_quantized = zeros(512,512);

Q50 = [ 16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
DCT_matrix8 = dct(eye(8));
iDCT_matrix8 = DCT_matrix8';
I_vectorized = [];
M = [];
for ii = 1:512/8
    for jj = 1:512/8
        I_sub = I_gray((ii-1)*8+1:(ii-1)*8+8,(jj-1)*8+1:(jj-1)*8+8);
        D = dct2(I_sub);
        if ii == 1 & jj == 1
            Var = var(D(:));
        else
            M = [M mean(D(:))];
        end
        I_dct = DCT_matrix8*dct2(I_sub)*iDCT_matrix8;
        I_quant = round(I_dct./Q50);
        I_quantized((ii-1)*8+1:(ii-1)*8+8,(jj-1)*8+1:(jj-1)*8+8) = I_quant;
        I_changed((ii-1)*8+1:(ii-1)*8+8,(jj-1)*8+1:(jj-1)*8+8) = I_dct;
        I_vect = DctTracing(I_quant);
        I_vectorized = [I_vectorized; I_vect];
    end
end
%%
Checksum = [];
RLE = cell(size(I_vectorized,1),1);
for ii = 1:size(I_vectorized,1)
    vec = I_vectorized(ii,:);
    AA = RLE1_SGD(vec);
    RLE(ii) = mat2cell(AA,1);
    Checksum = [Checksum sum(AA(2:2:end))];
end

