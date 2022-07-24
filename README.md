# Vorta-Docker

Run Vorta from Docker.
Currently using Vorta 0.8.7 release

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

## Environment Variables

Some environment variables can be set to customize the behavior of the container
and its application.  The following list give more details about them.

Environment variables can be set in your `docker-compose.yamml` via the `env_file` or `environment`
keys or by adding one or more arguments `-e "<VAR>=<VALUE>"` to the `docker run` command.

| Variable       | Description                                  | Default |
|----------------|----------------------------------------------|---------|
|`APP_NAME`| Name of the application. | `DockerApp` |
|`USER_ID`| ID of the user the application runs as.  See [User/Group IDs](#usergroup-ids) to better understand when this should be set. | `1000` |
|`GROUP_ID`| ID of the group the application runs as.  See [User/Group IDs](#usergroup-ids) to better understand when this should be set. | `1000` |
|`SUP_GROUP_IDS`| Comma-separated list of supplementary group IDs of the application. | (unset) |
|`UMASK`| Mask that controls how file permissions are set for newly created files. The value of the mask is in octal notation.  By default, this variable is not set and the default umask of `022` is used, meaning that newly created files are readable by everyone, but only writable by the owner. See the following online umask calculator: http://wintelguy.com/umask-calc.pl | (unset) |
|`TZ`| [TimeZone] of the container.  Timezone can also be set by mapping `/etc/localtime` between the host and the container. | `Etc/UTC` |
|`KEEP_APP_RUNNING`| When set to `1`, the application will be automatically restarted if it crashes or if a user quits it. | `0` |
|`APP_NICENESS`| Priority at which the application should run.  A niceness value of -20 is the highest priority and 19 is the lowest priority.  By default, niceness is not set, meaning that the default niceness of 0 is used.  **NOTE**: A negative niceness (priority increase) requires additional permissions.  In this case, the container should be run with the docker option `--cap-add=SYS_NICE`. | (unset) |
|`TAKE_CONFIG_OWNERSHIP`| When set to `1`, owner and group of `/config` (including all its files and subfolders) are automatically set during container startup to `USER_ID` and `GROUP_ID` respectively. | `1` |
|`CLEAN_TMP_DIR`| When set to `1`, all files in the `/tmp` directory are deleted during the container startup. | `1` |
|`DISPLAY_WIDTH`| Width (in pixels) of the application's window. | `1280` |
|`DISPLAY_HEIGHT`| Height (in pixels) of the application's window. | `768` |
|`SECURE_CONNECTION`| When set to `1`, an encrypted connection is used to access the application's GUI (either via a web browser or VNC client).  See the [Security](#security) section for more details. | `0` |
|`VNC_PASSWORD`| Password needed to connect to the application's GUI.  See the [VNC Password](#vnc-password) section for more details. | (unset) |
|`X11VNC_EXTRA_OPTS`| Extra options to pass to the x11vnc server running in the Docker container.  **WARNING**: For advanced users. Do not use unless you know what you are doing. | (unset) |
|`ENABLE_CJK_FONT`| When set to `1`, open-source computer font `WenQuanYi Zen Hei` is installed.  This font contains a large range of Chinese/Japanese/Korean characters. | `0` |

See also the base container [README.md](https://github.com/jlesage/docker-baseimage-gui/blob/master/README.md)

## Discussion and Support
- Open a Github issue
- [Unraid Forum](https://forums.unraid.net/topic/117021-support-smartphonelover-vorta-gui-for-borg-backup/)


## License and Credits

- [@Ranbato](https://github.com/Ranbato) (original author and current maintainer)
- Licensed under [GPLv3](LICENSE.txt)
