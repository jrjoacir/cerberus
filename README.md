> Está documentação também está disponível em [Português do Brasil](README_pt-br.md).
# Cerberus Project
This project is an API whose purpose is to authorize or revoke access to product features. Every structure created involves the relationship of several entities: Clients, Users, Products, Contracts, Roles and Functionalities. Read [Entity Documentation](entity_documentation.md) to get more details about entities, theirs relations and objectives.

The **Cerberus** project was created with the English language in mind, not because it has more "scope" or more "acceptance" in one or another community, but the English language was chosen only to contribute to the learning of the project's creator in this language in technical projects. There are other projects by this author that are in Brazilian Portuguese either for the convenience of the creator or for the intention of being more inclusive with Brazilian Portuguese speakers, my mother language.

## Why was the name Cerberus chosen?
> In Greek mythology, **Cerberus** (/ˈsɜːrbərəs/;[2] Greek: Κέρβερος Kérberos [ˈkerberos]), often referred to as the hound of Hades, is a multi-headed dog that guards the gates of the Underworld to prevent the dead from leaving. He was the offspring of the monsters Echidna and Typhon, and was usually described as having three heads, a serpent for a tail, and snakes protruding from multiple parts of his body. Cerberus is primarily known for his capture by Heracles, one of Heracles' twelve labours. - [Wikipedia](https://en.wikipedia.org/wiki/Cerberus)

I chose the name **Cerberus**, because it is about keeping something, in this case the "gates of the Underworld" which for this project may mean access to some functionality. Therefore, we can say that this project keeps the functionality of a product.

# How to develop

## Dependencies
This project was designed with the greatest possible independence from the operating system and its libraries, so I preferred to create it only with dependence on docker containers. Therefore, it is necessary the following resources to develop:

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Technological stack

- **Database**: [Postgresql 12](https://www.postgresql.org/)
- **Programming language**: [Ruby 2.7](https://ruby-doc.org/core-2.7.0/)
- **API Framework**: [Rails 6](https://guides.rubyonrails.org/)

## Quick start - *See the application working*

1. Build all containers: ```docker-compose build```

2. Starting the application container (*development*): ```docker-compose up development```

3. **Done!**. Now, you can access your application by http://localhost:3000/healthcheck.

## Understanding and using the development environment

### The Containers

This project provides four docker containers:

- **database**: Container that provides two Postgresql database instances: **postgres_dev** (development) and **postgres_test** (tests)
- **development**: Container that runs the API. It depends on the *database* container.
- **test**: Container that runs tests and code analyzer. It depends on the *database* container.
- **apiblueprint**: Container that runs the API documentation server in Blueprint format.

| Services         | Depends on service | Objectives                                                                               |
|------------------|--------------------|------------------------------------------------------------------------------------------|
| **database**     |                    | Make the PostgreSQL database available                                                   |
| **development**  | database           | Run the API server                                                                       |
| **test**         | database           | Provide environment to perform the execution of tests and code  analyzer                 |
| **apiblueprint** |                    | Creates and runs the API documentation server, which can be run to simulate API requests |

More information about *stop*, *start*, *restart*, *run* and other commands, read [Docker Compose Documentation](https://docs.docker.com/compose/) and [Docker Documentation](https://docs.docker.com/).

### Building containers

To build all the containers just run the following command:

```bash
docker-compose build
```

If you want to build only one container, execute:

```bash
docker-compose build <container-name>
```

### Starting the API

To start the API, you must execute the command:
```bash
docker-compose up development
```

When starting the API, the container (**development**) performs the following actions:
- Creates the database structure (*migrations*)
- Runs the Web server

**Done!** Now, you can access your application by http://localhost:3000/healthcheck.

### Running tests and code analyzer

This project uses an exclusive container to execute tests and code analyzer, which is the **test** container. To build the test container, run:

```bash
docker-compose up test
```

When creating the **test** container, the entire database structure (*migrations*) will be created.

Run all tests with the following command:

```bash
docker-compose run --rm test rails test
```

To run tests to just one file, you must enter the filename at the end of the command.

```bash
docker-compose run --rm test rails test test/controllers/clients_controller_test.rb
```

Analyze all the code with [Rubocop](https://github.com/rubocop-hq/rubocop) by running:

```bash
docker-compose run --rm test rubocop
```

To analyze the code for just one file, you must enter the filename at the end of the command.

```bash
docker-compose run --rm test rubocop app/controllers/clients_controller.rb
```

#### Tips
In all of the above commands, a new container is created to run the commands and at the end of the run this container is removed.

There is also the option of using the test container as a local machine, so it would be enough to enter it, perform the executions of interest and leave when you want:

- Enter in the container: ```docker-compose run --rm test sh```
- Run tests from inside the container: ```rails test```
- Run code analyzer: ```rails rubocop```
- Exit from container: ```exit```

### Creating sample data

If you need to insert some sample data into the database, you can use *rake task* **seed** typing the command below.

```bash
docker-compose run --rm development rails db:seed
```

### Performing database migration

If you need to perform the database migration, you must use the *rake task* **migrate** of the database typing the command below.

```bash
docker-compose run --rm development rails db:migrate
```

### Using API Blueprint documentation

This project uses Blueprint format API documentation and you can run the container **apiblueprint** to use it. So, execute:

```bash
docker-compose up apiblueprint
```

and access ```http://localhost:8088/```

The blueprint container will interpret `doc.apib` file and will generate a html file. Then, when you access it, you will be able to read and interact with this documentation. More about Blueprint, visit [api blueprint](https://apiblueprint.org/).

## License
This project is licensed by **GNU General Public License v3.0**.

> Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights.

More about this license access [GNU General Public License v3.0](LICENSE.md).

## Additional Information
- The *Dockerfile* containing the Ruby language was obtained from the official repository on [DockerHub](https://hub.docker.com/): [Ruby Dockerfile](https://hub.docker.com/_/ruby/)
- The *Dockerfile* for PostgreSQL was obtained from the official repository on [DockerHub](https://hub.docker.com/): [Postgresql Dockerfile](https://hub.docker.com/_/postgres/)
- The script for creating multiple *databases* on PostgreSQL was obtained from the [Github](https://github.com) repository [docker-postgresql-multiple-databases](https://github.com/mrts/docker-postgresql-multiple-databases)
