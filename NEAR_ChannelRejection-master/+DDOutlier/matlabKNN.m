function [id,dist] = matlabKNN(data,k,disMetric)
%matlabKNN ��R��DBSCAN��KNN������MATLAB��Ҫʵ��
%   
    %������뺯����Դ
    if strcmp(disMetric,'euclidean')
        disMetric = 'euclidean';
    elseif strcmp(disMetric,'seuclidean')
        disMetric = 'seuclidean';
    elseif strcmp(disMetric,'spearman')
        disMetric = 'spearman';
    else strcmp(disMetric,'correlation')
        disMetric = 'correlation';
    end
    
    %matlab������Ҫ��kҪ���һ��
    k = k + 1;
    
    [n,~] = size(data);
    id = zeros(n,k);
    dist = zeros(n,k);
    parfor i = 1:1:n
        datum = data(i,:);
        %[aID,aDist] = knnsearch(data,datum,'K',k,'Distance',disMetric,...
        %'NSMethod','kdtree');
        [aID,aDist] = knnsearch(data,datum,'K',k,...
            'Distance',disMetric,'IncludeTies',true);
        aID = aID{1}(1:(k));
        aDist = aDist{1}(1:(k));
        id(i,:) = aID;
        dist(i,:) = aDist;
    end
    
    %�ü������ƥ�����
    id1 = id(:,1);
    dist1 = dist(:,1);
    
    id = id(:,2:end);
    dist = dist(:,2:end);
    
    %�������ֹ�����Լ�(�е�ʱ���Լ����Ǳ����ڵ�һ��������һ������ȥ�����ر��)
    for i = 1:1:n
        mySelf = find(id(i,:) == i);
        if(~isempty(mySelf))
            %fprintf("Ԫ��%d��%d�б�������룡\n",i,mySelf);
            id(i,mySelf) = id1(i);
            dist(i,mySelf) = dist1(i);
        end
    end
end
