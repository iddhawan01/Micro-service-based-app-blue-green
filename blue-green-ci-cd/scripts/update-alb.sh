#!/bin/bash
# Usage: ./update-alb.sh <branch-name>

BRANCH=$1

if [ "$BRANCH" == "main" ]; then
  echo "Switching traffic to GREEN environment..."
  # Example AWS CLI command (replace with your own target group ARN)
  aws elbv2 modify-listener \
    --listener-arn <YOUR-LISTENER-ARN> \
    --default-actions Type=forward,TargetGroupArn=<GREEN-TG-ARN>
else
  echo "Deploying to INT branch ($BRANCH), keeping traffic on BLUE environment..."
  aws elbv2 modify-listener \
    --listener-arn <YOUR-LISTENER-ARN> \
    --default-actions Type=forward,TargetGroupArn=<BLUE-TG-ARN>
fi