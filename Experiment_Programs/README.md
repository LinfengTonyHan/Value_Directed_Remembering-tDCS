This folder contains the experimental programs (written in Psychtoolbox) for data collection.

All scripts were written by Linfeng Han (Tony), visiting research assistant at Rissman Memory Lab, UCLA.

For any questions or comments, please feel free to contact Linfeng via email: linfenghan98@gmail.com

***VDR_Main_Session1.m*** is the main script for Day 1 experiment. It contains the following main modules:
**1. Value-based memory encoding.** Participants study multiple lists of words, and each word is arbitrarily assigned with a point value. Participants are explicitly told that their goal is to obtain the highest possible point value in the free recall, so we might expect that participants will be selective in this encoding phase. This module is included in ***VDR_Main_Session1.m***.
**2. Free recall.** Participants are given 90 seconds to recall as many words as they can (in any order). The goal is to obtain the highest possible point. Only some of the lists will be tested with free recall, while others are skipped (and tested on Day 2). This module is included in ***VDR_Main_Session1.m***.
**3. Spell check.** For each word not spelled correctly by the a participant, s/he will be given one chance to correct the spelling. One suggestion is given to the participant, and s/he can select "accept the suggestion" or "reject the suggestion" and type the word once again. The Microsoft Word spellcheck system is imported by ActiveX to MATLAB. This module is written in ***Spelling_Correction.m***.
**4. Feedback on performance.** Cohen et al. (2014, 2016) pointed out that the feedback on performance allows for sculpting of cognitive strategies. Here, we presented these pieces of information to the participants: correctly recalled words (and the point values associated with them), total point values obtained in the current list, total accumulative points, and best score (including the current list). This module is written in ***Screen_Feedback.m***.

Other portions of the experiment (e.g., instructions, rests) are written in other scripts in this repository.
