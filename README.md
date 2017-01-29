# README

* Requires Ruby 2.3

* Requires Perl, Docker and Docker-Compose

* Configuration is mostly handled via environment variables (.env file)

* Database creation is handled via `./dc ws_bash` on the host followed by `rails db:create` in the container

* Database initialization is handled via `./dc ws_bash` on the host followed by `rails db:migrate` in the container

* Test suite is run via `./dc ws_bash` on the host followed by `rails test` in the container

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
