# Code-server

Based on the Docker image [linuxserver/code-server](https://hub.docker.com/r/linuxserver/code-server). The purpose is to run at Code Server with PHP8.3 and extensions installed.

## System requirements

* Docker installation with the compose plugin installed (standard with Synology DSM and Docker Desktop)

## Startup

1. Copy docker-compose.env to .env (``cp docker-compose.env.dist .env``)
1. Change .env to suit your setup (``nano .env`` or ``vi .env`` etc.)
1. Start the server by issuing:
``docker compose up -d``
1. You may edit .env for new values, and run ``docker compose up -d`` afterwards to enable the changes.

## Environment variables in docker-compose.env.dist

| Name | Description |Default |
| ----------- | ----------- | ----------- |
| PORT | Host-side TCP port for communicating with Code Server | 8480 |
| PUID | UID for the user running the code server. The UID can be found by running ``id <username>``. The default reflects the macOS main user | 501 |
| PGID | Group ID to use when storing files. Default is the "staff" group i macOS | 20 |
| TZ | The time zone that the container should use | Europe/Oslo |
| PASSWORD | Login password for the code-server |  |
| PASSWORD_HASH | Encrypted version of the password. Overrides PASSWORD when set | |
| SUDO_PASSWORD | Password for the sudo command inside the Code Server terminal |  |
| SUDO_PASSWORD_HASH | Encrypted sudo password. Overrides SUDO_PASSWORD | |


### How to encrypt the passwords

HASHED_PASSWORD will always include "$". To use it, it must be put inside single-quotes ni .env. For instance: 
```
HASHED_PASSWORD='$argon2i$v=19$m=4096,t=3,p=1$NfW9onhRepXjiGKXbOiLFg$FbIRRjCUVCnyLmT2+TYZq+xtEsBoSEMeweTyruqW8Lw'
SUDO_PASSWORD_HASH='$6$0MspJ/2dKDEMbCbU$gPATj5xac1OLEwxgZPFE8LL0K0mjAFjJ8jG96..C9hqmQ1hpKbP5cnYY/qlv3LuKoYr.Gm.3kUxDq/CMKs1wk/'
```
This sets the password to "passordet", both for Code server and the sudo command. Do not use that…

You may also skip the quotes or use double quotes ("), but in order for the container to read the values correctly, you must replace all "$" in the passwords with "$$".

The following shows you how to build your own encrypted passwords.

#### HASHED_PASSWORD

Run this in Terminal (requires that node is installed):

```
echo -n "passordet" | npx argon2-cli -e
$argon2i$v=19$m=4096,t=3,p=1$NfW9onhRepXjiGKXbOiLFg$FbIRRjCUVCnyLmT2+TYZq+xtEsBoSEMeweTyruqW8Lw
```
Or you can use the argon2 command (``brew install argon2``) - node not required:
```
echo -n "passordet" | argon2 "en eller annen salt-kode" -e
$argon2i$v=19$m=4096,t=3,p=1$ZW4gZWxsZXIgYW5uZW4gc2FsdC1rb2Rl$PdEpxNnNoDwO2/kTZR5mXYXTiE69xImVmUqNvGrwYQ4
```

The last line is the encrypted password. The two examples are different, even though it is the same password. This is because the metods use different salt codes.

### SUDO_PASSWORD_HASH

The sudo password is a SHA512 encrypted password. It is simple to create with openssl:
```
openssl passwd -6 "passordet"
$6$0MspJ/2dKDEMbCbU$gPATj5xac1OLEwxgZPFE8LL0K0mjAFjJ8jG96..C9hqmQ1hpKbP5cnYY/qlv3LuKoYr.Gm.3kUxDq/CMKs1wk/
```
Once again, the password (the last line above) must be placed in single-quotes in the .env file. 

## License

This project is published as open source with the [MIT License](LICENSE).
