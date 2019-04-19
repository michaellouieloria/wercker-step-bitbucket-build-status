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
        after-steps:
            - allori/bitbucket-build-status:
                team_name: allori
                api_key: $WERCKER_BITBUCKET_USER_API_KEY

# License

The MIT License (MIT)

Copyright (c) 2015 Allori Pty Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Changelog

## 0.0.6
- Correct copyright

## 0.0.2 - 0.0.5
- Getting things right

## 0.0.1
- initial version
