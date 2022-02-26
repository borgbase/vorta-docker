# Vorta-Docker

Run Vorta from Docker.

## Usage

Use the following `docker-compose.yml` and set TZ, USER_ID, and GROUP_ID in `.env`.

```
vorta:
    image: marklambert/vorta
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

## Discussion and Support

- [Unraid Forum](https://forums.unraid.net/topic/117021-support-smartphonelover-vorta-gui-for-borg-backup/)
- Open a Github issue


## License and Credits

- [@Ranbato](https://github.com/Ranbato) (original author and current maintainer)
- Licensed under [GPLv3](LICENSE.txt)
