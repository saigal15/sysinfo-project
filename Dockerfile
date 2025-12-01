############
# BASE
############
FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash procps coreutils gawk sed util-linux \
    && rm -rf /var/lib/apt/lists/*

############
# TESTS STAGE
############
FROM base AS tests

# Installer bats
RUN apt-get update && apt-get install -y bats && rm -rf /var/lib/apt/lists/*

# Copier les fichiers nécessaires aux tests
COPY sysinfo.sh /usr/local/bin/sysinfo.sh
COPY lib/ /usr/local/lib/sysinfo-lib/
COPY tests/ /tests/

RUN chmod +x /usr/local/bin/sysinfo.sh

ENTRYPOINT ["bats", "/tests/sysinfo.bats"]

############
# FINAL IMAGE
############
FROM base AS final

RUN useradd -m -s /bin/bash sysinfo

COPY sysinfo.sh /usr/local/bin/sysinfo.sh
COPY lib/ /usr/local/lib/sysinfo-lib/

RUN chmod +x /usr/local/bin/sysinfo.sh \
    && chown -R sysinfo:sysinfo /usr/local

USER sysinfo

WORKDIR /home/sysinfo
RUN mkdir -p logs && chown -R sysinfo:sysinfo logs

ENTRYPOINT ["/usr/local/bin/sysinfo.sh"]
CMD ["--all"]
