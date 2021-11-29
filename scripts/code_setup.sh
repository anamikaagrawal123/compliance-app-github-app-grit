#!/usr/bin/env bash

#GITLAB_TOKEN=$(cat "$WORKSPACE/secrets/git-token")
#GITLAB_URL="$(get_env SCM_API_URL)"
#OWNER=$(jq -r '.services[] | select(.toolchain_binding.name=="app-repo") | .parameters.owner_id' /toolchain/toolchain.json)
#REPO=$(jq -r '.services[] | select(.toolchain_binding.name=="app-repo") | .parameters.repo_name' /toolchain/toolchain.json)
#curl --location --request PUT "${GITLAB_URL}/projects/${OWNER}%2F${REPO}/" \
#    --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
#    --header 'Content-Type: application/json' \
#    --data-raw '{
#    "only_allow_merge_if_pipeline_succeeds": true
#    }'
    
    
    GH_TOKEN=$(cat "$WORKSPACE/git-token")
    OWNER=$(jq -r '.services[] | select(.toolchain_binding.name=="app-repo") | .parameters.owner_id' /toolchain/toolchain.json)
    REPO=$(jq -r '.services[] | select(.toolchain_binding.name=="app-repo") | .parameters.repo_name' /toolchain/toolchain.json)
    REPO=${REPO%.git}
    echo "$OWNER"
    echo "$REPO"
    echo $GH_TOKEN
    echo $token
    curl -u ":$GH_TOKEN" https://api.github.com/repos/$OWNER/$REPO/branches/master/protection -XPUT -d '{"required_pull_request_reviews":{"dismiss_stale_reviews":true},"required_status_checks":{"strict":true,"contexts":["tekton/code-branch-protection","tekton/code-unit-tests","tekton/code-cis-check","tekton/code-vulnerability-scan","tekton/code-detect-secrets"]},"enforce_admins":null,"restrictions":null}'
    npm ci
