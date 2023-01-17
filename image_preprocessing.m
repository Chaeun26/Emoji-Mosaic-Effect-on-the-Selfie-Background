function img = image_preprocessing(img)

    [row, col, ~] = size(img);

    for i=1:row
        for j=1:col
            if img(row, col, 1) < 150 && img(row, col, 2) < 150 && img(row, col, 3) < 150
                img(row,col,:) = img(row, col, :);
            else
                img(row, col, :) = img(row, col, :) - 50;
            end
        end
    end
end