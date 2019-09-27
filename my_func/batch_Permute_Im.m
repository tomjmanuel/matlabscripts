% batch_Permute_Im
% Tom, 12/14/18
% wrapper for permute_Im

% load directory list
% folder = uigetdir();
% fileList = dir(fullfile(folder, '*.cxd'));
% 
% nFiles = size(fileList);
% nFiles = nFiles(1);
%%
% looking at fileList to see the order things will be processed in
% make an array which for each image gives frame number US happened at
% and the number of baseline frames to use
% put 0 to skip that file

% don't need this now

%%
% Call permutation on a directory of cxd files

% fname = fileList(1).name;
% path = fileList(1).folder;
% fullfname = strcat(path,'\',fname);
% im = useBF(fullfname); % read in first file to get image sizes
% 
% dim0 = size(im);
% 
% dsf = 8; % Down sample factor
% im = imresize(im,[dim0(1)/dsf,dim0(2)/dsf]);
% 
% USframe = 40; % US delivered in between 40 and 41 frame
% nbf = 10;
% dim = size(im);
% dim(3) = nbf*2;
 
pValIms = zeros(dim(1),dim(2),nFiles);

for i=1:nFiles
     
    if i~=1
        fname = fileList(i).name;
        path = fileList(i).folder;
        fullfname = strcat(path,'\',fname);
        im = useBF(fullfname); 
        im = imresize(im,[dim0(1)/dsf,dim0(2)/dsf]);
    end
    im1 = im(:,:,USframe-nbf+1:USframe+nbf);
    
    %balance images with an ROI
    imG = sum(abs(im1 - ...
    repmat(im1(:,:,1),[1,1,dim(3)])),3);
    a = figure;
    imagesc(imG)
    colormap('gray')
    axis image
    roi = roipoly();
    imb = zeros(dim);
    first = im(:,:,1);
    imb(:,:,1)=first;
    value1 = first(roi);
    mv1 = mean(value1(:));
    for k=2:dim(3)
        frame = im(:,:,k);
        r = frame(roi);
        imb(:,:,k) = frame + mv1 - mean(r(:));
    end
    close(a);
    
    %register images
    imbc = imb;
    imbc = imbc./max(imbc(:));
    imbc(imbc<.7)=0;
    imbc(imbc>.8)=1;
    [~,imr] = reg_Im(imb,imbc);
    
    % write out cropped, downsampled, balanced, registered 
    % stack if desired here
    %stackWrite(strcat(fname(1:end-4),'.tif'),im1./max(im1(:)));
    
    pValIms(:,:,i) = permute_Im(imr, nbf);
    
    
    format compact
    i
     
end


