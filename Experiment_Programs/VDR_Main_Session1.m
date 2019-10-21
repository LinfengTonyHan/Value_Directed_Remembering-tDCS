%% This is the main script for the VDR-tDCS project (Session 1)
%Created by Linfeng Han, visiting student researcher at Rissman Memory Lab, UCLA

VERSION = 2;
VERSION_DATE = '2--Oct--2019'; 

%% NOTE THAT THIS SCRIPT IS DESIGNED TO BE COPATIBLE WITH MATLAB R2012b
%% SOME OF THE PARTS SHOULD NOT BE CHANGED TO LANGUAGES IN NEW VERSIONS

%%%%%
%Advisor: Prof. Jesse Rissman, Department of Psychology, UCLA
%%%%%
%First Complete Version Finished on Sep 21th
%Program Changed on Sep 30th
%%%%%
%%%%%

%% Improvements of the program July 13th
%1. Add try catch loops
%2. Double-check the spelling correction part
%3. Add rest phase, in which participants will be asked about discomfort
%4. Add instructions and intervals (press space...)
%5. Improve robustness of the program
%6. Check data (by running a few times) -- including different subjects and
%different blocks
%7. Add Session 2
%8. Cancel all global variables and delete big functions (keeping small
%ones)
%% General procedure
% Welcome and Instruction Pages
% Encoding Phase: Value Cue -> Fixation Cross -> Target Item -> Blank Screen
% Free Recall Phase: 1.5 min Limit
% Typing Correction Phase: participants are allowed to correct the spelling
% once
% Feedback Phase: Present all target items and corresponding values on the
% screen, then display participants' response, and calculate the total
% values obtained by the participant. Correct answers will be marked
% blue
% The two phases above only occur in some of the blocks
% Finally, a post-hoc questionnaire will be presented

%% Cleaning all variables and unifying the keyboards
clear();
close all;
clc;
KbName('UnifyKeyNames');

V = '2-Oct-2019';
commandwindow();
%% Defining global variables
% Basic settings and parameters
MACHINE = 0.7; %This an important variable, by changing this value, you can
%adjust the overall size of the stimuli display (the viewing angle)
Rest = 20;  %Duration of each resting phase
Rest_Long = 90; %Duration of the rest after the 5th formal list
F_Sc = []; %Full Screen
P_Sc = [0,0,900,650]; %Partial Screen
Word_Size = 24; %The size of the characters
Word_Font = 'Arial';  %Font of the characters
img_width = 300 * MACHINE; %Width of the image displayed, it can also be controlled by MACHINE
img_height = 300 * MACHINE; %ditto
img_move = 160 * MACHINE;
word_move = 220 * MACHINE;
Limit_Recall = 90; %Time limit for recalling the words, 90s
Cross_Delay = 0.4; %Duration of the fixation cross, 0.4
Coin_Time = 1; %Duration of the coin presentation (prior to word presentation), 1
Duration = 3;  %Time for duration of displaying each word item, 3
Waiting_Time = 1; %Duration of Blank Screen Interval, 1
ECDsize = 60; %The size of the words DISPLAYED
nblock = 12; %12 (2nd version)
ntrial = 30; %30 (2nd version)
black = [0,0,0]; 
Stim_Init_Dur = 60; %60 
Stim_Change_Dur = 90; %90
Feedback_Time = 10; %10
%% Recording the demographic information
rng('shuffle');
Info = {'Group','Subject Number','Initials','Gender (1=Male, 2=Female, 3=Other/Decline to State)','Age','Native Language','Handedness (1=Right, 2=Left, 3=Other/Decline to State)'};
dlg_title = 'Participant Information';
num_lines = 1;
subject_info = inputdlg(Info,dlg_title,num_lines);

group = subject_info(1); %Experimental Groups
group = str2double(cell2mat(group));
num = subject_info(2); %Subject Number (assigned by experimenters)
num = cell2mat(num);
name = subject_info(3); %Initials
name = cell2mat(name);

