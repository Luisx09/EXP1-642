% CreateSampleNetwork
% 
% Attempt to create multiple figures
% global f1
% global f2
% f2 = figure;
% f1 = figure;

%% Initialize nodes
% Initialize all three nodes for program
masterHost = 'localhost';
node_1 = robotics.ros.Node('image_acq', masterHost);
node_2 = robotics.ros.Node('image_disp', masterHost);
node_3 = robotics.ros.Node('dist', masterHost);

%% Create a publisher and subscriber for the '/image' topic
imagePub = robotics.ros.Publisher(node_1, '/image', 'sensor_msgs/Image');
imagePubmsg = rosmessage(imagePub);
imageSub = robotics.ros.Subscriber(node_2, 'image');

%% setup publisher timer
% Create a timer for publishing img messages and assign appropriate handles
% The timer will call ImgPublisher at a rate of 10 Hz.
timerHandles.imagePub = imagePub;
timerHandles.imagePubmsg = imagePubmsg;
timerHandles.camObj = webcam(1);
simTimer = ImgTimer(0.1, {@ImgPublisher,timerHandles});

%% setup publisher and subscriber for pixels message.
% Topic is an int32 to send number of white pixels in the image.
% ImgCallback takes it and sends it out to calculate distance to object
global pixPub
global pixPubmsg
pixPub = robotics.ros.Publisher(node_2, '/pixels', 'std_msgs/Int32');
pixPubmsg = rosmessage(pixPub);
pixSub = robotics.ros.Subscriber(node_3, 'pixels');

%% setup subscriber callbacks
sub = robotics.ros.Subscriber(node_2,'/image',@ImgCallback)
subp = robotics.ros.Subscriber(node_3, '/pixels', @DistCallback)
