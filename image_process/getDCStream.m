function DCStream = getDCStream(MAT)
% 输入DCT系数矩阵，返回DC码流
load("Chapter_2\JpegCoeff.mat");

DCCoeff = MAT(1,:);
DCCoeff_diff = [DCCoeff(1), -diff(DCCoeff)];
DCStream = [];
for m = 1:length(DCCoeff_diff)

    dc = DCCoeff_diff(m);
    if dc ~= 0
        category = floor(log2(abs(dc))) + 1;
    else
        category = 0;
    end
    huffman = DCTAB(category+1,2:DCTAB(category+1,1)+1); 
    bin = getBinVec(dc);

    DCStream = [DCStream huffman bin];
end
end