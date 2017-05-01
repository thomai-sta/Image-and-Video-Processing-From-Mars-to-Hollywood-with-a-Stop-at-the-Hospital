function [] = jpeg_compression_colour(filename, N)

close all

QUANT =double([16 11 10 16 24  40  51  61
  12 12 14 19 26  58  60  55
  14 13 16 24 40  57  69  56
  14 17 22 29 51  87  80  62
  18 22 37 56 68  109 103 77
  24 35 55 64 81  104 113 92
  49 64 78 87 103 121 120 101
  72 92 95 98 112 100 103 99]);

img = (imread(filename));

img_YCbCr = rgb2ycbcr(img);

img_Y = img_YCbCr(:, :, 1);
img_Cb = img_YCbCr(:, :, 2);
img_Cr = img_YCbCr(:, :, 3);

%% Y
fun_dct2 = @(x) dct2(x.data);
img_dct_Y = blockproc(img_Y, [8 8], fun_dct2);

fun_quantize = @(x) floor(x.data ./ QUANT) .* QUANT;
img_jpeg_Y = blockproc(img_dct_Y, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_Y = blockproc(img_jpeg_Y, [8 8], fun_idct2);

img_jpeg_Y = img_jpeg_Y / max(max(img_jpeg_Y));


%% Cb
fun_dct2 = @(x) dct2(x.data);
img_dct_Cb = blockproc(img_Cb, [8 8], fun_dct2);

fun_quantize = @(x) floor(x.data ./ (QUANT * N)) .* (QUANT * N);
img_jpeg_Cb = blockproc(img_dct_Cb, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_Cb = blockproc(img_jpeg_Cb, [8 8], fun_idct2);

img_jpeg_Cb = img_jpeg_Cb / max(max(img_jpeg_Cb));


%% Cr
fun_dct2 = @(x) dct2(x.data);
img_dct_Cr = blockproc(img_Cr, [8 8], fun_dct2);

fun_quantize = @(x) floor(x.data ./ (QUANT * N)) .* (QUANT * N);
img_jpeg_Cr = blockproc(img_dct_Cr, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_Cr = blockproc(img_jpeg_Cr, [8 8], fun_idct2);

img_jpeg_Cr = img_jpeg_Cr / max(max(img_jpeg_Cr));


img_jpeg_YCbCr = cat(3, img_jpeg_Y, img_jpeg_Cb, img_jpeg_Cr);

img_jpeg_RGB = ycbcr2rgb(img_jpeg_YCbCr);


imshowpair(img, img_jpeg_RGB, 'montage')
title('JPEG Quantization table')
