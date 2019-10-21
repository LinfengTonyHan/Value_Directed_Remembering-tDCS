%% Rest
Start_Time = GetSecs();
while GetSecs < Start_Time + Rest
    Time_Left = ceil(Rest - (GetSecs - Start_Time));
    DrawFormattedText(window, ['Time for a break! \n\n time left: ', ...
        num2str(Time_Left),' secs'],...
        'center','center',black);
    Screen('Flip',window);
end

DrawFormattedText(window,'Press SPACE to continue. \n\n Please remember to use the entire range of the scale to make judgments.','center','center',black);
Screen('Flip',window);
while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

