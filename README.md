<p align="center">
  <img src="assets/logos/appflowy_logo.svg"  width="500" height="200" />
</p>

<h4 align="center">
   <a href="https://discord.gg/9Q2xaN37tV"><img src="https://img.shields.io/badge/AppFlowy.IO-discord-orange"></a>
    <a href="https://opensource.org/licenses/AGPL-3.0"><img src="https://img.shields.io/badge/license-AGPL-purple.svg" alt="License: AGPL"></a>
</h4>


<p align="center">
    <a href="https://www.appflowy.io"><b>Website</b></a> •
    <a href="https://twitter.com/appflowy"><b>Twitter</b></a>
</p>

<p align="center">⚡ The AppFlowy Cloud written with Rust 🦀</p>

# Documented process

1. get vps + domain with ssl + get second ssl to plug into vps + openai api key + mailgun acc (domain dns config -> vps and mailgun)
2. created user with sudo powed - logged in with user
3. git cloned /AppFlowy-Cloud
4. installed nginx, docker engine (/etc/nginx/sites-enabled/default deleted)
5. edited deploy.env, docker-compose.yml and /migrations/before/20230312043000_supabase_auth.sql (changed passes, smtp mailgun, google oauth, auto-confirm off, openai api, disabled built-in nginx and unused admin servs such as portainer)
6. configured /etc/nginx/nginx.conf with xternal-nginx.conf
7. cd /AppFlowy-Cloud / cp deploy.env .env / docker compose up -d

# Issues currently facing

1. smtp won't send any mails

# Improvements I'm aiming

1. security - priority
2. have a small ai model to do simple tasks based on lists/notes (eg. combine all the ingredients from @recipe1 @recipe2 and @recipe3 into a single shopping list) - either on-clients-device or something like ollama hosted on another server
3. syncing between user seems a liiiiiiiitle clunky sometimes. can we improve?

#

# 📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦

#

# AppFlowy Cloud

AppFlowy Cloud is part of the AppFlowy ecosystem, offering secure user authentication, file storage,
and real-time WebSocket communication for an efficient and collaborative user experience.

## Table of Contents

- [🚀 Deployment](#-deployment)
- [💻 Development](#-development)
- [🐞 Debugging](#-debugging)
- [⚙️ Contributing](#-contributing)

## 🚀 Deployment

- See [deployment guide](./doc/DEPLOYMENT.md)

## 💻 Development

### Pre-requisites

You'll need to install:

- [Rust](https://www.rust-lang.org/tools/install)
- [Docker](https://docs.docker.com/get-docker/)

### Configuration

- copy the configurations from `dev.env` to `.env`
- edit the `.env` as required (such as SMTP configurations)

### Run with all dependencies

```bash
./script/run_local_server.sh
```

This process will execute all the dependencies and start the AppFlowy-Cloud server. Alternatively,
you have the option to run the AppFlowy-Cloud server independently

### Run the AppFlowy-Cloud

1. Run the dependency servers

```bash
docker compose --file docker-compose-dev.yml up -d
```

2. Install sqlx-cli

```bash
cargo install sqlx-cli
```

3. Run sqlx migration

```bash
sqlx database create
sqlx migrate run
cargo sqlx prepare --workspace
```

4. Run the server

```bash
cargo run
```

### Run the tests

After the server is running, you can run the tests with:

```bash
cargo test
```

## 🐞Debugging

Effective debugging is essential for maintaining a healthy application. Here are some tools and commands to help you
troubleshoot issues in various components of the AppFlowy cloud server:

### Postgres

A web-based administration tool for PostgreSQL. Access it at [PgAdmin](http://localhost:5400)

- OR command line:

```bash
    export PGPASSWORD=password
    psql --host=localhost --username=postgres --port=5432
```

- Redis

Redis offers a powerful command line interface for managing your Redis instance. Connect using the following command:

```bash
    redis-cli -p 6379
```

### Minio

Minio provides a Web UI for easy management of your files and buckets. Access it at [Web UI](http://localhost:9001)

### Portainer

For managing Docker containers, Portainer's Web UI is an excellent tool. Access it at Web UI to easily manage Docker
environments, including container deployment, networking, volume management, and more. Access it
at [Web UI](http://localhost:9442)

## ⚙️ Contributing

Any new contribution is more than welcome in this project!
If you want to know more about the development workflow or want to contribute, please visit
our [contributing guidelines](./doc/CONTRIBUTING.md) for detailed instructions!
