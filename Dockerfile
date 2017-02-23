FROM alpine:3.4

# Necessary to get newer version with fix for https://bugs.gnupg.org/gnupg/issue2371
# FIXME: remove this once https://bugs.alpinelinux.org/issues/6112 has been resolved.
RUN apk add --update libgpg-error=1.24-r0 --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/

RUN apk add --update curl git openssh-client jq perl gnupg && rm -rf /var/cache/apk/*

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*

ADD scripts/install_git_lfs.sh install_git_lfs.sh
RUN ./install_git_lfs.sh

RUN git config --global user.email "git@localhost" && \
    git config --global user.name "git"

ADD test/ /opt/resource-tests/
RUN /opt/resource-tests/all.sh && \
  rm -rf /tmp/*
