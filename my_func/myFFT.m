%%
close all
N = max(size(x));

Xt = zeros(size(x));
n = 0:(N-1);
n = n';
for k=0:(N-1)
    temp = x.*exp(-j*2*pi*k*n/N);
    if k == 1800
        
    end
    Xt(k+1) = sum(temp);
end

figure
subplot(211)
plot(abs(X))
subplot(212)
plot(abs(Xt))

%%
close all
for z=0:.1:100
x2 = sin(100*n) + sin(100*n +z);
hold off
plot(n(1:50),x2(1:50))
hold on
plot(n(1:50),sin(100*n(1:50)))
ylim([-2 2])
pause(.1)

end
