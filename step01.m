% MAG-based chest wall detection on chest dataset 

clear, clc, close all
st = clock;

rng('default')
% local path of Inbreast dataset
newpath='C:\Users\Yesica\Desktop\gafricano\data\INbreast'; 


res     = 0.3;  %pixel resolution in mm
radius  = 6;    %opening radius in mm
area    = 1500; %thresholding area filtering

load ./data/INbreast.mat 

dataset=INdataset; %Whole INbreast
%FIXPATH
dataset.path=strrep(dataset.path,'/Users/cvip/Documents/Gerson_africano/gafricano_2018/data/INbreast',newpath);
dataset.cwall=strrep(dataset.cwall,'/Users/cvip/Documents/Gerson_africano/gafricano_2018/data/INbreast',newpath);

imlist = dataset.path;
no_images = length(imlist);
DC = zeros(no_images, 1); % Dice's coefficient 
AE=zeros(no_images, 1); %Area error
MD=zeros(no_images, 1); % mean contour distnace

for n = 1:length(imlist)
    impath = imlist{n};    
    
    %read image
    info = getinfo(impath);
    info.psize = 0.1;
    im = ffdmRead(impath, info);
    imsize = size(im);
    im = imresize(im, info.psize/res);
   
    %breast detection
    mask = segBreast(im, false);
    [roi, cont] = segBreast(im, true);
    mask(cont.ycut:end,:) = false;
    
    %chest wall segmentation
    mask = mag(im, mask);  
    mask = mclean(mask, radius, res, ~roi,area);
    
    %chest ground-truth
    cwall = readcwall(dataset.cwall{n}, size(im));
    cwallref=cwall;
    
    if isright(im)
        cwall.x = [imsize(2); cwall.x; imsize(2)];
        cwall.y = [1; cwall.y; 1];                
        mask = fliplr(mask);
        cw = mask2cwall(mask);
        mask = poly2mask([1; cw(:,1)], [1; cw(:,2)], size(mask, 1), size(mask, 2));    
        mask = fliplr(mask);
    else
        cwall.x = [1; cwall.x; 1];
        cwall.y = [1; cwall.y; 1];   
        cw = mask2cwall(mask);
        mask = poly2mask([1; cw(:,1)], [1; cw(:,2)], size(mask, 1), size(mask, 2));  
    end
    refmask = poly2mask(cwall.x, cwall.y, imsize(1), imsize(2));
    refmask = imresize(refmask, size(mask));
    
  
    %compute performance measurements
    DC(n) = 2*sum(refmask(:)&mask(:))/(sum(mask(:))+sum(refmask(:)));
    OA = sum(mask(:)&~refmask(:))*(res^2);
    UA = sum(~mask(:)&refmask(:))*(res^2);
    VE=info.psize/res;
    MD(n)=mdistance(cw,cwallref,im,mask,VE)*res;
    AE(n)=OA+UA;

    fprintf('\b\b\b\b\b[%02d%%]',floor(100*n/no_images))
end
DC_median=median(DC);
AE_median=median(AE);
MD_mean=mean(MD);
mkdir results
save ./results/INbreast.mat DC AE MD DC_median AE_median MD_mean
sp = clock;
fprintf('\netime: %s \n', datestr(etime(sp,st)/(24*3600), 'HH:MM:SS'))
