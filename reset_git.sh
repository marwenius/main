#! /bin/bash
# reset_git.sh
# credit:
# - "How To Delete All Past Commits in a Git Branch (Short and Sweet!)":
# - https://www.youtube.com/watch?v=DpdTvF2c7Hg
# - https://www.youtube.com/@matthewjury6327
# - https://github.com/BlueLovin

# new branch
git checkout --orphan new_branch

# use this in root directory only
git add .

# ur message here
git commit -m "reset main"

# delete main branch
git branch -D main 

# rename current branch to 'main'
git branch -m main

# push and finish
git push -f origin main

# track branch
git branch --set-upstream-to=origin
