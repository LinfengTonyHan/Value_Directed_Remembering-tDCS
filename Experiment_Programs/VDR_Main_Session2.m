%% This is the main script for the VDR-tDCS project -- Session 2
%Created by Linfeng Han, visiting research assistant at Rissman Memory Lab, UCLA

%%%%%
%Advisor: Prof. Jesse Rissman, Department of Psychology, UCLA
%%%%%
%First Complete Version Finished on July 14th
%Program Finalized on July 29th
%Instructions may need revision
%%%%%
%%%%%


%% General Procedure
% Welcome and instructions (important), thanks for coming on the second day
% Present 270 items
% Old / new judgment 
% Take a break every 45 trials

% Any post-hoc questionnaire to be added?

%% Cleaning all variables
clear();
close all;
clc;

KbName('UnifyKeyNames');

%% Subject information
rng('shuffle');
Info = {'Group','Subject Number','Initials','Gender (1=Male, 2=Female, 3=Other/Decline to State)','Age','Native Language','Handedness (1=Right, 2=Left, 3=Other/Decline to State)'};
dlg_title = 'Participant Information';
num_lines = 1;
subject_info = inputdlg(Info,dlg_title,num_lines);

group = subject_info(1); %Experimental Groups
group = str2double(cell2mat(group));
num = subject_info(2); %Subject Number (assigned by experimenters)
num = str2double(cell2mat(num));
name = subject_info(3); %Initials
name = cell2mat(name);

if floor(num) ~= num
    disp('Error in typing subject number!');
    return
end

if num < 1
    disp('Error in typing subject number!');
    return
end

filename = ['Result(',num2str(num),')_',name,'.mat'];

%% Initialize the variable
black = [0,0,0];
white = [255,255,255];
red = [255,0,0];
blue = [0,0,255];
F_Sc = []; %Full Screen
P_Sc = [0,0,900,650]; %Partial Screen

%%%%%
%%%%%
%%%%%
%% These needs to be changed!
Cross_Delay = 0.5; %Fixation Cross duration, 0.5
Waiting_Time = 0.8; %Blank Screen interval, 0.8
%%%%%
%%%%%
%%%%%
%%%%%
%% Other variables
Limit_Press = 30;
Rest = 20;
Word_Font = 'Arial';
Word_Size = 32;
Ins_Size = 23;
RT_ON= zeros(1,270); 
Resp_ON = zeros(1,270); 

%% Open the window
Screen('Preference','SkipSyncTests',1);
rng('shuffle');
[window,rect] = Screen('OpenWindow',0,[],F_Sc);
Screen('BlendFunction',window,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);

HideCursor();
win_width = rect(3) - rect(1);
win_height = rect(4) - rect(2);

x_center = win_width/2;
y_center = win_height/2;

Up = y_center - 180;
Down = y_center + 180;
UN = 'Sure New';
ID = 'Sure Old';
VS = 'Value'; %Value Sign

% load the items
load RN_List.mat
ItemList = RN_List;

Order = Shuffle(1:length(ItemList));

for ite_order = 1:length(ItemList)
    Stimuli_List{ite_order} = ItemList{Order(ite_order)};
end

Stimuli_List = lower(Stimuli_List);

Screen('TextSize',window, Word_Size);
Screen('TextFont',window,Word_Font);

commandwindow;
try
    ShowHideWinTaskbarMex(0);
catch
    HideTaskbar = -1;
end
%% Put the instructions here
Instructions_Period_SS2();
%% Defining the grid of the displayed numbers
Xcoor = linspace(x_center - 200,x_center + 200, 6);
Ycoor = y_center + 180;
X_ID = x_center + 250; %This is for controlling the location of the "sure old"
X_UN = x_center - 415; %This is for controlling the location of the "sure new"
Y_Value = y_center + 280;
All_Choice = 1:6;
NoResp = 0;

%% Phase 1: Confidence Rating
for ite_recog = 1:size(Stimuli_List, 2)
    pON = NaN; pRK = NaN;
    Start_Time = GetSecs();
    DrawFormattedText(window,'+','center','center');
    Screen('Flip',window);
    WaitSecs(Cross_Delay);
    Screen('DrawText',window,UN,X_UN,Ycoor,black);
    Screen('DrawText',window,ID,X_ID,Ycoor,black);
    Screen('TextSize', window, Word_Size + 10);
    DrawFormattedText(window,Stimuli_List{1,ite_recog},'center','center',black);
    Screen('TextSize', window, Word_Size);
    for disp_ac = 1:length(All_Choice)
        Screen('DrawText',window,num2str(All_Choice(disp_ac)),Xcoor(disp_ac),Ycoor,black);
    end
    Screen('Flip',window);
    
    %Pt = 1;
    
    while GetSecs < Start_Time + Limit_Press
        [kD,pON,kON] = KbCheck();
        Screen('DrawText',window,UN,X_UN,Ycoor,black);
        Screen('DrawText',window,ID,X_ID,Ycoor,black);
        
        for disp_ac = 1:length(All_Choice)
            Screen('DrawText',window,num2str(All_Choice(disp_ac)),Xcoor(disp_ac),Ycoor,black);
        end
        Screen('TextSize', window, Word_Size + 10);
        DrawFormattedText(window,Stimuli_List{1,ite_recog},'center','center',black);
        Screen('TextSize', window, Word_Size);
        Screen('Flip',window);
        
        Conf_Resp = NaN;
        
        if kON(KbName('1'))
            Conf_Resp = 1;
            break
        elseif kON(KbName('2'))
            Conf_Resp = 2;
            break
        elseif kON(KbName('3'))
            Conf_Resp = 3;
            break
        elseif kON(KbName('4'))
            Conf_Resp = 4;
            break
        elseif kON(KbName('5'))
            Conf_Resp = 5;
            break
        elseif kON(KbName('6'))
            Conf_Resp = 6;
            break
        end
    end
    
    Unselected = setdiff(1:6,Conf_Resp); %Unselected Choices
    Stimuli_List{2,ite_recog} = Conf_Resp;
    Conf_RT(ite_recog) = pON - Start_Time;
    
    for disp_uns = 1:length(Unselected)
        Screen('DrawText',window,num2str(Unselected(disp_uns)),...
            Xcoor(Unselected(disp_uns)),Ycoor,black);
    end
    
    try
        Screen('DrawText',window,num2str(Conf_Resp),Xcoor(Conf_Resp),Ycoor,blue);
    catch
        NoResp = NoResp + 1;
    end
    Screen('TextSize', window, Word_Size + 10);
    DrawFormattedText(window,Stimuli_List{1,ite_recog},'center','center',black);
    Screen('TextSize', window, Word_Size);
    Screen('DrawText',window,UN,X_UN,Ycoor,black);
    Screen('DrawText',window,ID,X_ID,Ycoor,black);
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    Screen('Flip',window);
    WaitSecs(Waiting_Time);
    
    if ite_recog == 45 || ite_recog == 90 || ite_recog == 135 || ite_recog == 180 || ite_recog == 225 
        %% Save the results
        cd('Data_Session2');
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
        Rest_Period_SS2();
    end
end

%% Save the results 
cd('Data_Session2');
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

%% End of Session
Screen('CloseAll');
ListenChar(1)
ShowHideWinTaskbarMex(1);
ShowCursor();