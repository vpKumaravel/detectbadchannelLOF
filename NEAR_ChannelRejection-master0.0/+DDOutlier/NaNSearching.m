function [r,max_nb] = NaNSearching(DataSet)
    %Natural Neighbor searching%

    r = 1;

    while r <= DataSet.n

        %fprintf("r is now:%d\n",r);
        [Rnbi,numb] = DDOutlier.rnbs(DataSet,r);
        if r == 1
            numb_upd = numb;
            r = r + 1;
        elseif numb_upd == numb
            break;
        else
            numb_upd = numb;
            r = r + 1;
        end
    end

    max_nb = max(Rnbi);
end




%% Commenting this 
% 
% %function [r,max_nb] = NaNSearching(DataSet)
%     %����Natural Neighbor searching���ҵ�
%     %����Ӧ�������뾶r�����ܻ�ӭ�ĵ���ھ���max_nb
%     r = 1;
%     start_patience = 1;
%     patience = start_patience;
%     %����ӦѰ��������Χ
%     while r <= DataSet.n
%         %����Ӧ������Χ
%         fprintf("r is now:%d\n",r);
% 
% 
%         [Rnbi,numb] = DDOutlier.rnbs(DataSet,r);
%         if r == 1
%             %��ʵ���ǵ�һ��ѭ�����ͳ�ʼ����һ�������뾶
%             numb_upd = numb;
%             r = r + 1;
%         elseif numb_upd == numb
%             disp(patience);
%             patience = patience - 1;
%             r = r + 1;
%             if(patience == 0)
%                 disp(numb_upd);
%                 break;
%             end
%         else
%             numb_upd = numb;
%             r = r + 1;
%             patience = start_patience;
%         end
% 
% 
%     end
% 
%     %���ܻ�ӭ��Ļ�ӭ��
%     max_nb = max(Rnbi);
%     disp('Max Neighbour');
%     disp(max_nb);
% %end