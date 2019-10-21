%% Rest
Start_Time = GetSecs();
while GetSecs < Start_Time + Rest_Long
    Time_Left = ceil(Rest_Long - (GetSecs - Start_Time));
    DrawFormattedText(window, ['Congratulations! You have finished the first half of testing. \n\n Time for a long break! \n\n After the break, you will need to reach the experimenter. \n\n We will modify the stimulation. \n\n Time left: ', ...
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

