function DistCallback(~, message)
% global f2
% equation would be 
pix = single(message.Data);
dist = 1/590 * (13000 - sqrt(-8000000 + 590 * pix))
% figure(f2);
% 
% text(int2str(0,0,dist));


