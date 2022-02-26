# Vorta-Docker

Run Vorta from Docker.

## Usage

Using `docker-compose.yml`: (set TZ, USER_ID, and GROUP_ID in `.env`.)
```
vorta:
    image: ghcr.io/borgbase/vorta-docker:latest
    container_name: vorta
    hostname: storage-vorta
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

## Discussion and Support

- [Unraid Forum](https://forums.unraid.net/topic/117021-support-smartphonelover-vorta-gui-for-borg-backup/)
- Open a Github issue


## License and Credits

- [@Ranbato](https://github.com/Ranbato) (original author and current maintainer)
- Licensed under [GPLv3](LICENSE.txt)
