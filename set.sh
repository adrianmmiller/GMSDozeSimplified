git init --initial-branch=main
sleep 1
git remote add origin https://gitlab.com/adrian.m.miller/gmsdozesimplified.git
sleep 1
git add .
sleep 1
git commit -m "Initial commit"
sleep 1
git push --set-upstream origin main
