
%dirname = 'C:\Users\tomjm\Documents\Projects\Adaptive Lens\monkey_fixed\monkey_fixed_ct';
dirname = 'C:\Users\tomjm\Documents\Projects\Adaptive_Lens\monkey_CT\';
D = dir([dirname '*.tif']);

for k=1:length(D)
    imstack(:,:,k) = imread([dirname D(k).name]);
end;
