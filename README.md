# CiberMangekamp

1. Installer Ruby 2.2
2. Installer Gem
3. Kjør `bundle`
4. Installer PostgreSQL
5. Kjør `rake migrate`
6. Start server med `rails server`
7. Success?

## Husk PostgreSQL database
Vi bruker PostgreSQL som database, så det må du ha installert lokalt, eller mulighet til å koble deg til en eksternt.
Informasjonen blir hentet fra miljøvariabelen `ENV['DATABASE_URL']`. Hvis den ikke finner noen bruker den standard oppsett som er `postgres://postgres:postgres@localhost/mangekamp`.
