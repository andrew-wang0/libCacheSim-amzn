if [ $# -ne 1 ]; then
  echo "Usage: $0 <local_csv_file>"
  exit 1
fi

csv_file="$1"
sizes=$(seq -s, 1000 1000 50000)
algos=(lru lfu fifo arc cacheus sieve clock lirs s3fifo qdlp lecar lhd hyperbolic gdsf)

docker build -t cache-sim .

for algo in "${algos[@]}"; do
  docker run --name cache-sim \
    -v "$csv_file":/data.csv \
    cache-sim /data.csv csv -t "time-col=1,obj-id-col=2" \
    "$algo" \
    "$sizes" \
    --ignore-obj-size=1 \
    --output=/output.csv

  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  docker cp cache-sim:/output.csv "./results/output-${algo}-${timestamp}.csv"
  docker rm cache-sim --force
done
