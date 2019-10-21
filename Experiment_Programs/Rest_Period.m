%% Rest
Start_Time = GetSecs();
while GetSecs < Start_Time + Rest
    Time_Left = ceil(Rest - (GetSecs - Start_Time));
    DrawFormattedText(window, ['Time for a break! \n\n time left: ', ...
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

