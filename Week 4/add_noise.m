function [] = add_noise(filename)

img = imread(filename);

% %% Gaussian noise
% for sigma = 0.01:0.05:0.5
%   for mu = 0:0.1:0.5
%     img_noise = imnoise(img, 'gaussian', mu, sigma);
%     figure('Visible','off'); imshow(img_noise);
%     saveas(gcf, ['noisy_images/gaussian_' num2str(mu) '_' num2str(sigma) '.pgm']); close;
%   end
% end

%% Salt n pepper
for percent = 0.001:0.05:0.5
  img_noise = imnoise(img, 'salt & pepper', percent);
  
  figure('Visible','off'); imshow(img_noise);
    saveas(gcf, ['noisy_images/saltnpepper_' num2str(percent) '.pgm']); close;
end