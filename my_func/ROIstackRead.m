function [fdata, im] = ROIstackRead(Rs)
    %grab image and fluorescent data from roi stack 
    % Rs is roistack

    dim = size(Rs);
    dim2 = size(Rs(1).f);

    fdata = zeros(dim2(1),dim(2));
    for i=1:dim(2)
        fdata(:,i) = Rs(i).f;
    end
    
    im = Rs(1).imGrad;

end