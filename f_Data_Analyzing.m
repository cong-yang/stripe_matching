function [ finalscore ] = f_Data_Analyzing( TotalResults)
%f_Data_Analyzing This function is used for calculate the corrected matches
%and the bulls eye score
%Input:
%      TotalResults: retrieval results
%      New_Diff: the affinity matrix of similarity between each pair of
%                objects.
%      nrobjectsperclass: The number of objects per class
%      nrofmatches: The number of matches thar should be conidered as correct.
%                   nrofmatches > nrobjectsperclass
%      topcount: to print the number of correct matches among the topcount
%                position.
%Output:
%       bullseye: score of bulls eye test

[~,querysize] = size(TotalResults);
ResultMatrix = zeros(querysize,querysize);
for mm = 1: querysize
    queryname = TotalResults{mm}{1};
    tempcategory = regexp(queryname,'\d*','split');
    category = tempcategory{1};
    %display(category{1});
    MatchingResults = TotalResults{mm}{2};
    for kk = 1: querysize
        objectname = MatchingResults{kk}{1};
        tempobjectname = regexp(objectname,'\d*','split');
        objectcategory = tempobjectname{1};
        if strcmp(objectcategory,category) == 1
            ResultMatrix(kk,mm) = 1;
        end
    end
end

showingresult = zeros(querysize,2);
for i = 1:querysize
    showingresult(i,1) = i;
    showingresult(i,2) = sum(ResultMatrix(i,:));
end
display(showingresult);
% display(size(showingresult,1));

finalscore = 0;
percent = querysize;
for m = 1:querysize
    display(strcat(num2str(showingresult(m,1)),'=',num2str(showingresult(m,2)),','));
    finalscore = finalscore + showingresult(m,2) * percent * percent;
    percent = percent - 1;
end


end

