function [pValInc, pValDec] = permute_Im2tail(im1, nbf)
    % Calculate permuted p value of image stack
    % Tom
    % 1 7 18
    % refer to onenote, biostats meeting for explanation
    % function wrapper called batch_Permute_Im
    % nbf =  number of baseline frames

    nPerm = 999;

    % Get mean before and after
    mb = mean(im1(:,:,1:nbf),3);
    mpb = mean(im1(:,:,nbf+1:end),3);
    dif = mpb  - mb; %true diff

    dim = size(im1);
    difMat = zeros(dim(1),dim(2),nPerm);

    % Perform Permutation
    for i=1:nPerm
        a = randperm(dim(3) );
        fb = im1(:,:,a(1:nbf));
        fpb = im1(:,:,a(nbf+1:end));
        difMat(:,:,i) = mean(fpb,3) - mean(fb,3);
    end

    % significant increase
    keep = difMat - repmat(dif,[1 1 nPerm]);
    keep(keep<0)=0;
    keep(keep>0)=1;
    pValInc = sum(keep,3);
    pValInc = ( pValInc+1)./(nPerm+1);
    
    % significant decrease
    keep = difMat - repmat(dif,[1 1 nPerm]);
    keep(keep>0)=0;
    keep(keep<0)=1;
    pValDec = sum(keep,3);
    pValDec = ( pValDec+1)./(nPerm+1);
        

end