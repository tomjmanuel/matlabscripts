function [nb] = thickenBowl(bowl, t)
    % Take a bowl made by MakeBowl and thicken it by a given amount
    % Thicken it by shifting things upwards "t"
    nb = bowl;
    for i=1:t-1
        nb(1:end-i,:,:) = nb(1:end-i,:,:) + bowl(1+i:end,:,:);
    end
    nb(nb>0)=1;
end