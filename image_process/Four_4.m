clear all;

faceNum_1 = 33 / 2;
faceNum_2 = 5;
path = "Faces\";
format_1 = ".bmp";
format_2 = '.jpg';
L = 4;
N = 2^(3*L);
u_bar = zeros(N, 1);

for faceIdx = 1:faceNum_1
    % load face
    fullPath = path + num2str(faceIdx) + format_1;
    img = imread(fullPath);
    [y, x, ~] = size(img);

    u = zeros(N, 1);
    for yIdx = 1:y
        for xIdx = 1:x
            RGB = img(yIdx, xIdx, :);
            n = RGB2N(RGB, L);
            u(n + 1) = u(n + 1) + 1;
        end
    end

    % calculate u(R)
    u = u / (x * y);
    % calculate average u
    u_bar = u_bar + u;
end

for faceIdx = 1:faceNum_2
    % load face
    fullPath = path + num2str(faceIdx) + format_2;
    img = imread(fullPath);
    [y, x, ~] = size(img);

    u = zeros(N, 1);
    for yIdx = 1:y
        for xIdx = 1:x
            RGB = img(yIdx, xIdx, :);
            n = RGB2N(RGB, L);
            u(n + 1) = u(n + 1) + 1;
        end
    end

    % calculate u(R)
    u = u / (x * y);
    % calculate average u
    u_bar = u_bar + u;
end

u_bar = u_bar / (faceNum_1 + faceNum_2);
img = imread("Chapter_4\photo.jpg");
L = 4;

img_show = faceIdentify(img, L, u_bar);
imshow(img_show);
