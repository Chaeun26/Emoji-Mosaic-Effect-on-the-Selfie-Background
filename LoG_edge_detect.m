function [result, x, y] = LoG_edge_detect(img)
    img = double(rgb2gray(img));

    [row, col, ~] = size(img);

    result = zeros(size(img));
    
    % 1. Gaussian smoother
    filter_size = [5 5]; 
    sigma = 0.6;

    mask_size = ceil(3*sigma)*2+1;

    g=zeros(mask_size, mask_size);

    y = -1*ceil(3*sigma);
    for i=1:mask_size
        x=-1*ceil(3*sigma);
        for j=1:mask_size
            g(i,j) = 1/(2*pi*sigma^2)*(exp(-(x.^2+y.^2)/(2*sigma^2)));
            x=x+1;
        end
        y=y+1;
    end

    normalized_g = (g - mean(g, 'all', 'omitnan'));    

    for i = 1:row - filter_size(1,1)
        for j = 1:col - filter_size(1,2)
            cropped_image = img(i:i+filter_size(1,1)-1, j:j+filter_size(1,2)-1);
            result(i,j) = sum(normalized_g .* cropped_image,'all'); % convolution
        end
    end

    figure; imshow(result);

    % 2. Laplacian of Gaussian

    mask_size = (ceil(sigma)*filter_size(1,1)-1)/2;
    [x, y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);

    sigma = 0.20;

    % for comparsion - sobel filter
    %{
    sobel_filter = fspecial('sobel'); 
    sobel_x = imfilter(img, sobel_filter');
    sobel_y = imfilter(img, sobel_filter);
    result = sqrt(sobel_x.^2 + sobel_y.^2);
    result = uint8(result);
    result = result > mean(mean(result)) * 2 ;
    %}
    
    % for comparsion - canny edge detection
    %canny_result = edge(result, 'canny');
    
    LoG = ((x.^2+y.^2-2*sigma^2)).*(exp(-(x.^2+y.^2)/(2*sigma^2)))/(sum(exp(-(x.^2+y.^2)/(2*sigma^2)),'all')*(sigma^4));
    normalized_LoG = (LoG - mean(LoG, 'all', 'omitnan'));
    
    for i = 1:row - filter_size(1,1)-1
        for j = 1:col - filter_size(1,2)-1
            cropped_image = result(i:i+filter_size(1,1)-1, j:j+filter_size(1,2)-1);
            result(i,j) = sum(normalized_LoG .* cropped_image,'all'); % convolution
        end
    end

    result = uint8(result);

end