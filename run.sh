#!/bin/bash
PASSWORD="$WERCKER_BITBUCKET_BUILD_STATUS_PASSWORD""$WERCKER_BITBUCKET_BUILD_STATUS_API_KEY"
if [ ! -n "$PASSWORD" ]; then
  fail 'Missing password or API_key property'
fi

USERNAME="$WERCKER_BITBUCKET_BUILD_STATUS_USERNAME""$WERCKER_BITBUCKET_BUILD_STATUS_TEAM_NAME"
if [ ! -n "$USERNAME" ]; then
  fail 'Missing username or Team_name property'
fi

if [ "$WERCKER_GIT_DOMAIN" != "bitbucket.org" ]; then
  fail "Only valid for bitbucket-connected applications."
fi

if [ -n "$DEPLOY" ]; then
  fail 'Should be used for build steps'
fi

KEY=$WERCKER_BUILD_ID
NAME=$WERCKER_APPLICATION_OWNER_NAME/$WERCKER_APPLICATION_NAME
URL=$WERCKER_BUILD_URL
DESCRIPTION="Build by $WERCKER_STARTED_BY $WERCKER_RESULT."

if [ ! -n "$WERCKER_RESULT" ]; then
  STATE='INPROGRESS'
else
  if [ "$WERCKER_RESULT" = "passed" ]; then
    STATE='SUCCESSFUL'
  else
    STATE='FAILED'
  fi
fi

RESULT=`curl -d "key=$KEY&state=$STATE&name=$NAME&url=$URL&description=$DESCRIPTION" -u $USERNAME:$PASSWORD -s "https://api.bitbucket.org/2.0/repositories/$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY/commit/$WERCKER_GIT_COMMIT/statuses/build"  --output $WERCKER_STEP_TEMP/result.txt -w "%{http_code}"`

if [ "$RESULT" = "500" ]; then
  if grep -Fqx "No token" $WERCKER_STEP_TEMP/result.txt; then
    fail "No token is specified."
  fi

  if grep -Fqx "No hooks" $WERCKER_STEP_TEMP/result.txt; then
    fail "No hook can be found for specified subdomain/token"
  fi

  if grep -Fqx "Invalid channel specified" $WERCKER_STEP_TEMP/result.txt; then
    fail "Could not find specified channel for subdomain/token."
  fi

  if grep -Fqx "No text specified" $WERCKER_STEP_TEMP/result.txt; then
    fail "No text specified."
  fi

  fail "Unknown error: $(cat $WERCKER_STEP_TEMP/result.txt)"
fi

if [ "$RESULT" = "404" ]; then
  fail "Subdomain or token not found."
fi
