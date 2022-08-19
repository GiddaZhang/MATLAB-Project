function ACStream = getACStream(MAT)
% 输入DCT系数矩阵，返回AC码流
load("Chapter_2\JpegCoeff.mat")

ACStream = [];
ZRL = [1 1 1 1 1 1 1 1 0 0 1];
EOB = [1 0 1 0];
for m = 1:size(MAT, 2)

    AcVec = MAT(2:end,m);
    run = 0;
    for n = 1:length(AcVec)
        Ac = AcVec(n);
        if Ac == 0
            run = run + 1;
        else
            Size = floor(log2(abs(Ac))) + 1;
            if run > 15
                boolVec = (ACTAB(:,1) == run - 16) & (ACTAB(:,2) == Size);
            else
                boolVec = (ACTAB(:,1) == run) & (ACTAB(:,2) == Size); 
            end
            ACTABRow = find(boolVec == true);
            huffman = ACTAB(ACTABRow, 4:(ACTAB(ACTABRow,3)+3));
            amplitude = getBinVec(Ac);
            if run > 15
                ACStream = [ACStream ZRL huffman amplitude];
            else
                ACStream = [ACStream huffman amplitude];
            end
            run = 0;
        end
    end
    ACStream = [ACStream EOB];
end
end