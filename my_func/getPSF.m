% Tom 8/21
% Get lateral and axial FWHM from an image

function [fwhmz, fwhmx, maxI] = getPSF(im)

    % First get index and value of max point in index
    [M,I] = max(im); 
    [M2,I2] = max(M); % I2 is max along second dimension; M2 is peak intensity
    I1 = 0;
    maxI = M2;
    for i=1:length(M)
        if M(i) == M2
            I1 = I(i); % This is index of max along first dimension
        end
    end

    %% Get Lateral Psf (dim2)
    Hm = M2/2; %Half max
    curr = M2; %traverser variable
    width = 1;
    % Go to right first
    while curr>=Hm
        curr = im(I1,I2+width);
        width = width+1;
    end
    fwhmx = width-1; % Here latfwhm holds later width to right + peak point
    % Now check left
    curr = M2;
    width=1;
    while curr>=Hm
        curr = im(I1,I2-width);
        width = width+1;
    end
    fwhmx = fwhmx+width -2; % Lateral fwhm in pixels

    %% Get Axial Psf (dim1)
    Hm = M2/2; %Half max
    curr = M2; %traverser variable
    width = 1;
    % Go down first
    while curr>=Hm
        curr = im(I1+width,I2);
        width = width+1;
    end
    fwhmz = width-1;
    % Now check up
    curr = M2;
    width=1;
    while curr>=Hm
        curr = im(I1-width,I2);
        width = width+1;
    end
    fwhmz = fwhmz+width -2; % Lateral fwhm in pixels

end
    
