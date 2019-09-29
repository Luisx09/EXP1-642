function ImgCallback(~, message)
% SARPoseCallback Subscriber callback function for cmd_vel data
%   Returns no arguments - it instead uses to persistent variables (static
%   variables) to maintain a state and plot the position and orientation of
%   a simple robot; designed to be similar to ROS's TurtleSim.
% global f1
% figure(f1)
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
% imBinary = zeros(r,c);
% for row = 1:r
%     for column = 1:c
%         red_pix = Im(r,c,1);
%         green_pix = Im(r,c,2);
%         blue_pix = Im(r,c,3);
%         if ((blue_pix > (red_pix)) && (blue_pix > (green_pix)))
%             imBinary(r,c) = 1;
%         else
%             imBinary(r,c) = 0;
%         end
%     end
% end
%se = strel(
%imClean = imopen(imBinary, se);
%imshow(imBinary);
imClean = imfill(imBinary, 'holes');
%imClean = imclearborder(imClean);
white_pix_num = sum(imClean(:) == 1);
imshow(imClean);
text(25, 25, int2str(white_pix_num), 'Color', 'white', 'FontSize', 12);

global pixPub
global pixPubmsg
pixPubmsg.Data = white_pix_num;
send(pixPub, pixPubmsg);

end