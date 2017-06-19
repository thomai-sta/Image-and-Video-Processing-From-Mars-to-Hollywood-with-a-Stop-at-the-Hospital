function [] = otsus_algo(filename)


img = rgb2gray(imread(filename));
img = imnoise(img, 'gaussian', 0, 0.005);


%% Otsu's