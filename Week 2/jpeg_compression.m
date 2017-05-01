function [] = jpeg_compression(filename, N)

QUANT =double([16 11 10 16 24  40  51  61
  12 12 14 19 26  58  60  55
  14 13 16 24 40  57  69  56
  14 17 22 29 51  87  80  62
  18 22 37 56 68  109 103 77
  24 35 55 64 81  104 113 92
  49 64 78 87 103 121 120 101
  72 92 95 98 112 100 103 99]);


img = (imread(filename));

fun_dct2 = @(x) dct2(x.data);
img_dct = blockproc(img, [8 8], fun_dct2);

%% JPEG TABLE
fun_quantize = @(x) floor(x.data ./ QUANT) .* QUANT;
img_jpeg = blockproc(img_dct, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg = blockproc(img_jpeg, [8 8], fun_idct2);

img_jpeg = img_jpeg / max(max(img_jpeg));

imshowpair(img, img_jpeg, 'montage')
title('JPEG Quantization table')

%% N
fun_quantize = @(x) floor(x.data ./ N) .* N;
img_jpeg_N = blockproc(img_dct, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_N = blockproc(img_jpeg_N, [8 8], fun_idct2);

img_jpeg_N = img_jpeg_N / max(max(img_jpeg_N));

figure
imshowpair(img, img_jpeg_N, 'montage')
title('JPEG N Quantization')

%% 2N
fun_quantize = @(x) floor(x.data ./ (2 * N)) .* (2 * N);
img_jpeg_2N = blockproc(img_dct, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_2N = blockproc(img_jpeg_2N, [8 8], fun_idct2);

img_jpeg_2N = img_jpeg_2N / max(max(img_jpeg_2N));

figure
imshowpair(img, img_jpeg_2N, 'montage')
title('JPEG 2N Quantization')


%% 6N
fun_quantize = @(x) floor(x.data ./ (6 * N)) .* (6 * N);
img_jpeg_6N = blockproc(img_dct, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_6N = blockproc(img_jpeg_6N, [8 8], fun_idct2);

img_jpeg_6N = img_jpeg_6N / max(max(img_jpeg_6N));

figure
imshowpair(img, img_jpeg_6N, 'montage')
title('JPEG 6N Quantization')

%% 10N
fun_quantize = @(x) floor(x.data ./ (10 * N)) .* (10 * N);
img_jpeg_10N = blockproc(img_dct, [8 8], fun_quantize);

fun_idct2 = @(x) idct2(x.data);
img_jpeg_10N = blockproc(img_jpeg_10N, [8 8], fun_idct2);

img_jpeg_10N = img_jpeg_10N / max(max(img_jpeg_10N));

figure
imshowpair(img, img_jpeg_10N, 'montage')
title('JPEG 6N Quantization')

%% 8 largest DCT coeff
[rows, cols] = size(img);

row_dim = 8 * ones(1, floor(rows / 8));

if (mod(rows, 8) ~= 0)
  row_dim = [row_dim mod(rows, 8)];
end

col_dim = 8 * ones(1, floor(cols / 8));

if (mod(cols, 8) ~= 0)
  col_dim = [col_dim mod(cols, 8)];
end

blocks = mat2cell(img, row_dim, col_dim);
blocks_jpeg = cell(size(blocks));

for i = 1:length(row_dim)
  for j = 1:length(col_dim)
    temp = dct2(blocks{i, j});
    [~, sorted_indices] = sort(temp(:), 'descend');
    max_indices = sorted_indices(1:8);
    temp_1 = zeros(size(temp));
    for ind = 1:8
      [ind_i, ind_j] = ind2sub([8, 8], max_indices(ind));
      temp_1(ind_i, ind_j) = temp(ind_i, ind_j);
    end
    blocks_jpeg{i, j} = idct2(floor(temp_1));
  end
end

img_jpeg_8L = cell2mat(blocks_jpeg);
img_jpeg_8L = img_jpeg_8L / max(max(img_jpeg_8L));

figure
imshowpair(img, img_jpeg_8L, 'montage')
title('JPEG 8 Largest Coeffs')

