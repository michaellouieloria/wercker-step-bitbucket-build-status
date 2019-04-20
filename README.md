# Wercker Step: Bitbucket Build Status

Send build status to [bitbucket](http://bitbucket.com).

See [blog post from Bitbucket](https://confluence.atlassian.com/bitbucket/integrate-your-build-system-with-bitbucket-cloud-790790968.html) for details.

### Required fields

* `username` - username of account with access to set build status on the repo
* `password` - password of same user

OR (roughly equivalent)

* `team_name`
* `api_key`

### How to configure?

Use a team's API key or set up a separate user with access to the repo. Provide credentials using the appropriate parameters.

# Example

    build:
        steps:
            - michaellouieloria/bitbucket-build-status:
                team_name: michaellouieloria
                api_key: $WERCKER_BITBUCKET_USER_API_KEY
        after-steps:
            - michaellouieloria/bitbucket-build-status:
                team_name: michaellouieloria
                api_key: $WERCKER_BITBUCKET_USER_API_KEY
