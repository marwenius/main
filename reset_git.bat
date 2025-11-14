@echo off

REM reset_git.bat
REM credit:
REM - "How To Delete All Past Commits in a Git Branch (Short and Sweet!)":
REM - https://www.youtube.com/watch?v=DpdTvF2c7Hg
REM - https://www.youtube.com/@matthewjury6327
REM - https://github.com/BlueLovin

REM new branch
git checkout --orphan new_branch

REM use this in root directory only
git add .

REM ur message here
git commit -m "reset main"

REM delete main branch
git branch -D main 

REM rename current branch to 'main'
git branch -m main

REM push and finish
git push -f origin main

REM track branch
git branch --set-upstream-to=origin
