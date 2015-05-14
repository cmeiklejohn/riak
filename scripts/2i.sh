#!/bin/sh

# echo "Rebuilding source."
# make

# echo "Setting ulimit."
# ulimit -n 4096

# echo "Starting riak."
# rel/riak/bin/riak start

# echo "Waiting for riak to start."
# sleep 100

echo "Writing records."
for i in `seq 1 100`;
do
  echo "POST localhost:8098/types/default/buckets/users/keys/john_smith_${i}"
  time curl -XPOST "localhost:8098/types/default/buckets/users/keys/john_smith_${i}" \
      -H "x-riak-index-name_bin: john_smith" \
      -H "Content-Type: application/json" \
      -d '{"userData":"data"}'
done

echo "Executing keylist."
time curl http://localhost:8098/buckets/welcome/keys?keys=lasp
echo

echo "Executing 2i query."
echo "GET localhost:8098/buckets/users/index/name_bin/john_smith?lasp=true"
time curl localhost:8098/buckets/users/index/name_bin/john_smith?lasp=true
echo

# echo "Stopping riak."
# rel/riak/bin/riak stop
