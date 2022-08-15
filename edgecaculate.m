function eFC = edgecaculate(data,N)
%edgecaculate: 用以构建边网络
%   INPUT: data,原fmri数据
%          N,节点数量
%   OUTPUT: eFC,边网络矩阵

    z_data = zscore(data);
    c_data = [];
    eFC = [];
    for i = 1:N
        for j = i+1:N
            c_data = [c_data,z_data(:,i).*z_data(:,j)];
        end
    end
    for i = 1:length(c_data)
        for j = 1:length(c_data)
            numer = sum(c_data(:,i).*c_data(:,j));
            denom = sqrt(sum(c_data(:,i).^2))*sqrt(sum(c_data(:,j).^2));
            eFC(i,j) = numer/denom;
        end
    end
end

