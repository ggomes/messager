clear

root_folder = fileparts(mfilename('fullpath'));
message_folder = fullfile(root_folder,'messages');

% read the files
message_folder_dir = dir(message_folder);
message_struct = struct('file','','msg','');
all_messages = repmat(message_struct,1,0);
for file = dir(message_folder)'
    
    if file.isdir
        continue
    end
    
    fid = fopen(fullfile(message_folder,file.name),'r');
    new_msg = message_struct;
    new_msg.file = file.name;
    while 1
        tline = fgetl(fid);
        if ~ischar(tline), break, end
        new_msg.msg = strcat(new_msg.msg,tline);
    end
    fclose(fid);
    
    all_messages(end+1) = new_msg;
end

% write all to a csv file
fid = fopen(fullfile(root_folder,'output.txt'),'w');
for message = all_messages
    fprintf(fid,'%s\t%s\n',message.file,message.msg);
end
fclose(fid);
