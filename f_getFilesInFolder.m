function [paths] = f_getFilesInFolder(path)

files = dir(path); 
names = {files.name};
names = names(3:end);
%paths = strcat(path,names);
paths = names;

end

