function ImgPublisher(~, ~, handles)
    %   Publisher - Timer update function to publish
    %   messages at well-defined intervals. Publishes /cmd_vel messages at
    %   regular intervals, with random values.
   
        
    % Update the pose message values
    if isvalid(handles.imagePub)
        Img = snapshot(handles.camObj);
        
        handles.imagePubmsg.Encoding = "rgb8";
        %handles.imagePubmsg.Step = size(Img, 1);
        handles.imagePubmsg.writeImage(Img);


        % Publish the pose message
        send(handles.imagePub,handles.imagePubmsg);
    end
       
end