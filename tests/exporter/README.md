<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Penpot, verified and packaged by Elestio

[Penpot](https://github.com/penpot/penpot) is the first Open Source design and prototyping platform for product teams.

<img src="https://github.com/elestio-examples/penpot/raw/main/penpot.png" alt="penpot" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/penpot">fully managed Penpot</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you are interested in an open source all-in-one devops platform with the ability to manage git repositories, manage issues, and run continuous integrations.

[![deploy](https://github.com/elestio-examples/penpot/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?soft=penpot)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/penpot.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:8080`

## Docker-compose

Here are some example snippets to help you get started creating a container.

        version: "3.5"

        services:
        penpot-frontend:
            image: "elestio4test/penpot-frontend:${SOFTWARE_VERSION_TAG}"
            restart: always
            ports:
            - 172.17.0.1:8080:80
            volumes:
            - ./penpot_assets_data:/opt/data
            env_file:
            - .env
            depends_on:
            - penpot-backend
            - penpot-exporter
        penpot-backend:
            image: "elestio4test/penpot-backend:${SOFTWARE_VERSION_TAG}"
            restart: always
            volumes:
            - ./penpot_assets_data:/opt/data
            depends_on:
            - penpot-postgres
            - penpot-redis
            env_file:
            - .env
        penpot-exporter:
            image: "elestio4test/penpot-exporter:${SOFTWARE_VERSION_TAG}"
            restart: always
            environment:
            - PENPOT_DOMAIN_WHITE_LIST=${DOMAIN}
            - PENPOT_REDIS_URI=redis://penpot-redis/0
            # Don't touch it; this uses internal docker network to
            # communicate with the frontend.
            - PENPOT_PUBLIC_URI=http://penpot-frontend

        penpot-postgres:
            image: "elestio/postgres:15"
            restart: always
            stop_signal: SIGINT
            environment:
            - POSTGRES_INITDB_ARGS=--data-checksums
            - POSTGRES_DB=penpot
            - POSTGRES_USER=penpot
            - POSTGRES_PASSWORD=${ADMIN_PASSWORD}
            volumes:
            - ./penpot_postgres_data:/var/lib/postgresql/data
            ports:
            - 172.17.0.1:30263:5432
        penpot-redis:
            image: elestio/redis:7.0
            restart: always

        pgadmin4:
            image: dpage/pgadmin4:latest
            restart: always
            environment:
            PGADMIN_DEFAULT_EMAIL: ${ADMIN_EMAIL}
            PGADMIN_DEFAULT_PASSWORD: ${ADMIN_PASSWORD}
            PGADMIN_LISTEN_PORT: 8080
            ports:
            - "172.17.0.1:56590:8080"
            volumes:
            - ./servers.json:/pgadmin4/servers.json



### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
| PAPERLESS_SECRET_KEY |   your_secret   |
|     ADMIN_EMAIL      |  test@mail.com  |
|    ADMIN_PASSWORD    |    password     |
|     PAPERLESS_URL    |    http://url   |

# Maintenance

## Logging

The Elestio Penpot Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/penpot/penpot">Penpot Github repository</a>

- <a target="_blank" href="https://help.penpot.app/technical-guide/getting-started/">Penpot documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/penpot">Elestio/Penpot Github repository</a>
