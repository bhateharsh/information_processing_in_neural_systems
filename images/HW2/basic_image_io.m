%% ECE 8833 (Homework 2)
clear all;
clc;
%% Reading an Image
img = imread('images/airplane.jpg');
% Converting image to grayscale
if size(img, 3) == 3
   img = rgb2gray(img); 
end
%Resizing image to square
dim = size(img);
minDim = min(dim);
img = img(1:minDim, 1:minDim);
%Displaying the resized imaage
subplot(1,2,1);
imshow(img);
title('Original Image');
%% (a). Computing the FFT, Power Spectrum 
fImg = fft2(img);   %Computing the FFT
fImg = fftshift(fImg);  %Centering the FFT at origin
psdImg = abs(fImg).^2; %Computing magnitude of FFT
subplot(1,2,2);
imagesc(log(1+psdImg));
%Setting Scales and title for fourier plot
xticklabels = -minDim/2:64:minDim/2;
xticks = linspace(1, size(log(1+psdImg), 2), numel(xticklabels));
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
yticklabels = -minDim/2:64:minDim/2;
yticks = linspace(1, size(log(1+psdImg), 1), numel(yticklabels));
set(gca, 'YTick', yticks, 'YTickLabel', flipud(yticklabels(:)))
set(gca,'dataAspectRatio',[1 1 1])
title ('Power Spectrum of Image');
%% (b). Rotational Average of the Power Spectrum
rotationalAverage(psdImg);
%% (d). Whitening Filter for natural images
%Initializing the filter
[xgrid, ygrid] = meshgrid(1:size(img,2), 1:size(img,1));
midx = floor(size(img,1)/2);
midy = floor(size(img,2)/2);
filter = sqrt((xgrid-midx).^2 + (ygrid-midy).^2);
filter = filter./max(filter);
% Applying Gaussian smoothening
sigma = 0.7;
smoothenedFilter = imgaussfilt(filter,sigma);
%Finding Rotational Average of smoothened filter
rotationalAverage(abs(smoothenedFilter).^2);
%Plotting the filter
figure(3);
mesh(filter);
%imagesc(filter);
colormap gray;
% plot(smoothenedFilter);
title('Smoothened Whitening Filter');
xlabel('Frequency');
ylabel('Frequency');
zlabel('Filter Output');
xticklabels = -minDim/2:128:minDim/2;
xticks = linspace(1, size(filter, 2), numel(xticklabels));
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
yticklabels = -minDim/2:128:minDim/2;
yticks = linspace(1, size(filter, 1), numel(yticklabels));
set(gca, 'YTick', yticks, 'YTickLabel', flipud(yticklabels(:)))
%% (e). Filter in the Spatial Domain
spatialFilter = ifft2(ifftshift(smoothenedFilter));
figure(4);
%imagesc(fftshift(abs(spatialFilter)));
mesh(fftshift(abs(spatialFilter)));
colormap gray;
title('Smoothened Whitening Filter in Spatial Domain');
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Filter Output');
xticklabels = -floor(minDim/2):128:floor(minDim/2);
xticks = linspace(1, size(filter, 2), numel(xticklabels));
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
yticklabels = -floor(minDim/2):128:floor(minDim/2);
yticks = linspace(1, size(filter, 1), numel(yticklabels));
set(gca, 'YTick', yticks, 'YTickLabel', flipud(yticklabels(:)))
%% (f). Whitening filter on example image
output = fImg.*smoothenedFilter;
psd_output = abs(output).^2;
out_img = abs(ifft2(ifftshift(output)));
rotationalAverage(psd_output);
figure();
subplot(1,2,1);
imagesc(img);
colormap gray;
title('Original Image');
subplot(1,2,2);
imagesc(out_img);
colormap gray;
title('Filtered Image');
%% Functions
function rotationalAverage (img)
    % Extracting the coordinates
    midx = floor(size(img,1)/2);
    midy = floor(size(img,2)/2);
    error = 0.5;
    meanValues = zeros(1, (midx+rem(midx,2)));
    for r = 1:(midx+rem(midx,2))
        [xgrid, ygrid] = meshgrid(1:size(img,2), 1:size(img,1));
        equation = ((xgrid-midx).^2 + (ygrid-midy).^2); 
        mask =  (equation >= (r-error).^2 & equation <= (r+error).^2);
        values = img(mask);
        meanValues(r) = nanmean(values);
    end
    figure();
    x = 1:(midx+rem(midx,2));
    loglog(x, meanValues);
    disp(meanValues);
    title('Rotational Average of Power Spectrum');
    xlabel('Frequency');
    ylabel('Power Spectrum');
    axis([xlim 10^0 10^15 ylim 10^0 10^15]);
    p = polyfit(log10(1+(2*pi).*x) , log10(1+meanValues),1);
    fprintf("Slope is: %f \n", p(1));
end