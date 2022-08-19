function DC = deCodeDCStream(DCStream)

dcHead = 1;     % DCStream的头指针
neg = 1;
DC_diff = [];

while dcHead ~= length(DCStream)+1

    [category, ~, huff_len] = huffDecode(DCStream(dcHead:end), 'DC');
    if category ~= 0
        magnitude_len = category;
    else
        magnitude_len = 1;
    end
    bin = DCStream(dcHead+huff_len:dcHead+huff_len+magnitude_len-1);
    if bin(1) == 0
        bin = ~bin;
        neg = -1;
    end
    if category ~= 0
        dec = neg*bin2dec(num2str(bin));
    else
        dec = 0;
    end
    dcHead = dcHead+huff_len+magnitude_len;
    DC_diff = [DC_diff dec];
    neg = 1;
end

DC = zeros(1,length(DC_diff));
DC(1) = DC_diff(1);
for m = 1:length(DC)-1
    DC(m+1) = DC(m) - DC_diff(m+1) ;
end

end