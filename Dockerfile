# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.22-v4

RUN apk upgrade --no-cache
RUN add-pkg openssh-client rsync fuse python3 py3-pip py3-qt6 zstd-libs lz4-libs openssl \
    qt6-qtbase py3-bcrypt py3-pynacl py3-peewee py3-psutil py3-wheel py3-cryptography fuse3 fuse3-libs \
    mesa-dri-gallium font-croscore py3-platformdirs libxxhash firefox-esr
    ## Buld requirements which are deleted in same transaction so they don't impact image
RUN add-pkg --virtual build-dependencies py3-pkgconfig python3-dev py3-virtualenv openssl-dev zstd-dev acl-dev lz4-dev build-base qt6-qtbase-dev fuse-dev fuse3-dev xxhash-dev
RUN    pip3 install --break-system-packages borgbackup vorta pyfuse3 
RUN    del-pkg build-dependencies

# Copy the start script and force permissions just in case
COPY --chmod=755 rootfs/ /

# don't run as root
ENV USER_ID=10
ENV GROUP_ID=1000
ENV TZ=America/Denver

#Niceties
ENV APP_NICENESS=19

# Set the name of the application.
ENV APP_NAME="vorta"
