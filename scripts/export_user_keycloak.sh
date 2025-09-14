#! /bin/bash

# Script to export the users from the Keycloak realm

# Define the variables
KEYCLOAK_URL="http://localhost:8090"
KEYCLOAK_REALM="master"
KEYCLOAK_USER="admin"
KEYCLOAK_SECRET="admin"
REALM_NAME="gimnasio"

# Get the access token
ACCESS_TOKEN=$(curl -s -X POST "${KEYCLOAK_URL}/realms/${KEYCLOAK_REALM}/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=${KEYCLOAK_USER}" \
  -d "password=${KEYCLOAK_SECRET}" \
  -d "grant_type=password" \
  -d 'client_id=admin-cli' \
  | jq -r '.access_token')

echo "Access Token: ${ACCESS_TOKEN}"

# Check if token was obtained successfully
if [ "$ACCESS_TOKEN" = "null" ] || [ -z "$ACCESS_TOKEN" ]; then
  echo "Error: Failed to obtain access token"
  exit 1
fi

# Export the users (max=10000 to get more than default 100 users)
curl -s -X GET "${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/users?max=10000" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  > ../users.keycloak.json

echo "Users exported to keycloak_${REALM_NAME}_users.json"
echo "Number of users exported: $(jq length ../keycloak_${REALM_NAME}_users.json)"
