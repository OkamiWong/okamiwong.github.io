REPO="okamiwong/okamiwong.github.io"
COUNT=0

# Get all deployment IDs and loop through them
for ID in $(gh api repos/$REPO/deployments --paginate | jq -r '.[].id'); do
    echo "Deleting deployment $ID..."
    # Mark as inactive
    gh api -X POST repos/$REPO/deployments/$ID/statuses -f state=inactive > /dev/null
    # Delete
    gh api -X DELETE repos/$REPO/deployments/$ID > /dev/null

    ((COUNT++))
done

echo "Total deployments deleted: $COUNT"
