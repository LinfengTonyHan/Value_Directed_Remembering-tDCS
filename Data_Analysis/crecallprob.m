function [recall_times,recall_position] = crecallprob(study_list,recall_list)
size_s = size(study_list,2);
size_r = size(recall_list,2);

for ite_s = 1:size_s
    COUNT = 0;
    POSITION = [];
    for ite_r = 1:size_r 
        if strcmp(study_list{ite_s},recall_list{ite_r})
            COUNT = COUNT+1;
            POSITION(COUNT)  = ite_r;
        end
    end 
    
    recall_times(ite_s) = COUNT;
    recall_position{ite_s} = POSITION;
   
end

end