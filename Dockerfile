###########################
# 1️⃣ Build stage
###########################
FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y bash coreutils

WORKDIR /app

COPY sysinfo.sh .
COPY lib ./lib

###########################
# 2️⃣ Test stage
###########################
FROM builder AS tests

RUN apt-get update && apt-get install -y bats

COPY tests ./tests

# Lancer les tests BATS au build
RUN bats tests || (echo "❌ Tests FAILED" && exit 1)

###########################
# 3️⃣ Final minimal image
###########################
FROM ubuntu:22.04

RUN mkdir -p /usr/local/bin \
    && mkdir -p /usr/local/lib/sysinfo-lib

COPY --from=builder /app/sysinfo.sh /usr/local/bin/sysinfo
COPY --from=builder /app/lib /usr/local/lib/sysinfo-lib

RUN chmod +x /usr/local/bin/sysinfo

ENTRYPOINT ["/usr/local/bin/sysinfo"]