filename = ['Result(',num,')_',name,'.mat'];

ListenChar(0);
%% Opening the window
commandwindow;
Screen('Preference','SkipSyncTests',1);
[window,rect]=Screen('OpenWindow',0,[],F_Sc); %The last variable: input P_Sc if wanting to open a partial screen
Screen('BlendFunction',window,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA); %Allowing transparent displays

window_w = rect(3);
window_h = rect(4);
x_center = window_w/2;
y_center = window_h/2;

rct_width = 150; %the width of the blank rect (word input box for participants)
rct_height = 50; %the height of the blank rect (word input box for participants)
Screen('TextSize', window, Word_Size);
Screen('TextFont', window, Word_Font);
Rect_Center = [x_center - img_width/2, y_center - img_height/2 - img_move, ...
    x_center + img_width/2, y_center + img_height/2 - img_move];
Timer_1 = 'You have ';
Timer_2 = ' min left';
Rect_Word = [x_center - rct_width, y_center - rct_height, x_center + rct_width, y_center + rct_height];

%% Hide the cursor and task bar
try
    ShowHideWinTaskbarMex(0);
catch
    HideTaskbar = -1;
end

HideCursor();
%% Load the pictures (of the coins)
cd('Coins_Images');
ValueImg = zeros(1,6);
for img_load = [1:3,10:12]
    img_coin = imread([num2str(img_load),'_point.png']);
    ValueImg(img_load) = Screen('MakeTexture',window,img_coin);
end
cd ..

cd('Subject_Materials');

switch group
    case 1
        cd('LeftAnodal_Group1');
    case 2
        cd('LeftSham_Group2');
    case 3
        cd('RightAnodal_Group3');
    case 4
        cd('RightSham_Group4');
end

load(['Lists_Subject_',num2str(num),'.mat']);

cd ..
cd ..

