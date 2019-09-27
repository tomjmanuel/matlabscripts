function [ni,nistack] = iter_conv(im, B, n)
%repeat convolve an image with B
%im is image
%n is number of iterations
%ni is result
%nistack is progress stack (for funzees)

    
    dim = size(im);
    nistack = zeros(dim(1),dim(2),n+1);
    nistack(:,:,1) = im;
    temp = im;
    
    for i=1:n
        temp = conv2(temp,B,'SAME');
        nistack(:,:,n+1) = temp;
    end

    ni = nistack(:,:,end);
end

