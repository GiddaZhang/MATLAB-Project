function y = getZigZag(N)
% N为矩阵规模
flag = -1;       % 往右上走
i = 1;
j = 1;
idx = 1;

y = zeros(N,N);

while (i ~= N || j ~= N)

    y(i,j) = idx;
    % 如果在最上边一行
    if i == 1
        if flag == -1
            i = i;
            j = j + 1;
            flag = 1;
        else
            i = i + 1;
            j = j - 1;
        end
    % 如果在最下边一行
    elseif i == N
        if flag == 1
            i = i;
            j = j + 1;
            flag = -1;
        else
            i = i - 1;
            j = j + 1;
        end
    % 如果在最左边一列
    elseif j == 1
        if flag == 1
            i = i + 1;
            j = j;
            flag = -1;
        else
            i = i - 1;
            j = j + 1;
        end
    % 如果在最右边一列
    elseif j == N
        if flag == -1
            i = i + 1;
            j = j;
            flag = 1;
        else
            i = i + 1;
            j = j - 1;
        end
    % 不在边界
    else
        i = i + flag;
        j = j - flag;
    end
    idx = idx + 1;
end
y(N,N) = N^2;
end