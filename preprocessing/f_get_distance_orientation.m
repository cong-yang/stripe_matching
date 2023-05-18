function [ csfeature ] = f_get_distance_orientation( ContourSegment )
%f_CS_12_Feature_LengthDirection: this function is used to generate contour
%                                    segment descriptor using length
%                                    direction matrix
%   input: 
%         ContourSegment: a single contour segment
%   output:
%          csfeature: the contour segment feature using length direction matrix.
%   description:
%          refer to the paper: 
%          Tianyang Ma, et al., From partial shape matching through local
%          deformation to robust global shape similarity for object
%          detection, CVPR 2011.


mylength = size(ContourSegment,1);
distancematrix = zeros(mylength,mylength);
anglematrix = zeros(mylength,mylength);
for i = 1:mylength
    p1 = ContourSegment(i,:);
    for j = 1:mylength
        p2 = ContourSegment(j,:);
        distancematrix(i,j) = log((sqrt(sum((p1 - p2).^2))) + 1);
        p3 = p1 - p2;
        anglematrix(i,j) = atan2(p3(1),p3(2));
    end
end

csfeature{1} = distancematrix;
csfeature{2} = anglematrix;
end

