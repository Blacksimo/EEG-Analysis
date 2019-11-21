fileID = fopen('channel_locations.txt','r');
data=textscan(fileID,'%u%s%f%f');
fclose(fileID);