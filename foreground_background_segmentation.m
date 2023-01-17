function [background, foreground] = foreground_background_segmentation(result, original_image)

    [row, col, dim] = size(original_image);
    
    background = zeros(row, col, dim);
    foreground = zeros(row, col, dim);
    
    for i=1:row
        for j=1:col
            if result(i, j)==0
                background(i, j, :) = original_image(i, j, :);
            else
                foreground(i,j,:) = original_image(i,j,:);
            end
        end
    end
   
end