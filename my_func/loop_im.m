function loop_im(im, pause_time)

    p = pause_time;
    dim = size(im);
    h = fullfig();
    M = max(im(:));
    m = min(im(:));
    for i=1:dim(3)
        imagesc(im(:,:,i),[m M])
 %       imagesc(im(:,:,i))
       % axis image
       % colormap('gray')
        title(i-1)
        pause(p)
    end
   pause(1)
   close(h)
end
