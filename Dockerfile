# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.15

RUN apk upgrade --no-cache
RUN add-pkg openssh-client rsync fuse python3 py3-pip py3-qt5 zstd-libs lz4-libs libacl openssl qt5-qtbase py3-bcrypt py3-pynacl py3-peewee py3-psutil py3-wheel py3-cryptography fuse3 fuse3-libs

## Buld requirements which are deleted in same transaction so they don't impact image
RUN add-pkg --virtual build-dependencies python3-dev py3-virtualenv openssl-dev zstd-dev acl-dev lz4-dev build-base qt5-qtbase-dev fuse-dev fuse3-dev && \
    pip3 install pkgconfig &&  \
    pip3 install 'borgbackup[fuse]' vorta pyfuse3 && \
    del-pkg build-dependencies

# Copy the start script.
COPY startapp.sh /startapp.sh
COPY init.sh /etc/cont-init.d/

# don't run as root
ENV USER_ID=1028
ENV GROUP_ID=100
ENV TZ=America/Denver

#Niceties
ENV APP_NICENESS=19

# Set the name of the application.
ENV APP_NAME="Vorta"
