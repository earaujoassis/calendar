# Calendar

> Rails calendar application

## Local development

Setup a local development enviroment through the following instructions:

1. Please make sure to install Ruby 2.7.2+
2. Install `bundler` and `rails` through the following command: `gem install rails bundler`
3. Install project dependencies: `bundle install`
4. Provide a PostgreSQL server for local development (PostgreSQL 13.x)
5. Test your local environment through the following command: `bin/rails db:create db:migrate db:seed && bin/rails test`
6. The server can be started through the following command: `bin/rails server`

## Deployment through Docker

This project can be deployed through a Docker container. To test it locally, follow these instructions:

1. Please make sure to install Docker and docker-compose
2. Build the image and provide the essential services through docker-compose: `docker-compose up --build`
3. Please make sure to provide a `CALENDAR_DATABASE_URL` while deploying the containerized solution (check `docker-compose.yml` as a reference)

## API Documentation

This application provides a REST API for Calendar management. It exposes the following endpoints:

### 1. Endpoint to create Calendar event

`POST /events`

Request body (`application/json`) for annually recurring events

```json
{
    "event": {
        "name": "Christmas",
        "day": 25,
        "month": 12
    }
}
```

Request body (`application/json`) for single events

```json
{
    "event": {
        "name": "Meeting",
        "day": 10,
        "month": 4,
        "year": 2022
    }
}
```

Example:

```sh
$ curl -X POST -H "Content-Type: application/json" \
    -d '{"event": { "name": "Christmas", "day": 25, "month": 12 } }' \
    http://localhost:3000/events
```

> `{"id":1}`


```sh
$ curl -X POST -H "Content-Type: application/json" \
    -d '{"event": { "name": "Meeting", "day": 10, "month": 4, "year": 2022 } }' \
    http://localhost:3000/events
```

> `{"id":1}`


### 2. Endpoint to retrieve Calendar events

`GET /events`

Query parameters:

- `day` (required): event day
- `month` (required): event month
- `year` (required): event year

Response body format (`application/json`):

```json
{
    "total_events": 1,
    "events": [
        {
            "name": "Meeting"
        }
    ]
}
```

Example, given the entries above:

```sh
$ curl http://localhost:3000/events\?day\[\]=10\&month\[\]=4\&year\[\]=2022
```

> `{"total_records":1,"event":[{"name":"Meeting"}]}`

## Limitations

- It is possible to create the same event for the same day
- The calendar is not handling timezones, since we're not working with time ranges

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Carlos Assis
