function [] = edge_detector(filename)

img = imread(filename);


if (size(img, 3) == 3)
  disp('here')
  [Gmag_1, Gdir_1] = imgradient(img(:, :, 1));
  [Gmag_2, Gdir_2] = imgradient(img(:, :, 2));
  [Gmag_3, Gdir_3] = imgradient(img(:, :, 3));
  
  Gmag = (Gmag_1 + Gmag_2 + Gmag_3) / 3;
  Gdir = (Gdir_1 + Gdir_2 + Gdir_3) / 3;
else
  
  [Gmag, Gdir] = imgradient(img);
  
end

figure; imshowpair(Gmag, Gdir, 'montage');