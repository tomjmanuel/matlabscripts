function [imcr, imr] = reg_Im(im,nic)
    % This function is a wrapper for ibdftreg
    % written to work with balanced stacks saved from calcium image
    % processor
    % inputs: im; fluorescent image stack (distributed 0 to 255)
    % outputs: imr; registered images
    %          imcr; registered high contrast images (used for
    %          calculations)
    
    imc = nic;
    imf = fft2(im); 
    imcf = fft2(imc);

    dim = size(im);
    imr = zeros(dim);
    imr(:,:,1) = im(:,:,1);
    imcr = imr;
    imcr(:,:,1) = imc(:,:,1);

 %   w = waitbar(0,'Registering images');
    for i=2:dim(3)
        [~, hc, lc] = ibDFTregistration(imcf(:,:,1),imcf(:,:,i),imf(:,:,i),1);
        imr(:,:,i) = abs(ifft2(lc));
        imcr(:,:,i) = abs(ifft2(hc));
       % waitbar(i/dim(3),w);
    end
  %  close(w);
    
end