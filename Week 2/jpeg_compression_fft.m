function [] = jpeg_compression_fft(filename, N)

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

fun_fft2 = @(x) fft2(x.data);
img_fft = blockproc(img, [8 8], fun_fft2);

%% JPEG TABLE
fun_quantize = @(x) floor(x.data ./ QUANT) .* QUANT;
img_jpeg = blockproc(img_fft, [8 8], fun_quantize);

fun_ifft2 = @(x) ifft2(x.data);
img_jpeg = blockproc(img_jpeg, [8 8], fun_ifft2);

img_jpeg = real(img_jpeg / max(max(img_jpeg)));

imshowpair(img, img_jpeg, 'montage')
title('JPEG Quantization table')

%% N
fun_quantize = @(x) floor(x.data ./ N) .* N;
img_jpeg_N = blockproc(img_fft, [8 8], fun_quantize);

fun_ifft2 = @(x) ifft2(x.data);
img_jpeg_N = blockproc(img_jpeg_N, [8 8], fun_ifft2);

img_jpeg_N = real(img_jpeg_N / max(max(img_jpeg_N)));

figure
imshowpair(img, img_jpeg_N, 'montage')
title('JPEG N Quantization')

%% 2N
fun_quantize = @(x) floor(x.data ./ (2 * N)) .* (2 * N);
img_jpeg_2N = blockproc(img_fft, [8 8], fun_quantize);

fun_ifft2 = @(x) ifft2(x.data);
img_jpeg_2N = blockproc(img_jpeg_2N, [8 8], fun_ifft2);

img_jpeg_2N = real(img_jpeg_2N / max(max(img_jpeg_2N)));

figure
imshowpair(img, img_jpeg_2N, 'montage')
title('JPEG 2N Quantization')


%% 6N
fun_quantize = @(x) floor(x.data ./ (6 * N)) .* (6 * N);
img_jpeg_6N = blockproc(img_fft, [8 8], fun_quantize);

fun_ifft2 = @(x) ifft2(x.data);
img_jpeg_6N = blockproc(img_jpeg_6N, [8 8], fun_ifft2);

img_jpeg_6N = real(img_jpeg_6N / max(max(img_jpeg_6N)));

figure
imshowpair(img, img_jpeg_6N, 'montage')
title('JPEG 6N Quantization')

%% 10N
fun_quantize = @(x) floor(x.data ./ (10 * N)) .* (10 * N);
img_jpeg_10N = blockproc(img_fft, [8 8], fun_quantize);

fun_ifft2 = @(x) ifft2(x.data);
img_jpeg_10N = blockproc(img_jpeg_10N, [8 8], fun_ifft2);

img_jpeg_10N = real(img_jpeg_10N / max(max(img_jpeg_10N)));

figure
imshowpair(img, img_jpeg_10N, 'montage')
title('JPEG 6N Quantization')
