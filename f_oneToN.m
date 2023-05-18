function [ oneToN ] = f_oneToN( imc, im1, files, mat, n_contsamp)
%F_ONETON Summary of this function goes here
%   Detailed explanation goes here
    for j=1:imc
        im2 = files(j);
        tempname =  regexp(im2,'.pgm','split');
        im2name = tempname{1}{1};
        cost = f_innerdist(im1{1},im2{1},mat, n_contsamp);
        oneToN{j} = {im2name,cost};
    end

end

