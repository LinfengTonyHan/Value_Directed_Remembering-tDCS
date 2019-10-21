%% Rest
DrawFormattedText(window,'Please reach the experimenter now and do NOT press anything. \n\n We will modify the stimulation parameters before you proceed to the next list.','center','center',black);
Screen('Flip',window);
while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

DrawFormattedText(window,'Press SPACE to continue','center','center',black);
Screen('Flip',window);
while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

DrawFormattedText(window,'For the experimenter: \n\n Is the device fully prepared?','center','center',black);
Screen('Flip',window);
while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('y'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

Start_Time = GetSecs();

while GetSecs < Start_Time + Stim_Change_Dur
    Screen('TextColor',window,black);
    Time_Left = ceil(Stim_Change_Dur - (GetSecs - Start_Time));
    DrawFormattedText(window, ['Now it is time for you to get accustomed to the new stimulation. \n\n time left: ', ...
        num2str(Time_Left),' secs\n\n During this period, please feel free to inform the experimenter if you feel any discomfort.'],...
        'center','center',black);
    Screen('Flip',window);
end

DrawFormattedText(window,'Press SPACE to continue','center','center',black);
Screen('Flip',window);
while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

