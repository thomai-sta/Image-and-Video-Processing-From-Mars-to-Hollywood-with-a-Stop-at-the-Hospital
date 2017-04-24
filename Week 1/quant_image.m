function [] = quant_image(intensity_levels, filename)
MAX_INTENSITY = 256;

if (floor(log2(intensity_levels)) ~= ceil(log2(intensity_levels)))
  return
end

%% Read Image
img = double(imread(filename));

ratio = MAX_INTENSITY / intensity_levels;

img_quant = (floor(img / ratio)) * ratio;

img_quant = img_quant / (max(max(img_quant)));

imshow(img_quant);
