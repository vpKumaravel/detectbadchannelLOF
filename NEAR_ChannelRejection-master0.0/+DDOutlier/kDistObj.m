function [kdist_obj,increaseKs] = kDistObj(DataSet,k)
    % kDistObj ����һ������������������˸պõ���k�������Щ�ھӵ㡣
    % ���ڲ�ͬ�Ľڵ�k�ھӲ�ͬ�����Իᵼ�³��̲�һ��Ϊ����Ȼ�ܷ�洢��һ�������
    % ����Ч��Ԫ�ز�ȫ���̲����Ԫ�ء�
    % ���ڲ���ľ������ЧԪ����inf
    % ���ڲ����ID����ЧԪ����-1
    
    persistent k_buff;
    persistent kdist_obj_buff;
    persistent increaseKs_buff;
    
    if isempty(k_buff) || (k_buff ~= k)
        
        increaseKs = ones(1,DataSet.n) * k;
        for i = 1:1:DataSet.n
            while DDOutlier.k_distance(DataSet,i,increaseKs(i)+1) <= ...
                    DDOutlier.k_distance(DataSet,i,increaseKs(i))
                increaseKs(i) = increaseKs(i) + 1;
                %warning("���־�����ȵ�Ԫ�ء�");
            end
            %fprintf("��%d��չ����%d\n",i,increaseKs(i));
        end
        increaseKsMAX = max(increaseKs);
        kdist_obj = struct();
        kdist_obj.dist = zeros(DataSet.n,increaseKsMAX);
        kdist_obj.id = zeros(DataSet.n,increaseKsMAX);
        buffdist = kdist_obj.dist;
        buffid = kdist_obj.id;
        parfor i = 1:DataSet.n
            buffdist(i,:) = ...
                [DataSet.dist_obj.dist(i,1:increaseKs(i)) ...
                ones(1,increaseKsMAX-increaseKs(i))*inf];
            buffid(i,:) = ...
                [DataSet.dist_obj.id(i,1:increaseKs(i)) ...
                ones(1,increaseKsMAX-increaseKs(i))*(-1)];
        end
        kdist_obj.dist = buffdist;
        kdist_obj.id = buffid;
        
        %���岻�ԣ��ؽ�����
        k_buff = k;
        kdist_obj_buff = kdist_obj;
        increaseKs_buff = increaseKs;
    else
        kdist_obj = kdist_obj_buff;
        increaseKs = increaseKs_buff;
    end
end