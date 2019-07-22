#!/bin/sh

set -e

git clone --depth=50 --branch=$TRAVIS_BRANCH https://github.com/cagancayco/gancay.co.git
cd gancay.co
mkdir public

yuicompressor --type css static/css/style.css > static/css/style.min.css
yuicompressor --type js static/js/scripts.js > static/js/scripts.min.js

hugo -v --ignoreCache

aws s3 sync public s3://$BUCKET_NAME --region=us-east-1 --cache-control max-age=$MAX_AGE --delete;
aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*";