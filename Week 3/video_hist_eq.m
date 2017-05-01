function [] = video_hist_eq(filename)

vidObj = VideoReader(filename);

vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

% Preallocate movie structure.
mov = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
  'colormap', []);

k = 1;
f = 1;
large_frame_R = [];
large_frame_G = [];
large_frame_B = [];
while hasFrame(vidObj)
  if f < 10
    frame = readFrame(vidObj);
    large_frame_R = [large_frame_R frame(:, :, 1)];
    large_frame_G = [large_frame_G frame(:, :, 2)];
    large_frame_B = [large_frame_B frame(:, :, 3)];
    f = f + 1;
  else
    large_frame_R = histeq(large_frame_R);
    large_frame_G = histeq(large_frame_G);
    large_frame_B = histeq(large_frame_B);
    
    curr_frame = zeros(vidHeight, vidWidth, 3);
    
    s = 1;
    e = vidWidth;
    size(large_frame_R)
    for i = 1:f - 1
      curr_frame(:, :, 1) = large_frame_R(:, s:e);
      curr_frame(:, :, 2) = large_frame_G(:, s:e);
      curr_frame(:, :, 3) = large_frame_B(:, s:e);
      s = s + vidWidth;
      e = e + vidWidth;
      
      mov(k).cdata = curr_frame;
      k = k + 1;
    end
    large_frame_R = [];
    large_frame_G = [];
    large_frame_B = [];
  end
  f = 1;
  
  mov(k).cdata = frame;
  k = k + 1;
end

disp('Equalization complete');

% Size a figure based on the video's width and height.
hf = figure; set(hf, 'position', [1 1 vidWidth vidHeight]);

% Play back the movie once at the video's frame rate.
movie(hf, mov, 1, vidObj.FrameRate);