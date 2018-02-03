function msg_out = DECODE(msg)
% This function decodes the byte array sent from the Lua socket

% Convert to character vector
msg = char(msg);

% Cleaning the string
exp = {' '};
msg = regexprep(msg, exp, '') ;

% Identifying commas and equals signs, used as identifiers
idx_1 = [0 strfind(msg, ',') length(msg) + 1];
idx_2 = strfind(msg, '=');

% Extracting the fields and values
for i = 1:length(idx_2)
    fields{i} = msg(idx_1(i) + 1:idx_2(i) - 1);
    values{i} = msg(idx_2(i) + 1:idx_1(i + 1) - 1);
    if any(isstrprop(values{i}, 'digit'))
       values{i} = str2double(values{i}); 
    end
end

% Converting to structure
msg_out = cell2struct(values, fields, 2);

end

