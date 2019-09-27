function [A] = stackRead(fname)

    info = imfinfo(fname);
    num_images = numel(info);
    A = zeros(info(1,1).Height,info(1,1).Width,num_images);
    for k = 1:num_images
        A(:,:,k) = imread(fname, k, 'Info', info);
        % ... Do something with image A ...
    end
    
end