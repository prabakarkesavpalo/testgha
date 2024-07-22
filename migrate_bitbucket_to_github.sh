#!/bin/bash

# Set variables
# GitHub Personal Access Token (PAT) use the classic option 
# including repository migration tasks (or)
# repo, admin:org, admin:public_key,workflow, admin:repo_hook, gist, notifications
GITHUB_PAT=""
#jenkins token 
# admin token
#GITHUB_PAT=""
GITHUB_ORG="bbstogh"
BITBUCKET_TOKEN=""
# Bitbucket Server credentials
BITBUCKET_URL="http://bbs.southeastasia.cloudapp.azure.com:7990"
#BITBUCKET_USER="your_bitbucket_username"
#BITBUCKET_PASSWORD="your_bitbucket_password"

BITBUCKET_PROJECT="bbsgh" 
BITBUCKET_REPO="repo1"
BITBUCKET_SHARED_HOME="/var/atlassian/application-data/bitbucket/shared"


# # Install gh-bbs2gh extension
# gh extension install github/gh-bbs2gh

# Run the migration
gh bbs2gh migrate-repo \
    --github-org $GITHUB_ORG \
    --bbs-server-url $BITBUCKET_URL \
    --github-pat $GITHUB_PAT \
    --bbs-username "pkesavan" \
    --bbs-password "" \
    --azure-storage-connection-string "DefaultEndpointsProtocol=https;AccountName=prughmigration;AccountKey;EndpointSuffix=core.windows.net" \
    --bbs-project $BITBUCKET_PROJECT \
    --ssh-user "azureuser" \
    --ssh-private-key "/Users/prabakarankesavan/pru/code/testgha/pk" \
    --bbs-repo $BITBUCKET_REPO \
    --github-repo $BITBUCKET_REPO \
    --bbs-shared-home $BITBUCKET_SHARED_HOME \
    --target-repo-visibility private

echo "Migration completed successfully!"

# delete_repo 
# gh repo delete $GITHUB_ORG/$BITBUCKET_REPO --yes
 

# Generate migration script
gh bbs2gh generate-script \
     --github-org $GITHUB_ORG \
     --bbs-server-url $BITBUCKET_URL \
     --bbs-username "pkesavan" \
     --bbs-password "Getwellsoon@2024"