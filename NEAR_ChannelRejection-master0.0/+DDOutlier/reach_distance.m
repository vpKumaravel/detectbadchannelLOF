function [dist] = reach_distance(DataSet,p,o,k)
    %p�Ŀɴ����
    %p�����ڵ㣬o��Ϊ��p���ھӣ�������ΧΪk
    k_dist = DDOutlier.k_distance(DataSet,o,k);
    %k_dist
    dist = DDOutlier.distance(DataSet,p,o,k);
    %dist
    dist = max(k_dist,dist);
    %disp(dist)
end