clear all;

% faceNum = 33;
% path = "Faces\";
% format = ".bmp";
% L = 3;
% N = 2^(3*L);
% u_bar = zeros(N, 1);
% 
% for faceIdx = 1:faceNum
%     % load face
%     fullPath = path + num2str(faceIdx) + format;
%     img = imread(fullPath);
%     [y, x, ~] = size(img);
% 
%     u = zeros(N, 1);
%     for yIdx = 1:y
%         for xIdx = 1:x
%             RGB = img(yIdx, xIdx, :);
%             n = RGB2N(RGB, L);
%             u(n + 1) = u(n + 1) + 1;
%         end
%     end
% 
%     % calculate u(R)
%     u = u / (x * y);
%     % calculate average u
%     u_bar = u_bar + u;
% end
% 
% u_bar = u_bar / faceNum;
% save("Chapter_4\v_L3.mat", "u_bar");

path = "Chapter_4\v_L";
format = ".mat";
for L = 3:5
    load(path + num2str(L) + format);
    subplot(3, 1, L - 2);
    plot(u_bar);
    title("L = " + num2str(L));
end