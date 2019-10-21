%% This script is for generating the group conditions

GroupNum = repmat([1,1,2,3,3,4],1,30);

for ite = 1:30
    GroupNum((ite * 6 - 5):(ite * 6)) = Shuffle(GroupNum((ite * 6 - 5):(ite * 6)));
end

LA = 1;
LS = 1;
RA = 1;
RS = 1;

for ite = 1:180
    switch GroupNum(ite)
        case 1
            SS_Group_Info{1,ite} = 'Left_Anodal';
            SS_Group_Info{2,ite} = ite;
            SS_Group_Info{3,ite} = LA;
            SS_Group_Info{4,ite} = 1;
            LA = LA + 1;
        case 2
            SS_Group_Info{1,ite} = 'Left_Sham';
            SS_Group_Info{2,ite} = ite;
            SS_Group_Info{3,ite} = LS;
            SS_Group_Info{4,ite} = 2;
            LS = LS + 1;
         case 3
            SS_Group_Info{1,ite} = 'Right_Anodal';
            SS_Group_Info{2,ite} = ite;
            SS_Group_Info{3,ite} = RA;
            SS_Group_Info{4,ite} = 3;
            RA = RA + 1;
         case 4
            SS_Group_Info{1,ite} = 'Right_Sham';
            SS_Group_Info{2,ite} = ite;
            SS_Group_Info{3,ite} = RS;
            SS_Group_Info{4,ite} = 4;
            RS = RS + 1;
    end
end
            
save SS_Group_Info.mat SS_Group_Info