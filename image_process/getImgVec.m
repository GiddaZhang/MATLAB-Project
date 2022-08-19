function u = getImgVec(img, L)
[y, x, ~] = size(img);
N = 2^(3*L);

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

end