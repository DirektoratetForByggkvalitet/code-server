## Code-server

Basert på linuxserver/code-server.

Bygd for å kjøre som et prosjekt på Synology DSM.

### Systemkrav

* Docker med docker-compose

### Variabler

| Navn | Beskrivelse | Standard |
| ----------- | ----------- | ----------- |
| PUID | UID for brukeren som code-server kjører som. Finn ID ved å bruke kommandoen 'id' for brukeren | 1000 |
| PGID | GUID som code-server skal benytte | 1000 |
| TZ | Tidssonen som skal brukes | Europe/Oslo |
| PASSWORD | Passord for å komme inn på code-server |  |
| PASSWORD_HASH | Passordet i kryptert form. Overstyres av PASSWORD | |
| SUDO_PASSWORD | Ukryptert passord for sudo |  |
| SUDO_PASSWORD_HASH | Kryptert passord for sudo. Overstyres av SUDO_PASSWORD | |
| PROXY_DOMAIN | Domenenavnet som brukes av reverse proxy for å snakke med code-server | |
| DEFAULT_WORKSPACE | Mappen som skal åpnes av code-server når man kommer inn |

