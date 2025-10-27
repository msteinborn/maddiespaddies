#!/bin/bash
set -e

echo "[0/4] Ensuring we're in project root..."
# optional: uncomment if you want script to always run relative to itself
# cd "$(dirname "$0")"

########################################
# 1. Commit & push source branch (main)
########################################
echo "[1/4] Committing and pushing Hugo source to main..."

# make sure we're on main in the root repo
git checkout main

# stage everything EXCEPT public/ (public/ should be in .gitignore anyway)
git add .

# commit if there are staged changes
if ! git diff --cached --quiet; then
    git commit -m "Update site source"
    git push origin main
else
    echo "No source changes to commit."
fi


########################################
# 2. Build site with Hugo
########################################
echo "[2/4] Building static site with Hugo..."
hugo


########################################
# 3. Commit & push built site to deploy
########################################
echo "[3/4] Publishing build output to deploy branch..."

cd public

# make sure we're on the deploy branch
git checkout -B deploy

# stage everything in public (the generated site)
git add .

# commit if there are staged changes
if ! git diff --cached --quiet; then
    git commit -m "Publish site"
else
    echo "No publish changes to commit."
fi

# force push to deploy branch (this is what Pages serves)
git push origin deploy --force

cd ..

########################################
# 4. Done
########################################
echo "[4/4] Deploy complete. Live site should now reflect this build."
