#!/bin/bash

# Load environment variables from .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$PUBLIC_REPO_PATH" ]; then
  echo "Error: PUBLIC_REPO_PATH is not set in .env"
  exit 1
fi

if [ ! -d "$PUBLIC_REPO_PATH" ]; then
  echo "Error: PUBLIC_REPO_PATH directory does not exist: $PUBLIC_REPO_PATH"
  exit 1
fi

PRIVATE_REPO_PATH=$(pwd)

echo "Starting deployment to public repo at $PUBLIC_REPO_PATH..."

# 1. Delete all the files except the .git folder in the public repo folder.
echo "WARNING: This script will perform a deletion in: $PUBLIC_REPO_PATH"
echo "Command: find . -maxdepth 1 ! -name \".git\" ! -name \".\" -exec rm -rf {} +"
read -p "Are you sure you want to proceed? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Deployment cancelled."
    exit 1
fi

echo "Cleaning public repo folder..."
cd "$PUBLIC_REPO_PATH" || exit 1
find . -maxdepth 1 ! -name ".git" ! -name "." -exec rm -rf {} +

# 2. Copy all the files in the private repo that is not ignored by git to the public repo folder.
echo "Copying files from private repo..."
cd "$PRIVATE_REPO_PATH" || exit 1
git archive HEAD | tar -x -C "$PUBLIC_REPO_PATH"

# 3. Reset the HEAD of the public repo to the oldest commit
echo "Resetting HEAD of public repo to the oldest commit..."
cd "$PUBLIC_REPO_PATH" || exit 1
OLDEST_COMMIT=$(git rev-list --max-parents=0 HEAD)
git reset "$OLDEST_COMMIT"

# 4. Commit all the files with message "squashed commit"
echo "Committing changes..."
git add .
git commit -m "squashed commit"

# 5. git push -f in the public repo
echo "Pushing to public repo..."
git push -f

echo "Deployment complete!"
