%delete false images
%This script was created since there are images with wrong annotated
%pectoral segmentation
clc,clear,close all
load C:\Users\Yesica\Desktop\gafricano\code\chestWall\code\cwall\data/INdataset.mat 
INdataset([109 166],:)=[];
INdataset(:,[5 7 8 9])=[];
INdataset60([66 101],:)=[];
INdataset60(:,[5 7 8 9])=[];
save INdataset INdataset INdataset60