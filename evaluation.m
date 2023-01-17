%% evaluation for foreground/background segmenation part
ground_truth = imread("ground_truth.png");
result = imread("foreground.png");

[row, col, dim] = size(ground_truth);

count = 0;
total = 0;

for i=1:row
    for j=1:col
        if ground_truth(i,j,:) == result(i,j,:)
            count = count + 1;
        end
        total = total + 1;
    end
end

accuracy = count / total * 100;