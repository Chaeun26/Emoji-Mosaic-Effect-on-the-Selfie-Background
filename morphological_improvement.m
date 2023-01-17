function result=morphological_improvement(input_image)

    [row, col, ~] = size(input_image);

    input_image = medfilt2(input_image,[2 2]); % noise removal

    % show the process - noise removal
    figure; imshow(input_image);

    se = strel('disk',10);
    input_image = imdilate(input_image,se);
    before_fill = input_image;

    [input_image] = imfill(input_image, 'holes');
    after_fill = input_image;

    % show the process - dilation
    figure; imshow(input_image);
    
    difference = after_fill - before_fill;
    
    % remove lower brightness
    for i=1:row
        for j=1:col
            if input_image(i,j) < 150
                input_image(i,j)=0;
            elseif (difference(i,j)==0) && (input_image(i,j) < max(max(input_image)) - 70)
                input_image(i,j)=input_image(i,j)-150;
            end
        end
    end
    
    se = strel('disk',20);
    input_image = imdilate(input_image,se);
    result = imfill(input_image, 'holes');

    % show the process - dilation
    figure; imshow(result);

    se2 = strel('disk', 20);
    result = imerode(result, se2);

    % show the process - erosion
    figure; imshow(result);
end