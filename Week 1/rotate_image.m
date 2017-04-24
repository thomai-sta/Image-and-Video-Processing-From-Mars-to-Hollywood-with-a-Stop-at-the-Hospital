function [] = rotate_image(filename, degrees)

img = imread(filename);

img_rotated = imrotate(img, degrees, 'bicubic', 'loose');

imshow(img_rotated)