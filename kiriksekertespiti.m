clc;
clear;

rgbgoruntu = imread("sekerler.bmp");
figure,imshow(rgbgoruntu);

gri = rgb2gray(rgbgoruntu);
figure,imshow(gri);

se = strel('disk',16);
arkaplan = imclose(gri,se);
figure,imshow(arkaplan);

farkgoruntu = imsubtract(arkaplan,gri);
figure,imshow(farkgoruntu);

imgsekerlersb = imbinarize(farkgoruntu);
figure,imshow(imgsekerlersb);

imgsekerlersb = imfill(imgsekerlersb,'holes');
figure,imshow(imgsekerlersb);

[etiketler,nesnesayisi]  = bwlabel(imgsekerlersb,4);
nesneverileri = regionprops(etiketler,'Eccentricity','Area','BoundingBox');

alandegerleri = [nesneverileri.Area];
tuhafliklar = nesneverileri.Eccentricity;

minalan = mean(alandegerleri)-0.25*std(alandegerleri);
bozukalanindexleri = find(alandegerleri<minalan & tuhafliklar>0.5);

bozukveriler = nesneverileri(bozukalanindexleri);

figure;
imshow(rgbgoruntu);
hold on

for i=1:length(bozukalanindexleri)
   rect = rectangle('Position',bozukveriler(i).BoundingBox,'LineWidth',2);
   set(rect,'EdgeColor',[0,0,1]);

end

hold off
