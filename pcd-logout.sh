#!/bin/bash

TOKEN_FILE="$HOME/.pcd_token"
ENV_FILE="$HOME/.pcd_token_env"

if [[ -f "$TOKEN_FILE" ]]; then
  export OS_TOKEN=$(cat "$TOKEN_FILE")
  export OS_AUTH_TYPE="token"
  export OS_AUTH_URL="https://PCD_URL/keystone/v3"
  export OS_PROJECT_NAME="tenant_name"
  export OS_PROJECT_DOMAIN_NAME="Default"

  echo "🚪 Revoking OpenStack token..."

  pcdctl token revoke "$OS_TOKEN" >/dev/null 2>&1

  if [[ $? -eq 0 ]]; then
    echo "✅ OpenStack token revoked."
  else
    echo "⚠️  Failed to revoke token. It may have already expired."
  fi

  rm -f "$TOKEN_FILE" "$ENV_FILE"
else
  echo "ℹ️ No token found. Nothing to revoke."
fi

