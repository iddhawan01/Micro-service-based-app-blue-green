#!/bin/bash
BRANCH=$1

if [ "$BRANCH" == "main" ]; then
  echo "✅ Switching traffic to GREEN environment (PROD)..."
else
  echo "ℹ️ Deploying to BLUE environment (INT)..."
fi
