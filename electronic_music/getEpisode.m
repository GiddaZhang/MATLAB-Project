function y = getEpisode(inputArg)
    
    % 根据inputArg歌名参数返回歌曲的音调以及每个音的持续时间

    % 《东方红》完整版
    if strcmp(inputArg, 'DFH')
        y = [5 5 6 2 inf 1 1 -1 2 inf ...
            5 5 6 8 6 5 1 1 -1 2 ...
            5 2 1 0 -1 -2 5 2 ...
            3 2 1 1 -1 2 3 2 1 2 1 0 -1 -2;
            2 1 1 2 2 2 1 1 2 2 ...
            2 2 1 1 1 1 2 1 1 4 ...
            2 2 2 1 1 2 2 2 ...
            1 1 2 1 1 1 1 1 1 1 1 1 1 6];
    
    % 《东方红》片段
    elseif strcmp(inputArg, 'DFHSlice')
        y = [5 5 6 2 inf 1 1 -1 2 inf;
            2 1 1 2 2 2 1 1 2 2];

    % 《夜空中最亮的星》片段
    elseif strcmp(inputArg, 'Star')
        y = [3 2 3 2 3 5 5 inf -1 1 2 1 inf ...
            -1 1 2 3 1 -1 1 2 3 1 -1 2 3 inf;
            1 1 1 1 1 1 4 5 1 3 2 3 7 1 1 ...
            1 1 4 1 1 1 1 2 2 4 3 10];
    end

end