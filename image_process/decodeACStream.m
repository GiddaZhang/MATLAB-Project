function AC = decodeACStream(ACStream, DC)
acHead = 1;     % ACStream的头指针
neg = 1;
vecIdx = 1;
vecHead = 1;    % 每一个AC系数的列向量的头指针
AC = zeros(63, length(DC));
ZRL = [1 1 1 1 1 1 1 1 0 0 1];
EOB = [1 0 1 0];

while acHead ~= length(ACStream)+1

    [run, Size, huff_len] = huffDecode(ACStream(acHead:end), 'AC');
    huffman = ACStream(acHead:acHead+huff_len-1);

    while ~isequal(huffman, EOB)

        amplitude_len = Size;
        if Size == 0
            amplitude_len = 1;
        end

        bin = ACStream(acHead+huff_len:acHead+huff_len+amplitude_len-1);
        if bin(1) == 0
            bin = ~bin;
            neg = -1;
        end
        if Size ~= 0
            dec = neg*bin2dec(num2str(bin));
        else
            dec = 0;
        end

        % 填零        
        if isequal(huffman, ZRL)
            for m = 0:15
                AC(vecHead+m, vecIdx) = 0;
            end
            vecHead = vecHead + 16;
            acHead = acHead + huff_len;
        else
            while run > 0 
                run = run - 1;
                AC(vecHead, vecIdx) = 0;
                vecHead = vecHead + 1;
            end
            AC(vecHead, vecIdx) = dec;
            vecHead = vecHead + 1;
            acHead = acHead + huff_len + amplitude_len;
        end

        [run, Size, huff_len] = huffDecode(ACStream(acHead:end), 'AC');
        huffman = ACStream(acHead:acHead+huff_len-1);
        neg = 1;
    end

    % now huffman == EOB
    acHead = acHead + 4;
    AC(vecHead+1:end,vecIdx) = 0;
    vecIdx = vecIdx + 1;
    vecHead = 1;
end
end