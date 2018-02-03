clc
clear

address = 'localhost';
port = 8001;

% Starting the TCP server where the DCS data is sent
t = tcpip(address, port, 'NetworkRole', 'server');
t.OutputBufferSize = 3000;
fopen(t);

pause(15);
sentinel = 0;
try
    while true
        if t.BytesAvailable > 0
            fprintf(fgets(t))
            msg_out = DECODE(fgetl(t));
            x_1 = [msg_out.alt msg_out.lat msg_out.long];
            x_2 = [msg_out.bank msg_out.pitch msg_out.heading];         
            sentinel = 0;
        end
        
        sentinel = sentinel + 1;
        if sentinel >= 100; break; end
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