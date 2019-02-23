# Create Redis cluster

* local> $ compose up
* local> $ docker exec -it redis01 sh

## Create cluster of 3 master

* redis01> # redis-trib.rb create $(hostname -i):6379 redis02:6379 redis03:6379

## Add data

* redis01> # redis-proto.sh | redis-cli -c

## Show keys stat (redis01-03)

* local> $ for i in {0..2}; do echo -n "redis0$i|"; redis-cli -h $(machine ip dev) -p $(($i+6379)) info | grep "db.*:key"; done

## Add node

* redis01> # redis-trib.rb add-node redis04:6379 $(hostname -i):6379

## Reshard

* redis01> # redis-trib.rb reshard $(hostname -i):6379

## Show keys stat (redis01-04)

* local> $ for i in {0..3}; do echo -n "redis0$i|"; redis-cli -h $(machine ip dev) -p $(($i+6379)) info | grep "db.*:key"; done
