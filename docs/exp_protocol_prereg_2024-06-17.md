# Preregistered Experiments - Second Run (AsPredicted #179630)

2024-06-24 17:30 CEDT
- Included otree logs for all experiments
- Pushed final code changes to accframe repo and tagged a release v0.1.1
- OpenAI Cost ACCFRAME balance for June prior to running the experiments: $37.75
- Ran `make cleandb` to remove any existing oTree and botex databases
- 17:41 starting honesty experiment by sourcing `code/run_honesty_exp.py`
- 18:00 20 participants completed the honesty experiment
- 18:16 40 participants completed the honesty experiment
- 18:52 80 participants completed the honesty experiment
- 19:08 100 participants completed the honesty experiment
- 20:41 experiment finished with 200 participants
- 21:10 exported oTree data
- 21:15 sourced `code/extract_honesty_data.py`
- 21:19 killed oTree server
- 21:20 Ran `make cleandb` to remove any existing oTree and botex databases
- 21:20 OpenAI Cost ACCFRAME balance for June: $114.66
- 21:20 starting trust experiment by sourcing `code/run_trust_exp.py`
- 22:13 Processing session 6 of 20
- 23:13 Processing session 12 of 20
- 00:30 experiment finished with 20 sessions (200 participants)
- 07:56 exported oTree data
- 07:59 sourced `code/extract_trust_data.py`
- 08:32 (uni) killed oTree server
- 08:32 Ran `make cleandb` to remove any existing oTree and botex databases
- 08:32 OpenAI Cost ACCFRAME balance for June: $191.29
- 08:34 starting giftex experiment by sourcing `code/run_giftex_exp.py`
- 10:40 Processing session 9 of 20
- 11:31 scan_page() failed when reading body text from oTree URL (Message: no such element: Unable to locate element: {"method":"tag name","selector":"body"}) in beginning of session 12 (xjne3ft4), no exp data has been collected for this session yet.
- 11:35 Exported oTree data
- 11:45 Stopping `code/run_giftex_exp.py` from debugger also stopped oTree server
- 12:00 Used code `code/modify_botex_db.py` to remove participant data of session 12 from botex database
- 12:15 Added error checking for `scan_page()` in botex package
- 12:17 botex package tests OK
- 12:27 Sourced `code/run_giftex_exp_mod.py` to run the missing 9 sessions.
- 14:37 2nd leg of experiment finished with 9 sessions (90 participants)
- 15:35 Exported oTree data 
- 15:54 Used `code/merge_csv.py` to concatenate the two oTree CSV files (column order differed)
- 15:57 Sourced `code/extract_giftex_data.py`
- 17:09 OpenAI Cost ACCFRAME balance for June: $302.97
- 17:12 Pushed code and data to accframe repo