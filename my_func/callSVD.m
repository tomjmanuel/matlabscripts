function [ni] = callSVD(im, thresh)
    dim = size(im);
    ni = zeros(dim);
    h = waitbar(0,'Performing SVD');
    for i=1:dim(2)
        [U, S, V] = svd(squeeze(im(:,i,:)));
        ni(:,i,:) = iSVD(U, S, V, thresh);
        waitbar(i/dim(2),h);
    end
    close(h)
end