#!/bin/bash

response=$(curl -L -sS \
    -X GET \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer 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" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/prabakarkesavpalo/testgha/environments/production)

echo $
if [[ $response == *"\"status\": 404"* ]]; then
    # Create new environment
    curl -L \
    -X PUT \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer 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" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/prabakarkesavpalo/testgha/environments/production
else
  echo "Environment found"
fi

curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer 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" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/prabakarkesavpalo/testgha/environments/production \
  -d '{"reviewers":[{"type":"User","id":59009569}]}'

curl -L \
    -X DELETE \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer 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" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/prabakarkesavpalo/testgha/environments/production/reviewers/59009569

    curl -L \
        -X POST \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer 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" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/prabakarkesavpalo/testgha/environments/production/actions/permissions/reviewer \
        -d '{"permissions": "write"}'

        curl -L \
            -X PATCH \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: Bearer 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" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            https://api.github.com/repos/prabakarkesavpalo/testgha/environments/production \
            -d '{"required_reviewers": false}'