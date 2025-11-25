# 1 - Base de l’image
FROM ubuntu:22.04

# 2 - Evite les questions interactives
ENV DEBIAN_FRONTEND=noninteractive

# 3 - Installer uniquement le nécessaire
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        bash \
        procps \
        coreutils \
        gawk \
        sed \
        util-linux \
    && rm -rf /var/lib/apt/lists/*

# 4 - Créer un utilisateur dédié (bonne pratique sécurité)
RUN useradd -m -s /bin/bash sysinfo

# 5 - Copier les scripts
COPY sysinfo.sh /usr/local/bin/sysinfo.sh
COPY lib/ /usr/local/lib/sysinfo-lib/

# 6 - Donner les droits + rendre exécutables
RUN chmod +x /usr/local/bin/sysinfo.sh && \
    chown -R sysinfo:sysinfo /usr/local/bin/sysinfo.sh /usr/local/lib/sysinfo-lib

# 7 - Dossier de travail
WORKDIR /home/sysinfo
RUN mkdir -p logs && chown -R sysinfo:sysinfo logs

# 8 - changer d’utilisateur (évite de tout faire en root)
USER sysinfo

# 9 - Commande lancée par défaut
ENTRYPOINT ["/usr/local/bin/sysinfo.sh"]
CMD ["--all"]
