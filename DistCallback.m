function DistCallback(~, message)
% Load number of white pixels in image and then calculate distance with
% inverse quadratic formula
pix = single(message.Data);
dist = 1/590 * (13000 - sqrt(-8000000 + 590 * pix))

% Attempt to display as separate figure
% figure(f2);
% 
% text(int2str(0,0,dist));


