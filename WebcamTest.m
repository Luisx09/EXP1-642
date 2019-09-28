%cam = webcam(1);
%I = snapshot(cam);

% Calculate distance
% Get measurements from practical experiment
distances = [ 10 20 30 40 50 60 ]
num_white_pixels = [600 450 360 250 180 100]

plot(distances, num_white_pixels)