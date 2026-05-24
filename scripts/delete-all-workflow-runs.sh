REPO="OkamiWong/okamiwong.github.io"
echo "Deleting all workflow runs for $REPO..."

gh run list --repo $REPO --limit 1000 --json databaseId --jq '.[].databaseId' | xargs -I {} gh run delete {} --repo $REPO

echo "All workflow runs deleted."
