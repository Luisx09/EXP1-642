cam = webcam(2);
I = snapshot(cam);

Im = im2double(I);
[r c p] = size(Im);
% 
imR = squeeze(Im(:,:,1));
imG = squeeze(Im(:,:,2));
imB = squeeze(Im(:,:,3));
% %imshow(imB);
imBinaryR = im2bw(imR, graythresh(imR)*0.5);
imBinaryG = im2bw(imG, graythresh(imG)*0.5);
imBinaryB = im2bw(imB, graythresh(imB) * 0.9);
% %imBinaryR = imbinarize(imR);
% %imBinaryG = imbinarize(imG);
% %imBinaryB = imbinarize(imB * 0.5);
% imshow(imBinaryB)
imBinary = imcomplement(imBinaryR&imBinaryG&imBinaryB);
%imshow(imBinary);

%imBinary = imbinarize(I);
for row = 1:r
    for column = 1:c
        red_pix = I(r,c,1);
        green_pix = I(r,c,2);
        blue_pix = I(r,c,3);
        if ((blue_pix > (red_pix)) && (blue_pix > (green_pix)))
            imBinary(r,c) = 1;
        else
            imBinary(r,c) = 0;
        end
    end
end
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