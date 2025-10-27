#!/bin/bash
set -e

########################################
# 1. Commit & push source branch (main)
########################################

echo "[1/3] Committing and pushing source (main branch)..."

# Make sure we're on main in the root repo
git checkout main

# Stage all changes in the Hugo source (layouts/, content/, static/, etc.)
git add .

# Only commit if there are staged changes
if ! git diff --cached --quiet; then
    git commit -m "Update site source"
    git push origin main
else
    echo "No source changes to commit."
fi


########################################
# 2. Build the site with Hugo
########################################

echo "[2/3] Building site with Hugo..."
hugo


########################################
# 3. Commit & push generated site (deploy branch)
########################################

echo "[3/3] Committing and pushing built site (deploy branch)..."

cd public

# Ensure we're on the deploy branch in /public
git checkout -B deploy

# Stage all built files
git add .

# Only commit if there are staged changes
if ! git diff --cached --quiet; then
    git commit -m "Publish site"
    git push origin deploy
else
    echo "No published changes to commit."
fi

cd ..

echo "✅ Deploy complete."