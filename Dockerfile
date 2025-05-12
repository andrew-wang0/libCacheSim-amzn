FROM ubuntu:22.04 AS builder
RUN apt-get update && apt-get install -y build-essential cmake git libglib2.0-dev libgoogle-perftools-dev libzstd-dev && rm -rf /var/lib/apt/lists/*

# Run from remote repository source
# RUN git clone https://github.com/andrew-wang0/libCacheSim-amzn.git /src && mkdir /src/_build && cd /src/_build && cmake .. && make -j$(nproc) && make install

# Run from local source
WORKDIR /src
COPY . .
RUN mkdir build && cd build \
  && cmake .. \
  && make -j$(nproc) \
  && make install

FROM ubuntu:22.04
RUN apt-get update && apt-get install -y libglib2.0-0 libgoogle-perftools4 libzstd1 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/bin/cachesim /usr/local/bin/
COPY --from=builder /usr/local/lib/libCacheSim.* /usr/local/lib/
ENV LD_LIBRARY_PATH=/usr/local/lib
ENTRYPOINT ["cachesim"]
CMD ["--help"]
