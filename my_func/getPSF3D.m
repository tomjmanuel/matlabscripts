% Tom 8/21
% Get lateral and axial FWHM from an image

function [fwhmz, fwhmx, fwhmy] = getPSF3D(im)

    % First get index and value of max point in image
    maxI = max(im(:));
    c = find(im == maxI);
    [dim1,dim2,dim3] = ind2sub(size(im),c);
    % dim1 is depth (z)
    % dim2 is lateral (x)
    % dim3 is lateral also (y)

    %% Get Lateral Psf (dim2)
    Hm = maxI/2; %Half max
    curr = maxI; %traverser variable
    width = 1;
    % Go to right first
    while curr>=Hm
        curr = im(dim1,dim2+width,dim3);
        width = width+1;
    end
    fwhmx = width-1; % Here latfwhm holds later width to right + peak point
    % Now check left
    curr = maxI;
    width=1;
    while curr>=Hm
        curr = im(dim1,dim2-width,dim3);
        width = width+1;
    end
    fwhmx = fwhmx+width -2; % Lateral fwhm in pixels
    
        %% Get Lateral Psf (dim3)
    Hm = maxI/2; %Half max
    curr = maxI; %traverser variable
    width = 1;
    % Go to right first
    while curr>=Hm
        curr = im(dim1,dim2,dim3+width);
        width = width+1;
    end
    fwhmy = width-1; % Here latfwhm holds later width to right + peak point
    % Now check left
    curr = maxI;
    width=1;
    while curr>=Hm
        curr = im(dim1,dim2,dim3-width);
        width = width+1;
    end
    fwhmy = fwhmy+width -2; % Lateral fwhm in pixels

    %% Get Axial Psf (dim1)
    Hm = maxI/2; %Half max
    curr = maxI; %traverser variable
    width = 1;
    % Go to right first
    while curr>=Hm
        curr = im(dim1+width,dim2,dim3);
        width = width+1;
    end
    fwhmz = width-1; % Here latfwhm holds later width to right + peak point
    % Now check left
    curr = maxI;
    width=1;
    while curr>=Hm
        curr = im(dim1-width,dim2,dim3);
        width = width+1;
    end
    fwhmz = fwhmz+width -2; % Lateral fwhm in pixels

end
    
