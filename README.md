# Heatcheck

## Getting Started

### Prerequisites

- [Ruby](https://www.ruby-lang.org/en/): we recommend using
  [rbenv](https://github.com/rbenv/rbenv) to install the Ruby versions. This project uses Ruby 2.6.1
- [Yarn](https://yarnpkg.com/) 1.x: please refer to their
  [installation guide](https://classic.yarnpkg.com/en/docs/install).
- [PostgreSQL](https://www.postgresql.org/) 9.2 or higher.
- [Redis](https://redis.io/) 4 or higher.

### Setup your development environment

1. Clone this repo
2. Run `bin/setup`
3. Start the app with `bin/dev`

### Environment variables

- `APP_HOST` - contains your host
- `INTERCOM_APP_ID` - in case of integration to Intercom should contain [Intercom App ID](https://www.intercom.com/help/en/articles/3539-where-can-i-find-my-workspace-id-app-id).
- `NON_ACTIVE_USERS_REDIRECT_URL` - if this variable is set all non-activated users will be redirected to this URL after login
- `WEBHOOK_TOKEN` - This is used for authorization on webhook requests. You can find the detailed information about them below.

## Webhooks

Authorization:

Each request on webhook requires authorization. It could be done by sending `WEBHOOK-TOKEN` with each HTTP(-s) request in headers.

We have two endpoints for webhook calls:

1. `/webhooks/signup` - for signing up new users

This endpoint allow to pass `data` JSON object with the fields:
- `email` - email of the user for sign up
- `first_name` (optional) - first name of the user for sign up
- `last_name` (optional) - last name of the user for sign up

After the request the user will get email with the request to set their password.

2. `/webhooks/activation` - for activating users.

This endpoint allow to pass `data` JSON object with the fields:
- `email` - email of the user you want to activate/deactivate
- `action` - this could be either `activate` or `deactivate` depends on the action you want to be done.

Answer on all webhooks requests will contain the data object of the signed up user.
