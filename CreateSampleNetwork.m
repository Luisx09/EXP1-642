%   SARCreateSampleNetwork, Create an example ROS network
%   This network features two nodes, 1 publisher, 1 subscriber. Additionally we use a
%   timer to control publishing of ROS messages over the network.
% global f1
% global f2
% f2 = figure;
% f1 = figure;

%% Initialize two nodes (in addition to the global MATLAB node that is 
% created through rosinit). Note that the nodes will try to connect to the
% ROS master at 'localhost'. If you are connecting to an external master,
% you will have to use its IP address or hostname.
masterHost = 'localhost';
node_1 = robotics.ros.Node('image_acq', masterHost);
node_2 = robotics.ros.Node('image_disp', masterHost);
node_3 = robotics.ros.Node('dist', masterHost);

%% Create a publisher and subscriber for the '/image' topic
imagePub = robotics.ros.Publisher(node_1, '/image', 'sensor_msgs/Image');
imagePubmsg = rosmessage(imagePub);
imageSub = robotics.ros.Subscriber(node_2, 'image');

%% setup publisher timer
% Create a timer for publishing messages and assign appropriate handles
% The timer will call SARPublisher at a rate of 10 Hz.
timerHandles.imagePub = imagePub;
timerHandles.imagePubmsg = imagePubmsg;
timerHandles.camObj = webcam(2);
simTimer = ImgTimer(0.1, {@ImgPublisher,timerHandles});
global pixPub
global pixPubmsg
pixPub = robotics.ros.Publisher(node_2, '/pixels', 'std_msgs/Int32');
pixPubmsg = rosmessage(pixPub);
pixSub = robotics.ros.Subscriber(node_3, 'pixels');
%% setup subscriber callback
sub = robotics.ros.Subscriber(node_2,'/image',@ImgCallback)

subp = robotics.ros.Subscriber(node_3, '/pixels', @DistCallback)
