./_build/bin/cachesim \
  /home/awang/Downloads/combined.txt txt\
  lru,lfu,fifo,arc,lecar,cacheus,sieve,clock \
  $(seq -s, 1000 500 50000) \
  --ignore-obj-size=1 \
  --output=/home/awang/CLionProjects/libCacheSim/out
