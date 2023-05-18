function [ score ] = innerDistMpeg400( n_dist, n_theta, n_contsamp)
folder = 'mpeg400';
n_dist = round(n_dist);
n_theta = round(n_theta);
n_contsamp = round(n_contsamp);

%if exist(strcat('temp/',num2str(n_dist),'-',num2str(n_theta),'-',num2str(n_contsamp),'.mat'))~=2
    addpath common_innerdist
    files = f_getFilesInFolder(strcat('../',folder,'/'));
    addpath(strcat('../',folder));
    imc = size(files,2)

    %-- shape context parameters
    %n_dist		= 5;
    %n_theta		= 12;
    bTangent	= 1;
    bSmoothCont	= 1;
    %n_contsamp	= 100;

    %read all features
    mat = cell(0);
    for i=1:imc
       ims{i}	= double(im2bw(imread(files{i})));
       Cs{i}	= extract_longest_cont(ims{i}, n_contsamp);

       %- inner-dist shape context
       msk		= ims{i};%>.5;
       [sc,V,E,dis_mat,ang_mat] = compu_contour_innerdist_SC( ...
                                        Cs{i},msk, ...
                                        n_dist, n_theta, bTangent, bSmoothCont,...
                                        0);
       mat{1,size(mat,2)+1} = files{i};
       mat{2,size(mat,2)} = sc; 
    end
    clearvars -except mat files imc n_contsamp n_dist n_theta folder

    %start normal code

    for i=1:imc
        im1 = files(i);
        tempname =  regexp(im1,'.png','split');
        im1name = tempname{1}{1};
        disp(strcat(num2str(i),'_',im1name));

        oneToN = f_oneToN(imc,im1, files, mat, n_contsamp);

        [~,order] = sort(cellfun(@(v) v{2}, oneToN));
        MatchingRankedRestlts = oneToN(order);

        OrderedMatchingResults={};
        tempindex = 1;
        for ii = 1:imc
            OrderedMatchingResults{tempindex} = MatchingRankedRestlts{ii};
            tempindex = tempindex + 1;
        end
        allResults{i} = {im1name,OrderedMatchingResults};
    end
    save(strcat('results_',folder,'_',num2str(n_dist),'-',num2str(n_theta),'-',num2str(n_contsamp),'.mat'),'allResults');
    score = f_Data_Analyzing( allResults );
    %save(strcat('temp/',num2str(n_dist),'-',num2str(n_theta),'-',num2str(n_contsamp),'.mat'),'score');
%else
%    load(strcat('temp/',num2str(n_dist),'-',num2str(n_theta),'-',num2str(n_contsamp),'.mat'));
%end
