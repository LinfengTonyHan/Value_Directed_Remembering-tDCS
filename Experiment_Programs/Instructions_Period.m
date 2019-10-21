%% This script is for providing the instuctions to subjects
Ins.Begin1 = 'GENERAL GUIDELINES \n\n\n Thank you for participating in our study! \n\n This is a 2-session study, which requires you to finish a 50-minute experiment \n\n(while receiving mild brain stimulation with a tDCS device) plus a few questionnaires today, \n\n and another 30-minute experiment which will involve only behavioral testing tomorrow. \n\n Please press the Space bar to proceed.';
Ins.Begin2 = 'GENERAL GUIDELINES \n\n\n The experiment today will involve a memory challenge game. \n\n Your goal will be to accumulate the most points, \n\n and you will earn points for successfully remembering the words you are asked to study. \n\n You will study 12 lists of words. including two lists for you to practice with. \n\n In each list, 30 words will be presented sequentially for you to remember. \n\n Importantly, a "point value" is assigned to each word and will be presented together with the word. \n\n This point value indicates how many points you will earn if you later recall that word during the memory test. \n\n Some of the words have higher points (10, 11, or 12), while the other words have lower points (1, 2, or 3). \n\n Here we have a demo illustrating how the points and words will be presented. \n\n please press the Space bar to proceed.';
Ins.Begin3 = 'BE PREPARED FOR THE POTENTIAL RECALL TESTS \n\n\n Immediately after studying each word list, your memory may be tested with a free recall test, \n\n in which you will have 90 seconds to type as many of the studied words from that list as you can recall (in any order). \n\n For each word that you successfully recall, you will earn the number of points that were associated with that word. \n\n Importantly, you should only recall the words from the most recent list that you studied, \n\n since any words you recall from prior lists will not be counted towards your score. \n\n Though there will be 2 practice lists, in which you will for sure be tested. \n\n For the other 10 formal lists, only some of them will be tested for recall, and the other lists will not be tested. \n\n However, in order to earn the high possible point score, \n\n it is best for you to always assume that your memory will be tested so that you are prepared for the recall test. \n\n Please press the Space bar to proceed.';
Ins.Begin4 = 'BE PREPARED FOR THE POTENTIAL RECALL TESTS \n\n\n After you finish typing all of the words you recall, there will be an automated spell check procedure. \n\n The computer will go through the items that you recalled and provide you with possible suggestions of spelling corrections, \n\n if any of the words you typed is incorrect in spelling. \n\n If you accept the correction suggested by the computer, your answer will be changed automatically to that suggestion.\n\n If you reject the correction suggested by the computer, you will be given another opportunity to type the word again, \n\n which is the LAST opportunity to correct your spelling.\n\n Afterwards, the computer will send you feedback on your correctly recalled words and their corresponding points, \n\n as well as the total points that you obtain from the current recall test. \n\n You will also see your best score and the total accumative points obtained throughout the experiment. \n\n Please press the Space bar to proceed.';
Ins.Begin5 = 'TRY TO GAIN AS MANY POINTS AS YOU CAN \n\n\n In the experiment today, your critical job is to try to obtain as many points as you possibly can in each list. \n\n Again, please remember that the first two practice lists will for sure be tested. \n\n And for the other 10 formal lists, only some of them will be tested. \n\n However, in order to gain the most points, it is best for you to get prepared for those tests ALL the time. \n\n Please press the Space bar to proceed.';
Ins.Begin6 = 'BRAIN STIMULATION NOTICE \n\n\n After you finish practicing with the first two lists, a tDCS device will administer weak electrical current on your scalp. \n\n We will initiate the stimulation before you proceed to the first formal list, \n\n and will modify the stimulation after you finish the half of the formal testing lists (including the potential recall test). \n\n This stimulation is safe and has formally been approved by the Institutional Review Board. \n\n However, please feel free to correspond with the experimenter immediately if you feel any discomfort, \n\n or if you want us to terminate the stimulation at any time during the experimental session. \n\n Please press the Space bar to proceed.';
Ins.Begin7 = 'A 20-second break will occur after you finish each word list. \n\n Next, you are going to have two lists to practice with, in which you will for sure be tested with recall. \n\n After that there will be 10 formal testing lists, in which you are required to get ready for the potential recall tests all the time. \n\n Please try your best to gain the highest possible points in each list. \n\n If you do not have further questions regarding the experiment, and if you are ready to begin, \n\n please press the Space bar to proceed to the first practice list.';
%% Display the instructions
% 1st ins
Screen('TextSize',window,Word_Size);
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

Screen('TextColor',window,black);
Screen('TextSize',window,ECDsize);
PV_Value = [10,2,12,3];
PV_Item = {'welcome','to','our','experiment'};
for PV = 1:4 %PV:practice view
    Screen('DrawTexture',window,ValueImg(PV_Value(PV)),[],Rect_Center);
    Screen('Flip',window);
    WaitSecs(Coin_Time);
    Screen('DrawTexture',window,ValueImg(PV_Value(PV)),[],Rect_Center);
    DrawFormattedText(window,PV_Item{PV},'center',y_center + word_move);
    Screen('Flip',window);
    WaitSecs(Duration);
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
end

Screen('TextSize',window,Word_Size);

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
DrawFormattedText(window,Ins.Begin6,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);
DrawFormattedText(window,Ins.Begin7,'center','center');
Screen('Flip',window);

while 1
    [~,~,kC] = KbCheck();
    if kC(KbName('space'))
        break
    end
end

Screen('Flip',window);
WaitSecs(Waiting_Time);
