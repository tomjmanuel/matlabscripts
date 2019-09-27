% take the time derivative of a 3d image (3rd dim is time)
function [ni] = timeDeriv(im)
    dim = size(im);
    ni = zeros(dim);
    h = waitbar(0, 'Calculating Gradient')
    for i=1:dim(2)
        [Gmag, ~] = imgradient(squeeze(im(:,i,:)));
        ni(:,i,:) = Gmag;
        waitbar(i/dim(2), h);
    end
    close(h);
end
