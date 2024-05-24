# Code-server

Basert på linuxserver/code-server.

Opprinnelig byg for å kjøre som et prosjekt på Synology DSM, men fungerer også på maskiner

## Systemkrav

* Docker med docker compose plugin installert (standard i Synology DSM og med Docker Desktop)

## Oppstart

1. Kopiér docker-compose.env til .env (``cp docker-compose.env.dist .env``)
1. Endre .env hvis du ønsker å bruke andre verdier enn det som står der (``nano .env`` eller ``vi .env`` el.l.)
1. Sett opp prosjektet ved å kjøre følgende kommando:
``docker compose up -d``
1. Hvis du trenger å endre noe i .env er det ofte enklest å gjenskape hele prosjektet, slik: ``docker compose down; docker compose up -d``

## Variabler satt i docker-compose.env

| Navn | Beskrivelse | Standard |
| ----------- | ----------- | ----------- |
| PORT | TCP-porten som skal brukes for å kommunisere med code-server | 8480 |
| PUID | UID for brukeren som code-server kjører som. Finn ID ved å bruke kommandoen 'id' for brukeren | 501 |
| PGID | gruppe-ID som code-server skal benytte | 20 |
| TZ | Tidssonen som skal brukes | Europe/Oslo |
| PASSWORD | Passord for å komme inn på code-server |  |
| PASSWORD_HASH | Passordet i kryptert form. Overstyrer PASSWORD | |
| SUDO_PASSWORD | Ukryptert passord for sudo |  |
| SUDO_PASSWORD_HASH | Kryptert passord for sudo. Overstyrer SUDO_PASSWORD | |


### Hvordan kryptere passordene?

Kjør følgende kommando i en Terminal (med nodejs installert):

``echo -n "passordet" | npx argon2-cli -e``

Det vil gi et svar som dette:
``$argon2i$v=19$m=4096,t=3,p=1$NfW9onhRepXjiGKXbOiLFg$FbIRRjCUVCnyLmT2+TYZq+xtEsBoSEMeweTyruqW8Lw``

**PS!** Siden passordet inneholder "$" må man putte passordet inni en single-quote i .env-fila. For eksempel: ``HASHED_PASSWORD='$argon2i$v=19$m=4096,t=3,p=1$NfW9onhRepXjiGKXbOiLFg$FbIRRjCUVCnyLmT2+TYZq+xtEsBoSEMeweTyruqW8Lw'``
