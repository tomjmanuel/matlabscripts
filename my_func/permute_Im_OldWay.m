function [pValIm] = permute_Im_OldWay(im1, nbf)
    % Calculate permuted p value of image stack
    % Tom
    %12 14 18
    % refer to onenote, biostats meeting for explanation
    % function wrapper called batch_Permute_Im
    % nbf =  number of baseline frames
    
    % this script doesn't work well

    nPerm = 999;

    % Get mean before and after
    mb = mean(im1(:,:,1:nbf),3);
    mpb = mean(im1(:,:,nbf+1:end),3);
    dif = mpb  - mb; %true diff

    dim = size(im1);
    difMat = zeros(dim(1),dim(2),nPerm);

    % Perform Permutation
    for i=1:nPerm
        a = randperm(dim(3));
        fb = im1(:,:,a(1:nbf));
        fpb = im1(:,:,a(nbf+1:end));
        difMat(:,:,i) = mean(fpb,3) - mean(fb,3);
    end

    % write this to be one sided for now
    R = round(max(dif(:)));

    %nPerms sets our minimal resolvable p value
    %binDen decides how many bins within an integer to use
    binDen = 8; 

    nBins = R*binDen+1;

    bins = zeros(dim(1),dim(2),nBins);
    dim2 = size(difMat);

    binCents = linspace(1,nBins,nBins); % vector holding center of bins (will be)
    binCents = (binCents./binDen)-1/(binDen*2);

    bHW = 1/(binDen*2); % half of a bin width

    for i=1:nBins
        counts = (difMat>(binCents(i)-bHW)).*(difMat<(binCents(i)+bHW));
        bins(:,:,i) = sum(counts,3);
    end

    % Now we want to sum all histogram counts from bins whose centers are above
    % their respective thresholds given by dif
    % include provides a binary mask to zero all elements that are below their
    % respective thresholds given by dif

    include = zeros(size(bins));
    for i=1:nBins
        include(:,:,i) = dif<(binCents(i)-bHW); % want to use bin edge, not bin center
    end

    % integral of histogram can be computed as sum counts in bins above
    % threshold divided by number of permutations:
    % http://genomicsclass.github.io/book/pages/permutation_tests.html


    % pValIm = sum(maskedBins,3);
    maskedBins = include.*bins; 
    pValIm = (sum(maskedBins,3)+1)./(nPerm+1);

end