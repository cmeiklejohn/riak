#!/bin/sh

echo "Writing first value."
curl -XPOST localhost:8098/types/default/buckets/users/keys/john_smith \
    -H 'x-riak-index-twitter_bin: jsmith123' \
    -H 'x-riak-index-email_bin: jsmith@basho.com' \
    -H 'Content-Type: application/json' \
    -d '{"userData":"data"}'

echo "Writing second value."
curl -XPOST localhost:8098/types/default/buckets/users/keys/jon_smith \
    -H 'x-riak-index-twitter_bin: smith' \
    -H 'x-riak-index-email_bin: jonsmith@basho.com' \
    -H 'Content-Type: application/json' \
    -d '{"userData":"data"}'

echo "Running keylist."
curl http://localhost:8098/buckets/welcome/keys?keys=lasp
echo

echo "Executing query."
curl localhost:8098/buckets/users/index/twitter_bin/jsmith123?lasp=true
echo
