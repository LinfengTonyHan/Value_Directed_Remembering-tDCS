%% This script is for providing the instuctions to subjects
Ins.Begin1 = 'Thank you very much for returning to our second experimental session! \n\n The duration of today’s experiment is expected to be 30 minutes in total. \n\n Please press the Space bar to proceed.';
Ins.Begin2 = 'In today’s experiment, there will be a number of words presented to you sequentially, \n\n and your job is to judge whether you studied each word (i.e. whether the word appeared on the screen) in the session yesterday. \n\n Specifically, a word you studied yesterday is defined as an “old” word, \n\n while a word that did not appear yesterday is defined as a “new” word. \n\n You will make your judgment of each word using a 6-point confidence scale, with these options provided (on the next page). \n\n Please press the Space bar to proceed.';
Ins.Begin3 = '6 – Sure Old – \n You have high confidence that you studied this word in the session yesterday. \n\n\n 5 – Maybe Old – \n You have moderate confidence that you studied this word in the session yesterday. \n\n\n 4 – Guess Old – \n You have relatively low confidence that you studied this word in the session yesterday, but you think it is rather “old” than “new”. \n\n\n 3 – Guess New – \n You have relatively low confidence that you did not study this word in the session yesterday, but you think it is rather “new” than “old”. \n\n\n 2 – Maybe New – \n You have moderate confidence that you did not study this word in the session yesterday. \n\n\n 1 – Sure New – \n You have high confidence that you did not study this word in the session yesterday. \n\n\n Please press the Space bar to proceed.';
Ins.Begin4 = 'Generally, a bigger choice value corresponds to greater confidence that you did study the word yesterday. \n\n You are supposed to use the entire range of the confidence scale instead of selecting only extreme ends (e.g., sure old / sure new), \n\n and to make your judgments as precise as possible. \n\n You will use the number keyboard (on the right side) to make your choices. \n\n The key numbers match exactly the choice values mentioned above. \n\n Please press the Space bar to proceed.';
Ins.Begin5 = 'Should you have any further questions, please let us know immediately. \n\n Your job is to use the number keyboard to judge if you studied the words yesterday. \n\n Again, an “old” word refers to a word that you studied yesterday, \n\n and a “new” word refers to a word that you did not study yesterday. \n\n Please use the entire range of the scale and make your most precise judgments. \n\n If you have no more questions, you can press the Space bar to proceed to the experiment.';
%% Display the instructions
% 1st ins
Screen('TextSize',window,Ins_Size);
DrawFormattedText(window,Ins.Begin1,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

%% 2nd ins
DrawFormattedText(window,Ins.Begin2,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);

DrawFormattedText(window,Ins.Begin3,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);
DrawFormattedText(window,Ins.Begin4,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);
DrawFormattedText(window,Ins.Begin5,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);
