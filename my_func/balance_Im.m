function [Im_balanced,F] = balance_Im(raw_im,bb)
% Tom 9/10/18
% Script to subtract out change in average intensity across an image stack
%inputs
%bb: bounding box for zone to use in Intensity subtraction
%     - ex: [20,20,100,100] ([x0,y0,x1,y1])
%outputs
%F is fluorescence level over whole image after intensity balancing

    dim = size(raw_im);
    aveI = mean(raw_im(bb(2):bb(4),bb(1):bb(3),:),1);
    aveI = mean(aveI,2);
    aveI = squeeze(aveI);
    F = zeros(dim(3),1);
    Ioff = aveI - min(aveI(:));
    Im_balanced = zeros(dim);
    for i=1:dim(3)
        Im_balanced(:,:,i) = raw_im(:,:,i) - Ioff(i);
        frame = Im_balanced(:,:,i);
        F(i) = mean(frame(:));
    end   

end