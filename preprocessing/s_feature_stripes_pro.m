clear all;
close all;

featuredir = 'resources/stripes/';
featuresave = 'resources/stripes_pro/';
allobject = dir(fullfile([featuredir, '*.mat']));

N = length(allobject);
tic
for i = 1:N
    tempname =  regexp(allobject(i).name,'.mat','split');
    objectname = tempname{1};
    load(strcat(featuredir,objectname,'.mat'));
    display([num2str(i),'=',objectname]);
    for j = 1:size(DOFeature,1)
        if DOFeature{j,2} ~= 0
            meandis = DOFeature{j,4}{1};
            lmatrix = tril(meandis);
            mydistance = mean(mean(lmatrix));

            meanangle = DOFeature{j,4}{2};
            amatrix = tril(meanangle);
            myangle = mean(mean(amatrix));

            myfeature(j,1) = DOFeature{j,2}; %length feature
            myfeature(j,2) = mydistance; %distance feature
            myfeature(j,3) = myangle; %orientation feature
        else
            myfeature(j,1) = 0; %length feature
            myfeature(j,2) = 0; %distance feature
            myfeature(j,3) = 0; %orientation feature
        end
    end

    AllFeature{i,1} = objectname;
    AllFeature{i,2} = myfeature;
    clear myfeature;
    clear DOFeature;
end
toc
display('Finished');