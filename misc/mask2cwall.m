function cwall = mask2cwall(mask)

B = bwboundaries(mask);
if isempty(B)
    x = ones(100,1);
    y = linspace(1, size(mask, 1), 100);
    cwall = [x(:), y(:)];
    return
end

x = [];
y = [];
for n = 1:length(B)
    x = [x; B{n}(:,2)];
    y = [y; B{n}(:,1)];
end
remov = (x>=size(mask,2)-3)|(y<=3)|(x<=3);
x(remov) = [];
y(remov) = [];
P = fitPolynomialRANSAC([y, x], 2, 10);
yi = linspace(min(y), max(y), 100);
xi = polyval(P, yi);
xi(end) = 1;
yi(1) = 1;
% plot(x, y, '.',xi, yi, 'r');


cwall = [xi(:), yi(:)];