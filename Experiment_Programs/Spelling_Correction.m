%% Spelling Correction
RespLength = length(Response_CB);
Spelling_Status_CB = zeros(1,RespLength);

Word_Pointer = 0;

DrawFormattedText(window,'Checking Your Spelling...','center','center');
Screen('Flip',window);

for ite_Check = 1:RespLength
    try
        [Spelling_Status_CB(ite_Check),Outputs] = spellcheck(Response_CB{ite_Check});
    catch
        Spelling_Status_CB(ite_Check) = 1;
        Outputs = {Response_CB{ite_Check},'Correct!'};
    end
    Check_Outputs_CB{ite_Check} = Outputs;
    if Spelling_Status_CB(ite_Check) == 0
        Word_Pointer = Word_Pointer + 1;
        Original_Ans{Word_Pointer} = Outputs{1};
        Suggested_Ans{Word_Pointer} = Outputs{2};
    end
end

Y_display = linspace(y_center - 150, y_center + 150, 4);

try
    Wrong_Loc{iteB} = find(Spelling_Status_CB == 0);
catch
    Wrong_Loc{iteB} = 0;
end

if Word_Pointer > 0
    
    for ite_Cor = 1:Word_Pointer
        DrawFormattedText(window,['You typed in "',Original_Ans{ite_Cor},'",'],'center',Y_display(1));
        if strcmp(Suggested_Ans{ite_Cor},'NS')
            DrawFormattedText(window,'unfortunately we do not have suggestions for the spelling','center',Y_display(2));
            DrawFormattedText(window,'Please press DELETE (not BackSpace) to retype the word','center',Y_display(4));
        else
            DrawFormattedText(window,['did you mean "',Suggested_Ans{ite_Cor},'"?'],'center',Y_display(2));
            DrawFormattedText(window,'Press ENTER for yes, and press DELETE (not BACKSPACE) for no.','center',Y_display(3));
            DrawFormattedText(window,'If you select no, you will be given a chance to type in this word again.','center',Y_display(4));
        end
        
        Screen('Flip',window);
        while 1
            [~,~,kJ] = KbCheck();
            
            if kJ(KbName('return'))
                Response_CB{Wrong_Loc{iteB}(ite_Cor)} = Suggested_Ans{ite_Cor};
                Screen('Flip',window);
                WaitSecs(Waiting_Time);
                break
                
            elseif kJ(KbName('DELETE'))
                DrawFormattedText(window,'+', 'center','center');
                Screen('Flip',window);
                WaitSecs(Cross_Delay);
                Screen('FrameRect', window,black,Rect_Word);
                DrawFormattedText(window,'Please type in this word again. When you finish, press Space to continue.', 'center',y_center + 200,black);
                Screen('Flip', window);
                ListenChar(2); %start receiving keyboard input
                Recall_Word = '';
                
                while 1
                    [response,~] = GetChar();
                    [kd,secs,keycode] = KbCheck();
                    
                    %if 'space', stop receiving keyboard input and move on to the next step
                    if (keycode(KbName('space')))
                        if ~isempty(Recall_Word)
                            ListenChar(2);
                            break
                        end
                    end
                    
                    %display participant's input
                    if ~(keycode(KbName('space')))
                        Screen('FrameRect', window,black,Rect_Word);
                        DrawFormattedText(window,'Please type in this word again. When you finish, press Space to continue.', 'center',y_center + 200,black);
                        
                        if response=='a' || response=='b' || response=='c' || response=='d' || response=='e' || ...
                                response=='f' || response=='g' || response=='h' || response=='i' || response=='j' ||...
                                response=='k' || response=='l' || response=='m' || response=='n' || response=='o'|| ...
                                response=='p' || response=='q' || response=='r' || response=='s' || response=='t'|| ...
                                response=='u' || response=='v' || response=='w' || response=='x' || response=='y' || response=='z' || ...
                                response=='A' || response=='B' || response=='C' || response=='D' || response=='E' || ...
                                response=='F' || response=='G' || response=='H' || response=='I' || response=='J' ||...
                                response=='K' || response=='L' || response=='M' || response=='N' || response=='O'|| ...
                                response=='P' || response=='Q' || response=='R' || response=='S' || response=='T'|| ...
                                response=='U' || response=='V' || response=='W' || response=='X' || response=='Y' || response=='Z'
                            
                            Recall_Word = lower([Recall_Word,response]);
                            DrawFormattedText(window,Recall_Word,'center','center');
                            Screen('Flip', window);
                        end
                        
                        if keycode(KbName('backspace')) %This should be changed to 'delete' when using a mac
                            if ~isempty(Recall_Word)
                                Recall_Word(end) = [];
                                DrawFormattedText(window,Recall_Word,'center','center');
                                Screen('Flip', window);
                            end
                        end
                    end
                end
                ListenChar(-1);
                Response_CB{Wrong_Loc{iteB}(ite_Cor)} = Recall_Word;
                Screen('Flip',window);
                WaitSecs(Waiting_Time);
                break
            end
        end
    end
    
end