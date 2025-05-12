if [ $# -ne 1 ]; then
  echo "Usage: $0 <csv_file>"
  exit 1
fi

csv_file="$1"

./_build/bin/cachesim \
  "$csv_file" csv \
  -t "time-col=1, obj-id-col=2" \
  lru,lfu,fifo,arc,cacheus,sieve,clock,lirs,s3fifo,qdlp,lecar,lhd,hyperbolic,gdsf \
  $(seq -s, 1000 500 50000) \
  --ignore-obj-size=1 \
  --output=../out

#docker run --rm --name cache-sim \
#  -v "$csv_file":/data.csv \
#  cache-sim /data.csv csv -t "time-col=1, obj-id-col=2" \
#  lru,lfu,fifo,arc,cacheus,sieve,clock,lirs,s3fifo,qdlp,lecar,lhd,hyperbolic,gdsf \
#  $(seq -s, 1000 500 50000) \
#  --ignore-obj-size=1 \
#  --output=/out
