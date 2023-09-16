function [lrd] = LRD(DataSet,p,k,neighbors)
    %����neighbors��Χ�ڵĵ����i���LRDֵ
    numNeighbors = numel(neighbors);
    add = 0;
    for i = 1:1:numNeighbors
        o = neighbors(i);
        %disp(reach_distance(DataSet,p,o,k))
        add = add + DDOutlier.reach_distance(DataSet,p,o,k);
    end
    lrd = add / numNeighbors;
    lrd = 1/lrd;
end