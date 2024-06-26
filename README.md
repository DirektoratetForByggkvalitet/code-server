# Code-server

[In English](README.en.md)

Basert på [linuxserver/code-server](https://hub.docker.com/r/linuxserver/code-server). Installerer PHP 8.3 med extensions og composer, samt nodejs, ved oppstart.

Opprinnelig bygd for å kjøre som et prosjekt på Synology DSM, men fungerer også på maskiner.

## Systemkrav

* Docker med docker compose plugin installert (standard i Synology DSM og med Docker Desktop)

## Oppstart

1. Kopiér docker-compose.env til .env (``cp docker-compose.env.dist .env``)
1. Endre .env hvis du ønsker å bruke andre verdier enn det som står der (``nano .env`` eller ``vi .env`` el.l.)
1. Sett opp prosjektet ved å kjøre følgende kommando:
``docker compose up -d``
1. Hvis du trenger å endre noe i .env er det bare å kjøre ``docker compose up -d`` igjen etterpå.

## Variabler satt i docker-compose.env

| Navn | Beskrivelse | Standard |
| ----------- | ----------- | ----------- |
| PORT | TCP-porten som skal brukes for å kommunisere med code-server | 8480 |
| PUID | UID for brukeren som code-server kjører som. Finn ID ved å bruke kommandoen 'id' for brukeren | 501 |
| PGID | gruppe-ID som code-server skal benytte | 20 |
| TZ | Tidssonen som skal brukes | Europe/Oslo |
| PASSWORD | Passord for å logge inn på code-server |  |
| PASSWORD_HASH | Passordet i kryptert form. Overstyrer PASSWORD | |
| SUDO_PASSWORD | Ukryptert passord for sudo i code-server sin terminal |  |
| SUDO_PASSWORD_HASH | Kryptert passord for sudo. Overstyrer SUDO_PASSWORD | |


### Hvordan kryptere passordene

de krypterte passordene inneholder "$". Da må man putte passordet inni en single-quote i .env-fila. For eksempel: 
```
HASHED_PASSWORD='$argon2i$v=19$m=4096,t=3,p=1$NfW9onhRepXjiGKXbOiLFg$FbIRRjCUVCnyLmT2+TYZq+xtEsBoSEMeweTyruqW8Lw'
SUDO_PASSWORD_HASH='$6$0MspJ/2dKDEMbCbU$gPATj5xac1OLEwxgZPFE8LL0K0mjAFjJ8jG96..C9hqmQ1hpKbP5cnYY/qlv3LuKoYr.Gm.3kUxDq/CMKs1wk/'
```
Linjene over vil sette passordet til "passordet", både for code-server og sudo-kommandoen. Ikke bruk det.

Under følger beskrivelser for hvordan man krypterer passordene for de to verdiene.

#### HASHED_PASSWORD

Kjør følgende kommando i en Terminal (med node installert):

```
echo -n "passordet" | npx argon2-cli -e
$argon2i$v=19$m=4096,t=3,p=1$NfW9onhRepXjiGKXbOiLFg$FbIRRjCUVCnyLmT2+TYZq+xtEsBoSEMeweTyruqW8Lw
```
Eller du kan bruke argon2-kommandoen (``brew install argon2``):
```
echo -n "passordet" | argon2 "en eller annen salt-kode" -e
$argon2i$v=19$m=4096,t=3,p=1$ZW4gZWxsZXIgYW5uZW4gc2FsdC1rb2Rl$PdEpxNnNoDwO2/kTZR5mXYXTiE69xImVmUqNvGrwYQ4
```

Den siste linja er det krypterte passordet. Merk at de krypterte passordene er ulike, selv om det er det samme passordet. Det skyldes at de bruker forskjellige "salt-koder".

### Hvordan sette SUDO_PASSWORD_HASH

For sudo-passordet må man ha et SHA512-kryptert passord. Det er enkelt å opprette ved å kjøre følgende kommando:
```
openssl passwd -6 "passordet"
$6$0MspJ/2dKDEMbCbU$gPATj5xac1OLEwxgZPFE8LL0K0mjAFjJ8jG96..C9hqmQ1hpKbP5cnYY/qlv3LuKoYr.Gm.3kUxDq/CMKs1wk/
```
Det krypterte passordet er altså den siste linja. Husk bare å legge det inni en single-quote-blokk når du legger det inn i .env. Det er også mulig å hoppe over single-quote, men da må du erstatte alle "$" med "$$"

## Lisens

Dette prosjektet publiseres som åpen kildekode lisensiert under [MIT License](LICENSE.md).
