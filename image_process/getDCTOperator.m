function D = getDCTOperator(N)
% 根据矩阵规模N获取D矩阵
    D = zeros(N, N);
    D(1,:) = sqrt(0.5);
    base = pi/(2*N)*(1:2:(2*N-1));
    for m = 2:N
        D(m,:) = cos(base*(m-1));
    end
    D = D*sqrt(2/N);

%     if strcmp(pattern, 'r4')
%         D(:,5:8) = 0;
%     else if strcmp(pattern, 'l4')
%         D(:,1:4) = 0;
%     end
end