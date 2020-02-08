# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Run database in development:
```
docker run --name pi-control-postgres -p 5433:5432 -e POSTGRES_PASSWORD/mysecretpassword -d postgres:11.6
```

bundle install, without production gems because we can only compile `dht-sensor-ffi` on the RPi
```
bundle install --without production
```
