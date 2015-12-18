# CiberMangekamp

## Installasjon
1. Installer Ruby 2.2
 * Anbefaler enten RVM
1. Installer Gem
 * Følger med RVM
1. Installer Bundle
 * `gem install bundler`
1. Kjør `bundle` i repoet
1. Installer PostgreSQL
 * Sjekk internett
1. Lag databasen med `rake db:create`
1. Kjør migreringer `rake db:migrate`
1. Start server med `rails server`
1. Success?

## PostgreSQL database
Vi bruker PostgreSQL som database, så det må du ha installert lokalt, eller mulighet til å koble deg til en eksternt.
Informasjonen blir hentet fra miljøvariabelen `ENV['DATABASE_URL']`. Hvis den ikke finner den, bruker den et standard oppsett som er `postgres://postgres:postgres@localhost/mangekamp:postgres`. Der `mangekamp` er navnet på databasen, og `postgres` er passordet.
