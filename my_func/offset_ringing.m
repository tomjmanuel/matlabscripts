function [ni] = offset_ringing(im,sf);

    % make 2D weighting function (will look like parabola)
    dim = size(im);
    w = zeros(dim(1),dim(2));
    for i=1:dim(1)
        for j=1:dim(2)
            w(i,j) = (i-dim(1)/2)^2 + (j-dim(2)/2)^2;
        end
    end

    w = w./max(w(:)); %normalize
    w = w.*sf; % stretch to match desired range
    wr = repmat(w,[1,1,dim(3)]);
    ni = im +wr; % add to image

end



