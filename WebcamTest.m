cam = webcam(1);
I = snapshot(cam);

Im = im2double(I);
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
white_pix_num = sum(imClean(:) == 1);
%imText = insertText(imClean, [0 0], white_pix_num);
imshow(imClean);
text(25, 25, int2str(white_pix_num), 'Color', 'white', 'FontSize', 12)



% Calculate distance
% Get measurements from practical experiment
% distances = [ 10 20 30 40 50 60 ]
% num_white_pixels = [600 450 360 250 180 100]
% 
% plot(distances, num_white_pixels)