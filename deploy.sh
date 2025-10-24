#!/bin/bash
set -e

# 1. Build the site into public/
hugo

# 2. Commit and push source (main branch)
git add .
git commit -m "Update source"
git push origin main

# 3. Push the generated site to gh-pages
cd public
git add .
git commit -m "Deploy site"
git push origin deploy
cd ..

