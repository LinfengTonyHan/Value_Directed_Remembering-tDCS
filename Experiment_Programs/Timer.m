%% Timer
Current_Time = GetSecs();
Gone_Time = Current_Time - Start_Time;
Left_Time = Limit_Recall - Gone_Time;

Left_Time_min = ceil(Left_Time/30);
Left_Time_min = Left_Time_min/2;

DrawFormattedText(window,[Timer_1,num2str(Left_Time_min),Timer_2], 'center',y_center-250,black);