I = imread('test_image_watermelon.jpg');
I = imresize(I,0.3);
nr1 = 10;
nc1 = 10;
nr2 = 50;
nc2 = 50;
[Ic1, T1] = carv(I, nr1, nc1);
[Ic2, T2] = carv(I, nr2, nc2);


figure(1);
subplot(3,1,1);
imshow(I);
h = gca;
h.Visible = 'On';
xlim([0,size(I,2)]);
ylim([0,size(I,1)]);

subplot(3,1,2);
imshow(I);
h = gca;
h.Visible = 'On';
xlim([0,size(I,2) - nc1]);
ylim([0,size(I,1) - nr1]);

subplot(3,1,3);
imshow(Ic2);
h = gca;
h.Visible = 'On';
xlim([0,size(I,2) - nc2]);
ylim([0,size(I,1) - nr2]);