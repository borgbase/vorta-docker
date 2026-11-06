# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.24-v4

RUN apk upgrade --no-cache
RUN add-pkg openssh-client rsync fuse python3 py3-pip py3-qt6 zstd-libs lz4-libs openssl \
    qt6-qtbase py3-bcrypt py3-pynacl py3-peewee py3-psutil py3-wheel py3-cryptography fuse3 fuse3-libs \
    mesa-dri-gallium font-croscore py3-platformdirs libxxhash firefox-esr 
    ## Buld requirements which are deleted in same transaction so they don't impact image
    ## Vorta 0.12 requires pyqt3 newer that what is in alpine 3.24. Tried building pyqt6 from source but it was a nightmare. So instead use older version.
RUN add-pkg --virtual build-dependencies py3-pkgconfig python3-dev openssl-dev zstd-dev acl-dev lz4-dev build-base qt6-qtbase-dev fuse-dev fuse3-dev xxhash-dev && \ 
    pip3 install --break-system-packages  borgbackup pyfuse3 && \
    pip3 install --break-system-packages --no-deps vorta && \
    del-pkg build-dependencies

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
