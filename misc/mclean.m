function mask = mclean(mask, radius, res, roi,area)

h = strel('disk',round(radius/res));
%imshow(mask)
mask = imopen(mask, h);
%figure, imshow(mask)
labels = bwlabel(mask);
nlabels = max(labels(:));
maskout = false(size(mask));
counter=0;
for n = 1:max(nlabels)
    obj = labels==n;
    if sum(obj(:)&roi(:))>0.3*sum(obj(:))
        maskout = maskout|obj;
        counter=counter+1;
    end
end
mask = maskout;
mask = bwareaopen(mask, area);
