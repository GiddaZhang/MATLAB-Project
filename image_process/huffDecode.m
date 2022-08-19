function [decode1, decode2, len] = huffDecode(stream, type)
% 返回头部的码字对应的原码及码长
load("Chapter_2\JpegCoeff.mat");
if_return = false;
ZRL = [1 1 1 1 1 1 1 1 0 0 1];
EOB = [1 0 1 0];
if strcmp(type, 'DC')

    for possibleLength = 2:9
        if if_return
            break;
        end
        
        for possibleCate = 0:11
            if DCTAB(possibleCate+1,1) == possibleLength

                if DCTAB(possibleCate+1, 2:DCTAB(possibleCate+1,1)+1) == stream(1:possibleLength)

                    len = possibleLength;
                    decode1 = possibleCate;    
                    decode2 = 0;
                    if_return = true;
                    break;
                end
            end
        end    
    end

elseif strcmp(type, 'AC')
    
    for possibleLength = 2:16
        if if_return
            break;
        end
        for possibleRun = 0:15
            if if_return
                break;
            end
            for possibleSize = 1:10
                if ACTAB(possibleRun*10+possibleSize, 3) == possibleLength
                    if possibleLength < length(stream) && isequal(ACTAB(possibleRun*10+possibleSize, 4:possibleLength+3),stream(1:possibleLength))

                        len = possibleLength;
                        decode1 = possibleRun;
                        decode2 = possibleSize;
                        if_return = true;
                        break;
                    end
                end
            end
        end
    end

    if ~if_return
        % if not found, it's EOB or ZRL
        if stream(1:4) == EOB
            len = 4;
            decode1 = 0;
            decode2 = 0;
        elseif stream(1:11) == ZRL
            len = 11;
            decode1 = 15;
            decode2 = 0;
        end
    end
end
end