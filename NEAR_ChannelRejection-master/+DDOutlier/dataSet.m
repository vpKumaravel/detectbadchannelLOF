classdef dataSet < handle
    %dataSet �����ṩ���ݱ���ֱ����صĻ�������
    %   
    
    properties
        data = [];
        %����߶�
        disMetric = "";
      
        n = 0; %�۲����
        n_var = 0; %����ά�ȣ���������
        
        nn = 0; %���ݻ�����
        dist_obj = struct(); %���ݻ���
    end
    
    methods
        function obj = dataSet(dataIn,disMetric)
            %dataSet ��������ʵ��
             obj.data = dataIn;
             [obj.n,obj.n_var] = size(obj.data);
             obj.disMetric = disMetric;
             %д�����Ԥ��Ļ�����
             obj.nn = ceil(sqrt(obj.n));
             %����������
             [id,dist] = DDOutlier.matlabKNN(obj.data,obj.nn,obj.disMetric);
             obj.dist_obj.id = id;
             obj.dist_obj.dist = dist;
             
        end
        
        function [] = increaseBuffer(obj,nn)
            %increaseBuffer ���ӻ���
            %   �����ڵ�ǰ���岻���õ�ʱ�����ӻ��壬
            %���������ڻ������Ӷ��������������䶯������
            obj.nn = nn;
            [id,dist] = DDOutlier.matlabKNN(obj.data,obj.nn,obj.disMetric);
            obj.dist_obj.id = id;
            obj.dist_obj.dist = dist;
        end
    end
end