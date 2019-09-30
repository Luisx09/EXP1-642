function ImgCallback(~, message)
% Subscriber function for image processing

%% Read image from message
dispImg = readImage(message);
Im = im2double(dispImg);
[r c p] = size(Im);

%% Process image
% Binarize image to black and white.
imR = squeeze(Im(:,:,1));
imG = squeeze(Im(:,:,2));
imB = squeeze(Im(:,:,3));
imBinaryR = imbinarize(imR);
imBinaryG = imbinarize(imG);
imBinaryB = imbinarize(imB);
imBinary = imcomplement(imBinaryR&imBinaryG&imBinaryB);
%imshow(imBinary);
%
% Attempted to use iterating loops to set pixel thresholds

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
%% Clean up image
imClean = imfill(imBinary, 'holes');
%imClean = imclearborder(imClean);

%% Calculate white pixel amount and display it with image
white_pix_num = sum(imClean(:) == 1);
imshow(imClean);
text(25, 25, int2str(white_pix_num), 'Color', 'white', 'FontSize', 12);

%% Publish number of white pixels
global pixPub
global pixPubmsg
pixPubmsg.Data = white_pix_num;
send(pixPub, pixPubmsg);

end