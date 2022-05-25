# Vorta-Docker

Run Vorta from Docker.
Currently using Vorta 0.8.5 release

## Usage

Using `docker-compose.yml`: (set TZ, USER_ID, and GROUP_ID in `.env`.)
```
vorta:
    image: ghcr.io/borgbase/vorta-docker:latest
    container_name: vorta
    hostname: storage-vorta
#    cap_add:
#      - SYS_ADMIN
#    security_opt:
#      - apparmor:unconfined
#    privileged: true    
    volumes:
      - /volume1/config/vorta:/config
      - /volume1:/data:ro
      - /volumeUSB1/:/destination
    ports:
      - 5811:5800
    restart: unless-stopped
    env_file:
      - ./.env
```


Using rootless Podman:
```
$ mkdir config
$ podman run -it --rm -v ./config:/config \
    -p 5900:5900  \
    -e USER_ID=1028 -e GROUP_ID=100 \
    --uidmap=0:1:1028 --uidmap=1028:0:1 --uidmap=1029:1029:64507 \
    ghcr.io/borgbase/vorta-docker:latest
```

## Mounting an Archive
Mounting an archive requires granting the Docker Container elevated permissions.  
It is recommended to only grant these to the container when doing a restore.

First, add the FUSE device to the container using `--device /dev/fuse` on the command line.  This is low risk and can be done at any time.

There are 3 levels of permissions that may need to be granted depending mostly on the kernel version of the underlying OS. See Linux [man capabilities(7)](https://man7.org/linux/man-pages/man7/capabilities.7.html) for details.
- `--cap-add SYS_ADMIN` grants the Docker container access to mount things devices (among other things)
- `--cap-add SYS_ADMIN --security-opt apparmor=unconfined` grants slightly more permissions if required.
- `--privileged` makes the container a *root* superuser that can do **_anything_. DON'T RUN WITH THIS UNLESS RESTORING**

You can mount an archive in Vorta and then exec into your container on the command line with something along the lines of `docker exec -it --user app vorta sh` to access the mounted directory and archive.  It will not be accessible outside the Docker container.


## Discussion and Support

- [Unraid Forum](https://forums.unraid.net/topic/117021-support-smartphonelover-vorta-gui-for-borg-backup/)
- Open a Github issue


## License and Credits

- [@Ranbato](https://github.com/Ranbato) (original author and current maintainer)
- Licensed under [GPLv3](LICENSE.txt)
