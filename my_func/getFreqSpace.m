function [f,spectrum] = getFreqSpace(dataf, fs, disp)
    % to be used after fft
    % get frequency space and power spectrum for data that has been
    % processed by fft
    
    % inputs 
    % - dataf, from dataf = fft(X) (must be even)
    % - fs, sample rate
    % - disp, display?
   
    L = length(dataf);
    
    % make one sided and return energy from other half to this side
    spec = abs(dataf./L);
    spec1 = spec(1:L/2+1);
    spec1(2:end-1) = spec1(2:end-1).*2;
    spectrum = spec1;
    
    % get freq space
    f = fs.*(0:(L/2))/L;
    
    %display
        if (disp)
        figure
        plot(f,spectrum)
        xlabel('Hz')
    end
    
end