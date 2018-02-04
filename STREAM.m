clc
clear

% Animation
h = Aero.Animation;
h.FramesPerSecond = 30;
h.TimeScaling = 1;
idx1 = h.createBody('Su-25.ac','Ac3d');
h.show();
h.Camera.PositionFcn = @staticCameraPosition;

% Starting the TCP server where the DCS data is sent
address = 'localhost';
port = 8001;
t = tcpip(address, port, 'NetworkRole', 'server');
t.OutputBufferSize = 3000;
disp('Waiting for DCS client connection.')
fopen(t);
disp('Connected.')

pause(15);
sentinel = 0;
t_previous = 0;
flushinput(t)
try
    while true
        if t.BytesAvailable > 0
            msg_out = DECODE(fgetl(t));

            % Drawing the plane's updated position and orientation
            h.moveBody(1, [msg_out.lat msg_out.long msg_out.alt], [msg_out.bank msg_out.pitch msg_out.heading]);
            h.updateCamera(0);
            t_previous = msg_out.t;
            
            % Clearing the back log in the buffer
            flushinput(t)
            sentinel = 0;  
        end
        
        sentinel = sentinel + 1;
        if sentinel >= 500; break; end
    end
    
catch ME
    fclose(t);
    delete(t)
    clear t
    rethrow(ME)
end

try
    fclose(t);
    delete(t)
    clear t
end

disp('Disconnected.')