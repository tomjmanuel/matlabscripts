function presentResults(s,display,trans_info)
    %Make figure from "test_power" to show results nicely
    %test_power can be found in Elmo
    %10/19/18

    %s: struct made by script
    %trans_info: a string describing the transducer used
        %i save this with the bowl.mat sometimes

    dim = size(s(1).Sensor_data.p_max);
    slice = round(dim(3)/2);
    t = trans_info;
    frame = s(1).Sensor_data.p_max(:,:,slice);
    M = max(frame(:));
    overlay1 = display(:,:,slice).*M.*.8;
    overlay2 = display(:,slice,:).*M.*.8;

    F = figure
    subplot(1,2,1)
    imagesc(s(1).Sensor_data.p_max(:,:,slice)+overlay1)
    axis image
    title(t)

    subplot(1,2,2)
    imagesc(squeeze(s(1).Sensor_data.p_max(:,slice,:))+squeeze(overlay2))
    axis image
    title(t)

    saveas(F,t);

end