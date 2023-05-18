clear all;
close all;

%definition and initialization
objectsdir = '..\preprocessing\resources\ProcessedObjects\NoNoisy\';
featuresavedir = 'resources\stripes\';

%initialise folder
folder=dir(objectsdir);
isub = [folder(:).isdir]; %# returns logical vector
nameFolds = {folder(isub).name};
nameFolds(ismember(nameFolds,{'.','..'})) = [];

clear isub;
clear folder;

for folderindex = 1: size(nameFolds,2)
    %get object name, actually it's the subfolder's name
    objectname = nameFolds{folderindex};
    %get all stripes of single object
    allstripes = dir(fullfile([objectsdir,objectname,'\', '*.mat']));
    
    %order the stripe names
    namelist = {allstripes.name};
    str  = sprintf('%s#', namelist{:});
    num  = sscanf(str, '%d.mat#');
    [~, index] = sort(num);
    namelist = namelist(index);
    
    %read all stripes and generate features
    for i = 1:length(namelist)
        load([objectsdir,objectname,'\',namelist{i}]);
        tempname =  regexp(namelist{i},'.mat','split');
        stripename = tempname{1};
        display([objectname,':',num2str(i),'=',stripename]);

        %generate Path of the stripe line
        [StripePath] = f_get_path(OriShape);
        
        %generate three features: length, mean curvature, distance and
        %orientation features
        pathlength = size(StripePath,1); %get stripe length
        [allcur] = f_get_line_curvature(StripePath); %all curvatures
        meancur = mean(allcur); %mean curvature
        [disori] = f_get_distance_orientation(StripePath); %distance and orientation features
   
        DOFeature{i,1} = str2num(stripename);
        DOFeature{i,2} = pathlength;
        DOFeature{i,3} = meancur;
        DOFeature{i,4} = disori;
    end
    
    %save features
%     ObjectFeature{folderindex,1} = objectname;
%     ObjectFeature{folderindex,2} = DOFeature;
    save([featuresavedir,objectname,'.mat'],'DOFeature');
    clear DOFeature;
end

%save([featuresavedir,'allfeatures.mat'],'ObjectFeature');