function [dist] = k_distance(DataSet,i,k)
    %k_distance �������i��k�ھӾ���
    if k > DataSet.nn
        DataSet.increaseBuffer(k);
    end
%     k = k + 1;
%     [~,aDist] = knnsearch(DataSet.data,DataSet.data(i,:),'K',k,...
%             'Distance',DataSet.disMetric,'IncludeTies',true);
%     dist = aDist{1}(end);
    
    dist = DataSet.dist_obj.dist(i,k);
end