Lists_varname = {'P1','P2','L1','L2','L3','L4','L5','L6','L7','L8','L9','L10'};
%% Instructions here
Instructions_Period();
%% Experimental Session
for iteB = 1:nblock %iteB: iteration for blocks, 1~12
    %% Encoding Phase
    DrawFormattedText(window,'When you are ready to proceed to the upcoming list, please press SPACE to continue. \n\n Please get prepared for a potential recall test.','center','center');
    Screen('Flip',window);
    while 1
        [~,~,kC] = KbCheck();
        if kC(KbName('space'))
            break
        end
    end
    
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    
    SL = eval(['StudyList.',Lists_varname{iteB}]); %Defining the study list here
    Screen('TextColor',window,black);
    Screen('TextSize',window,ECDsize);
    for iteT = 1:ntrial %iteT: iteration for trials, 1~30
        Item = SL{1,iteT};
        Value = SL{2,iteT};
        Screen('DrawTexture',window,ValueImg(Value),[],Rect_Center);
        Screen('Flip',window);
        WaitSecs(Coin_Time);
        Screen('DrawTexture',window,ValueImg(Value),[],Rect_Center);
        DrawFormattedText(window,Item,'center',y_center + word_move);
        Screen('Flip',window);
        WaitSecs(Duration);
        Screen('Flip',window);
        WaitSecs(Waiting_Time);
    end
    
    Screen('TextSize',window,Word_Size);
    % Transforming from string arrays to variable names
    %% In specific blocks, free recall tests, spellchecks, and feedback are administered
    if iteB == 1 || iteB == 2 || iteB == 3 || iteB == 5 || iteB == 8 || iteB == 10 %iteB -> iteration of blocks
        
        ite = 1;
        
        %% Free Recall Phase for P1, P2, L1, L3, L6, L8
        DrawFormattedText(window,'Now you will recall the items from the previous list. \n\n Please try to earn as many points as you can. \n\n You will have 1.5 minutes in total, and please be especially careful about your spelling. \n\n Please press SPACE to continue.','center','center');
        Screen('Flip',window);
        while 1
            [~,~,kC] = KbCheck();
            if kC(KbName('space'))
                break
            end
        end
        
        Screen('Flip',window);
        WaitSecs(Waiting_Time);
        
        Start_Time = GetSecs();
        
        while GetSecs < Start_Time + Limit_Recall
            Timer;
            DrawFormattedText(window,'+', 'center','center',black);
            Screen('Flip',window);
            WaitSecs(Cross_Delay);
            Screen('FrameRect', window,black,Rect_Word);
            Timer;
            DrawFormattedText(window,'Press Space to Continue', 'center',y_center+200,black);
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
                    %If time is up, any keypress will break the loop
                    if GetSecs > Start_Time + Limit_Recall
                        break
                    end
                    
                    Screen('FrameRect',window,black,Rect_Word);
                    DrawFormattedText(window,'Press Space to Continue', 'center',y_center+200,black);
                    
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
                        Timer;
                        Screen('Flip', window);
                    end
                    
                    if keycode(KbName('BackSpace')) %This should be changed to 'delete' when using a mac
                        if ~isempty(Recall_Word)
                            Recall_Word(end) = [];
                            DrawFormattedText(window,Recall_Word,'center','center');
                            Timer;
                            Screen('Flip', window);
                        end
                    end
                end
            end
            ListenChar(-1);
            Response_CB{ite} = Recall_Word; %Response -- Current Block
            ite = ite + 1;
            Screen('Flip',window);
            WaitSecs(0.25);
        end
        Screen('Flip',window);
        WaitSecs(Waiting_Time);
        
        %% Check spelling of all the answers
        %See another script for full view
        Spelling_Correction();
        %% Give feedback to the participants
        ResponseItems{iteB} = Response_CB;
        ItemString = SL(1,:);
        ValueString = cell2mat(SL(2,:));
        Screen_Feedback();
        
        %% If it is L2, L4, L5, L7, L9, or L10
    elseif iteB == 4 || iteB == 6 || iteB == 7 || iteB == 9 || iteB == 11
        DrawFormattedText(window,'You do NOT need to complete a recall session for the list you just studied. \n\n After a short break, you can proceed to the next study list. \n\n Press SPACE to continue.','center','center',black);
        Screen('Flip',window);
        while 1
            [~,~,kC] = KbCheck();
            if kC(KbName('space'))
                break
            end
        end
        
        Screen('Flip',window);
        WaitSecs(Waiting_Time);
        
    elseif iteB == 12
        DrawFormattedText(window,'You do NOT need to complete a recall session for the list you just studied. \n\n After a short break, this session will be closed, \n\n and you will be given some questionnaires to fill out. \n\n Press SPACE to continue.','center','center');
        Screen('Flip',window);
        while 1
            [~,~,kC] = KbCheck();
            if kC(KbName('space'))
                break
            end
        end
        
        Screen('Flip',window);
        WaitSecs(Waiting_Time);
    end
    %% Take a short break
    if iteB == 7
        Rest_Period_Long;
    else
        Rest_Period;
    end
    
    %% Initiate / Change the stimulation
    if iteB == 2;
        ChangeStim1;
    end
    
    if iteB == 7
        ChangeStim2;
    end
    
    %% Save the data every block
    cd('Data_Session1');
    save(filename);
    cd ..
end

cd('Data_Session1');
save(filename);
cd ..

cd('Data_Backup'); %back up the data
save(filename);
cd ..

%%
Screen('CloseAll');
ShowHideWinTaskbarMex(1);
ListenChar(1);
ShowCursor();

%%
try
    EmailSetup;
    EmailMsg = ['Subject ',num,' has just finished session 1.'];
    sendmail('tdcs.vdr.group@gmail.com',EmailMsg);
    MailSent = 1;
catch
    MailSent = -1;
end

cd('Data_Session1');
switch group
    case 1
        cd('LeftAnodal_Group1');
    case 2
        cd('LeftSham_Group2');
    case 3
        cd('RightAnodal_Group3');
    case 4
        cd('RightSham_Group4');
end
save(filename);
cd ..
cd ..

% end of script