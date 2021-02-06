# O projeto Cerberus
Este projeto é uma API cuja finalidade é autorizar ou revogar acessos as funcionalidades dos produtos. Toda estrutura criada passa pela relação de diversas entidades: Cliente, Usuário, Produto, Contrato, Papéis e Funcionalidades. As estruturas lógicas e regras de negócio serão documentadas em breve.

O projeto **Cerberus** foi criado pensando no idioma inglês, não por conta de ter mais "abrangência" ou ter mais "aceitação" em uma ou outra comunidade, mas sim foi escolhido o idioma inglês apenas para contribuir no aprendizado do criador do projeto neste idioma em projetos técnicos. Há outros projetos deste autor que estão em português seja por comodidade do criador seja pela intenção de ser mais inclusivo com os falantes do português brasileiro.

## Por que foi escolhido o nome Cerberus?
> **Cérbero** (em grego clássico: Κέρβερος; romaniz.: Kerberos – trad.: “demónio do poço”; em latim: Cerberus), na mitologia grega, era um monstruoso cão de três cabeças que guardava a entrada do mundo inferior, o reino subterrâneo dos mortos, deixando as almas entrarem, mas jamais saírem e despedaçando os mortais que por lá se aventurassem. - [Wikipedia](https://pt.wikipedia.org/wiki/C%C3%A9rbero).

Escolhi o nome **Cerberus**, por se tratar de guardar algo, no caso a "entrada do mundo inferior" que para este projeto pode significar o acesso a alguma funcionalidade. Sendo assim, podemos afirmar que este projeto guarda a entrada das funcionalidade de um produto.

# Como desenvolver

## Dependências
Este projeto foi pensado na maior independência possível do sistema operacional e suas bibliotecas, portanto preferi criá-lo apenas com a dependência dos contêineres docker. Sendo assim, é necessário para desenvolver os seguintes recursos:

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Conjunto tecnológico

- **Banco de dados**: [Postgresql 12](https://www.postgresql.org/)
- **Linguagem de programação**: [Ruby 2.7](https://ruby-doc.org/core-2.7.0/)
- **API Framework**: [Rails 6](https://guides.rubyonrails.org/)

## Início rápido - *Veja a aplicação funcionando*

1. Construir todos os contêineres: ```docker-compose build```

2. Iniciando o contêiner da aplicação (*development*): ```docker-compose up development```

3. **Pronto!**. Você já pode acessar sua aplicação através de http://localhost:3000.

## Entendendo e usando o ambiente de desenvolvendo

### Os Contêineres

Este projeto disponibiliza quatro contêineres docker:

- **database**: Contêiner que fornece duas instância DE banco de dados Postgresql: **postgres_dev** (para desenvolvimento) e **postgres_test** (para execução de testes)
- **development**: Contêiner que executa a API. Ele depende do contêiner *database*.
- **test**: Contêiner que executa testes e analisador de código. Ele depende do contêiner *database*.
- **apiblueprint**: Contêiner que executa o servidor de documentação de API em formato blueprint.

| Serviços         | Depende do serviço | Objetivos                                                                                                |
|------------------|--------------------|----------------------------------------------------------------------------------------------------------|
| **database**     |                    | Disponibilizar o banco de dados PostgreSQL                                                               |
| **development**  | database           | Executar o servidor da API                                                                               |
| **test**         | database           | Disponibilizar ambiente para realizar a execução de testes e analisador de estilização de código         |
| **apiblueprint** |                    | Cria e executa o servidor de documentação da API, que pode ser executado para simular requisições na API |

Mais informações sobre *parar*, *iniciar*, *reiniciar*, *executar* contêineres e mais, leia a [Documentação do Docker Compose](https://docs.docker.com/compose/) e a [Documentação do Docker](https://docs.docker.com/).

### Construindo os Contêineres

Para contruir todos os contêineres basta executar o seguindo comando:

```bash
docker-compose build
```

Caso queira construir apenas um contêiner, execute:

```bash
docker-compose build <name-do-contêiner>
```

### Iniciando a API

Para iniciar a API você deve executar o comando:
```bash
docker-compose up development
```

Ao iniciar o contêiner de execução da API (**development**) as seguintes ações são executadas:
- Criação da estrutura do bancos de dados (*migrations*)
- Execução do servidor Web

**Pronto!**. Você já pode acessar sua aplicação acessando http://localhost:3000.

### Executando testes e executando o analisador de código

Este projeto usa um contêiner exclusivo para a execução de testes e analisador de código, que é o contêiner **test**. Para construir o contêiner de testes, execute:

```bash
docker-compose up test
```

Ao criar o contêiner **test** toda estrutura do bancos de dados (*migrations*) será criada.

Execute todos os testes com o seguinte comando:

```bash
docker-compose run --rm test rails test
```

Para executar testes de apenas um arquivo, você deve informar o arquivo no final do comando.

```bash
docker-compose run --rm rails test spec/services/candidatos_service_spec.rb
```

Analize todo o código com o [Rubocop](https://github.com/rubocop-hq/rubocop) executando:

```bash
docker-compose run --rm test rubocop
```

Para analisar o código apenas de um arquivo, você deve informar o arquivo no final do comando.

```bash
docker-compose run --rm test rubocop app/services/candidatos_service.rb
```

#### Dicas
Em todas as execuções acima, um novo container é criado para executar os testes e no fim da execução este container é removido.

Ainda há a opção de utilizar o contêiner de testes como se fosse uma máquina local, assim bastaria ingressar nela, realizar as execuções de interesse e sair quando achar necessário:

- Ingressar no contêiner: ```docker-compose run --rm test sh```
- Executar testes de dentro do contêiner: ```rails test```
- Executar analisador de código: ```rails rubocop```
- Sair do contêiner: ```exit```

### Criando dados de exemplo

Se você precisar inserir alguns dados de exemplo no banco de dados, você pode usar a *rake task* **seed** através do comando abaixo.

```bash
docker-compose run --rm development rails db:seed
```

### Executando migração de banco de dados

Se você precisar executar a migração de bando de dados, você deve usar a *rake task* **migrate** do banco de dado através do comando abaixo.

```bash
docker-compose run --rm development rails db:migrate
```

## Informações adicionais
- O *Dockerfile* contendo a linguagem Ruby foi obtido no repositório oficial no [DockerHub](https://hub.docker.com/): [Ruby Dockerfile](https://hub.docker.com/_/ruby/)
- O *Dockerfile* para PostgreSQL foi obtido no repositório oficial no [DockerHub](https://hub.docker.com/): [Postgresql Dockerfile](https://hub.docker.com/_/postgres/)
- O script para a criação de mútiplos *databases* no PostgreSQL foi obtido no repositório [docker-postgresql-multiple-databases](https://github.com/mrts/docker-postgresql-multiple-databases) do [Github](https://github.com)
