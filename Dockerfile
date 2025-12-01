##############################################
# 1️⃣ STAGE : TESTS (avec BATS)
##############################################
FROM ubuntu:22.04 AS tests

ENV DEBIAN_FRONTEND=noninteractive

# Installer Bats + dépendances nécessaires
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bats \
        bash \
        procps \
        coreutils \
        gawk \
        sed \
        util-linux && \
    rm -rf /var/lib/apt/lists/*

# Copier les scripts et tests
COPY sysinfo.sh /usr/local/bin/sysinfo.sh
COPY lib/ /usr/local/lib/sysinfo-lib/
COPY tests/ /tests/

# Rendre le script exécutable
RUN chmod +x /usr/local/bin/sysinfo.sh

# Commande exécutée lors des tests
CMD ["bats", "/tests/sysinfo.bats"]


##############################################
# 2️⃣ STAGE : FINAL (IMAGE POUR LA PROD)
##############################################
FROM ubuntu:22.04 AS final

ENV DEBIAN_FRONTEND=noninteractive

# Installer le strict minimum
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        procps \
        coreutils \
        gawk \
        sed \
        util-linux \
    && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur non-root
RUN useradd -m -s /bin/bash sysinfo

# Copier seulement ce qui est nécessaire en production
COPY sysinfo.sh /usr/local/bin/sysinfo.sh
COPY lib/ /usr/local/lib/sysinfo-lib/

# Permissions et sécurité
RUN chmod +x /usr/local/bin/sysinfo.sh && \
    chown -R sysinfo:sysinfo /usr/local/bin/sysinfo.sh /usr/local/lib/sysinfo-lib

# Dossier de travail
WORKDIR /home/sysinfo
RUN mkdir -p logs && chown -R sysinfo:sysinfo logs

# Utilisateur non-root
USER sysinfo

# Commandes par défaut
ENTRYPOINT ["/usr/local/bin/sysinfo.sh"]
CMD ["--all"]
