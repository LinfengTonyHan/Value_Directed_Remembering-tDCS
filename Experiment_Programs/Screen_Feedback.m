%% This is the script for giving feedback to the participant
DrawFormattedText(window,'Now you have 12 seconds to view your answers and the total points you get. \n\n Press SPACE to continue.','center','center');
Screen('Flip',window);
while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

%Clean the variables 
%% First Combining the Study List and Corresponding ValueString, and then SORTING and Spliting
COMBINE = [ItemString; num2cell(ValueString)];
SortedList = sortrows(COMBINE',2)';
ItemString = SortedList(1,:);
ValueString = cell2mat(SortedList(2,:));

Correct_All = crecallprob(ItemString,ResponseItems{iteB});
Correct_All(Correct_All >= 1) = 1;

Item_LV = ItemString(1:15); Item_HV = ItemString(16:30); %Seperating the two types
Value_LV = ValueString(1:15); Value_HV = ValueString(16:30);

Correct_LV = crecallprob(Item_LV,ResponseItems{iteB});
Correct_LV(Correct_LV >= 1) = 1;

Correct_HV = crecallprob(Item_HV,ResponseItems{iteB});
Correct_HV(Correct_HV >= 1) = 1;

CR_Resp_LV{iteB} = Item_LV(Correct_LV == 1);
CR_Resp_HV{iteB} = Item_HV(Correct_HV == 1);
CR_Value_LV{iteB} = Value_LV(Correct_LV == 1);
CR_Value_HV{iteB} = Value_HV(Correct_HV == 1);

DIFF{iteB} = setdiff(ResponseItems{iteB},ItemString);
TotalValue = sum(ValueString .* Correct_All);
ValueHistory(iteB) = TotalValue;
BestScore = max(ValueHistory);
Accumulated = sum(ValueHistory);
clear OtherResp;

if length(DIFF{iteB}) >= 15
    OtherResp = DIFF{iteB}(1:14);
    OtherResp{15} = '...';
else
    OtherResp = DIFF{iteB};
end

%% Procedure: 
%Display the actual studied words and their corresponding values in the first 4 columns,
%The first 2 columns display the low-value items, while the next 2 columms
%display higg-value items, then participants response will be displayed on
%another 2 column, thus there will be a total of 6 columns and 13 rows (including the titles)
nrow = 21;
ncol = 4;
xbound = 0.4;
ybound  = 0.42;
xbound_return = 0.15;
Title_SW = 'Answers';
Title_V = 'Points';
Title_YA = 'Your Other Response';

Xcoor = linspace(x_center - window_w * xbound, x_center + window_w * (xbound - xbound_return), ncol);
Ycoor = linspace(y_center - window_h * ybound, y_center + window_h * ybound, nrow+1);

DrawFormattedText(window,Title_SW,Xcoor(1),Ycoor(1));
DrawFormattedText(window,Title_V,Xcoor(2),Ycoor(1));
DrawFormattedText(window,Title_SW,Xcoor(3),Ycoor(1));
DrawFormattedText(window,Title_V,Xcoor(4),Ycoor(1));
%DrawFormattedText(window,Title_YA,Xcoor(5),Ycoor(1));

for disp = 1:length(CR_Resp_LV{iteB})
    DrawFormattedText(window,CR_Resp_LV{iteB}{disp},Xcoor(1),Ycoor(disp+2),black);
    DrawFormattedText(window,num2str(CR_Value_LV{iteB}(disp)),Xcoor(2),Ycoor(disp+2),[0,0,255]); 
end

for disp = 1:length(CR_Resp_HV{iteB})
    DrawFormattedText(window,CR_Resp_HV{iteB}{disp},Xcoor(3),Ycoor(disp+2),black);
    DrawFormattedText(window,num2str(CR_Value_HV{iteB}(disp)),Xcoor(4),Ycoor(disp+2),[0,0,255]);
end

% for disp = 1:length(OtherResp)
%     DrawFormattedText(window,OtherResp{disp},Xcoor(5) + 50 * MACHINE,Ycoor(disp+2),[0,0,0]);
% end
Screen('TextSize', window, 32); %Make it slightly bigger
DrawFormattedText(window,['Total Points Obtained in the Current List = ',num2str(TotalValue)],'center',Ycoor(end-3),[0,0,255]);
Screen('TextSize', window, Word_Size);
DrawFormattedText(window,['Best Score = ',num2str(BestScore)],'center',Ycoor(end-1),[0,0,0]);
DrawFormattedText(window,['Total Accumulated Points = ',num2str(Accumulated)],'center',Ycoor(end),[0,0,0]);
Screen('Flip',window);
WaitSecs(Feedback_Time);



