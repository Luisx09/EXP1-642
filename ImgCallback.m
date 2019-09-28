function ImgCallback(~, message)
% SARPoseCallback Subscriber callback function for cmd_vel data
%   Returns no arguments - it instead uses to persistent variables (static
%   variables) to maintain a state and plot the position and orientation of
%   a simple robot; designed to be similar to ROS's TurtleSim.


dispImg = readImage(message);
Im = im2double(dispImg);
[r c p] = size(Im);

imR = squeeze(Im(:,:,1));
imG = squeeze(Im(:,:,2));
imB = squeeze(Im(:,:,3));

%imBinaryR = im2bw(imR, graythresh(imR));
%imBinaryG = im2bw(imG, graythresh(imG));
%imBinaryB = im2bw(imB, graythresh(imB));
imBinaryR = imbinarize(imR);
imBinaryG = imbinarize(imG);
imBinaryB = imbinarize(imB);

imBinary = imcomplement(imBinaryR&imBinaryG&imBinaryB);
%imshow(imBinary);

%se = strel(
%imClean = imopen(imBinary, se);

imClean = imfill(imBinary, 'holes');
%imClean = imclearborder(imClean);
imshow(imClean);

end