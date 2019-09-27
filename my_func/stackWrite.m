function [] = stackWrite(filename, variable)

% Make sure variable is normalized
% Include .tif in filename
    w = waitbar(0,'Writing Stack');
    dim = size(variable);
    if length(dim)==2
        imwrite(variable, filename, 'WriteMode', 'overwrite');
    elseif length(dim)==3
        imwrite(variable(:,:,1),filename,'WriteMode','overwrite');
        for i=2:dim(3)
            imwrite(variable(:,:,i),filename,'WriteMode','append');
            waitbar(i/dim(3),w);
        end
    end
    close(w);
end