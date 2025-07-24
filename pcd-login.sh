#!/bin/bash

# === Auth Configuration ===
export OS_AUTH_URL="https://PCD_URL/keystone/v3"
export OS_USERNAME="pcd-username"
export OS_USER_DOMAIN_NAME="Default"
export OS_PROJECT_NAME="tenant_name"
export OS_PROJECT_DOMAIN_NAME="Default"
export OS_REGION_NAME="region_name"
export OS_AUTH_TYPE="password"

# === Token Cache Files ===
TOKEN_FILE="$HOME/.pcd_token"
ENV_FILE="$HOME/.pcd_token_env"

# Prompt for password (without echo)
read -s -p "🔑 Enter PCD Password: " OS_PASSWORD
echo ""

# Export password temporarily for token command
export OS_PASSWORD

echo "🔐 Logging into PCD and issuing token..."

# Issue the token
OS_TOKEN=$(pcdctl token issue -f value -c id 2>/dev/null)

# Unset the password for safety
unset OS_PASSWORD

if [[ -z "$OS_TOKEN" ]]; then
  echo "❌ Failed to get token. Please check your credentials."
  exit 1
fi

echo "✅ Token received."

# Save token to file
echo "$OS_TOKEN" > "$TOKEN_FILE"
chmod 600 "$TOKEN_FILE"

# Write token-based environment file for later use
cat <<EOF > "$ENV_FILE"
export OS_AUTH_URL="$OS_AUTH_URL"
export OS_PROJECT_NAME="$OS_PROJECT_NAME"
export OS_PROJECT_DOMAIN_NAME="$OS_PROJECT_DOMAIN_NAME"
export OS_REGION_NAME="$OS_REGION_NAME"
export OS_TOKEN="$OS_TOKEN"
export OS_AUTH_TYPE="token"
EOF

chmod 600 "$ENV_FILE"

echo "📌 Run this to activate token in your shell:"
echo "    source ~/.pcd_token_env"

