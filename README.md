# PostgreSQL Projects & Scripts

This repository contains several PostgreSQL-related SQL scripts and a Docker Compose configuration for running a PostgreSQL instance locally. The files included are:

- **Postgresql.sql**: An SQL script for the first PostgreSQL assignment. This file likely includes queries, schema definitions, and other instructions related to the assignment.
- **contacts_postgres.sql**: An SQL script that sets up or manages a contacts database.
- **university_postgres_backup.sql**: A backup of a university PostgreSQL database, which can be restored to recover the database state.
- **docker-compose.yml**: A Docker Compose file that sets up a PostgreSQL container. It defines the service configuration, ports, environment variables, and volume for data persistence.

## Setup Instructions

### Using Docker Compose to Run PostgreSQL

1. **Prerequisites:**
   - Ensure you have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed.
   - Verify that port `5432` is available on your machine.

2. **Starting the PostgreSQL Container:**
   - Open a terminal in the repository directory.
   - Run the following command to start the container in detached mode:
     ```bash
     docker-compose up -d
     ```
   - This command uses the configuration in `docker-compose.yml` to pull the latest PostgreSQL image and start a container named `postgres_db_container`.

3. **Container Configuration Details:**
   - **Image:** `postgres:latest`
   - **Container Name:** `postgres_db_container`
   - **Ports:** Exposes PostgreSQL on `5432`
   - **Environment Variables:**
     - `POSTGRES_PASSWORD=UVUCS3520D4t4Th30ry!`
     - `POSTGRES_DB=postgres`
   - **Volumes:** Persists data in a Docker volume named `postgres_db_data_container`  

### Running the SQL Scripts

After the PostgreSQL container is running, you can execute the SQL scripts to set up or restore databases.

#### Option 1: Using the Command Line (psql)

1. **Connect to the PostgreSQL instance:**
   ```bash
   psql -h localhost -U postgres -d postgres
   ```
   - **Host:** `localhost`
   - **Port:** `5432`
   - **Database:** `postgres`
   - **User:** `postgres`
   - **Password:** `UVUCS3520D4t4Th30ry!`

2. **Execute a SQL script:**
   ```sql
   \i /path/to/Assignment\ #1\ -\ Postgresql.sql
   ```
   Replace the file path with the actual location of the script you wish to run (e.g., `contacts_postgres.sql` or `university_postgres_backup.sql`).

#### Option 2: Using a GUI Tool

- Connect to your PostgreSQL instance using a tool like [pgAdmin](https://www.pgadmin.org/) or [DBeaver](https://dbeaver.io/).
- Use the connection settings mentioned above.
- Open the desired SQL script file and run it within the tool.

## Additional Notes

- **Container Restart:** The Docker Compose configuration is set to always restart the PostgreSQL container.
- **Default User:** Since `POSTGRES_USER` is commented out in the `docker-compose.yml`, the default user `postgres` is used.
- **Script Usage:** The provided SQL scripts are intended for educational or developmental purposes. Always test in a safe environment before running on production systems.

---
