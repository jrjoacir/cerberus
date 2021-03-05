>This documentation is also available in [English](README.md).
# O projeto Cerberus
Este projeto é uma API cuja finalidade é autorizar ou revogar acessos as funcionalidades dos produtos. Toda estrutura criada passa pela relação de diversas entidades: Cliente, Usuário, Produto, Contrato, Papéis e Funcionalidades. Leia a [Documentação de Entidades](entity_documentation_pt-br.md) para ter mais detalhes sobre as entidades, suas relações e objetivos.

O projeto **Cerberus** foi criado pensando no idioma inglês, não por conta de ter mais "abrangência" ou ter mais "aceitação" em uma ou outra comunidade, mas sim foi escolhido o idioma inglês apenas para contribuir no aprendizado do criador do projeto neste idioma em projetos técnicos. Há outros projetos deste autor que estão em português seja por comodidade do criador seja pela intenção de ser mais inclusivo com os falantes do português brasileiro.

## Por que foi escolhido o nome Cerberus?
> **Cérbero** (em grego clássico: Κέρβερος; romaniz.: Kerberos – trad.: “demónio do poço”; em latim: Cerberus), na mitologia grega, era um monstruoso cão de três cabeças que guardava a entrada do mundo inferior, o reino subterrâneo dos mortos, deixando as almas entrarem, mas jamais saírem e despedaçando os mortais que por lá se aventurassem. - [Wikipedia](https://pt.wikipedia.org/wiki/C%C3%A9rbero)

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

3. **Pronto!**. Você já pode acessar sua aplicação através de http://localhost:3000/healthcheck.

## Entendendo e usando o ambiente de desenvolvimento

### Os Contêineres

Este projeto disponibiliza quatro contêineres docker:

- **database**: Contêiner que fornece duas instância de banco de dados Postgresql: **postgres_dev** (para desenvolvimento) e **postgres_test** (para execução de testes)
- **development**: Contêiner que executa a API. Ele depende do contêiner *database*.
- **test**: Contêiner que executa testes e analisador de código. Ele depende do contêiner *database*.
- **apiblueprint**: Contêiner que executa o servidor de documentação de API em formato Blueprint.

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

**Pronto!**. Você já pode acessar sua aplicação acessando http://localhost:3000/healthcheck.

### Executando testes e o analisador de código

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
docker-compose run --rm test rails test test/controllers/clients_controller_test.rb
```

Analise todo o código com o [Rubocop](https://github.com/rubocop-hq/rubocop) executando:

```bash
docker-compose run --rm test rubocop
```

Para analisar o código apenas de um arquivo, você deve informar o arquivo no final do comando.

```bash
docker-compose run --rm test rubocop app/controllers/clients_controller.rb
```

#### Dicas
Em todas as execuções acima, um novo container é criado para executar os comandos e no fim da execução este container é removido.

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

### Usando a documentação de API em Blueprint

Este projeto usa o formato Blueprint para documentar APIs e você pode executar o contêiner **apiblueprint** para usá-lo. Então, execute:

```bash
docker-compose up apiblueprint
```

e acesse ```http://localhost:8088/```

O contêiner blueprint interpretará o arquivo `doc.apib` e gerará um arquivo em html. Então, quando você acessá-lo, você poderá ler e interagir com este documentação. Para mais informação sobre o Blueprint, visite [api blueprint](https://apiblueprint.org/).

# Como criar e publicar uma imagem docker
Decidimos disponibilizar uma imagem docker em [Docker Hub](https://hub.docker.com/) no [Repositório Cerberus](https://hub.docker.com/repository/docker/jrjoacir/cerberus) para ser usado em qualquer ambiente. Então, devemos criar uma imagem docker com a tag correta e distribuí-la no [Repositório Cerberus](https://hub.docker.com/repository/docker/jrjoacir/cerberus).

1. **Criar a imagem docker**
```sh
docker build -f Dockerfile.deploy -t jrjoacir/cerberus:{VERSION} .
```
2. **Logar no Docker Hub**
```sh
docker login -u <user-dockerhub-name>
```
3. **Publicar imagem docker**
```sh
docker push jrjoacir/cerberus:{VERSION}
```

# Como realizar o *deploy*
Disponibilizamos uma imagem docker no [repositório Cerberus](https://hub.docker.com/repository/docker/jrjoacir/cerberus) para executar um contêiner pronto para execução em qualquer ambiente.

## Requisitos
- [Docker](https://docs.docker.com/install/)
- [Banco de dados Postgresql](https://www.postgresql.org/)
- Variáveis de ambiente:

| Variável       | Descrição   |
|----------------|-------------|
| **RAILS_ENV**  | Ambiente onde o contêiner será executado. Opções possíveis: test, development, staging e production |
| **DB_HOST**    | Endereço do banco de dados |
| **DB_NAME**    | *Schema* do banco de dados |
| **DB_USER**    | Usuário do banco de dados. **Dica**: use um usuário de banco de dados para executar a aplicação apenas com acesso de leitura e escrita e apenas utilize um usuário administrador de banco de dados para criar os objetos de banco de dados |
| **DB_PASS**    | Senha do usuário de banco de dados |
| **DB_ADAPTER** | Adaptador de banco de dados usado para o framework Ruby on Rails. No momento, a única opção possível é o adaptador **postgresql** |

## Execute a API Cerberus dentro do contêiner docker
1. **Obtenha a imagem docker do DockerHub**
```sh
docker pull jrjoacir/cerberus:{VERSION}
```
2. **Execute os *migrations* para sincronizar os objetos de banco de dados**
```sh
docker run --rm -it -e RAILS_ENV={environment} -e DB_HOST={database_host} -e DB_NAME={database_name} -e DB_USER={database_user} -e DB_PASS={database_user_password} -e DB_ADAPTER=postgresql jrjoacir/cerberus:{VERSION} rails db:migrate
```
**Atenção**: Para executar os *migrations* no banco de dados, é necessário que o usuário de banco de dados tenha acesso a criar objetos de banco de dados (tabelas, índices, restrições).

**Observação**: os valores das variáveis de ambiente podem ser definidas pelas variáveis de ambiente do sistema operacional. Para mais informações sobre executar docker com variáveis, leia a [Documentação do Docker Run](https://docs.docker.com/engine/reference/commandline/run/).

3. **Execute o contêiner para ficar pronto para uso**
```sh
docker run --rm -it -e RAILS_ENV={environment} -e DB_HOST={database_host} -e DB_NAME={database_name} -e DB_USER={database_user} -e DB_PASS={database_user_password} -e DB_ADAPTER=postgresql -p {IP}:{Port}:{external port}/tcp jrjoacir/cerberus:{VERSION} rails s -p {port} -b 0.0.0.0
```

**Atenção**: Informe o usuário de banco de dados com os corretos privilégios para executar a API. Provavelmente, apenas privilégios de leitura e escrita aos dados seja necessário.

**Observação**: Leia a [Documentação do Docker Run](https://docs.docker.com/engine/reference/commandline/run/) para saber mais sobre o uso de variáveis de ambiente e as configurações de portas.

**Exemplo**:
```sh
docker run --rm -it -e RAILS_ENV=production -e DB_HOST=database -e DB_NAME=postgres_dev -e DB_USER=postgres -e DB_PASS=postgres_password -e DB_ADAPTER=postgresql -p 127.0.0.1:3000:3000/tcp jrjoacir/cerberus:0.1.0 rails s -p 3000 -b 0.0.0.0
```

## Licença
Este projeto esta licenciado por **GNU General Public License v3.0**.

> Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights.

Mais sobre esta licença acesse [GNU General Public License v3.0](LICENSE.md).
## Informações adicionais
- O *Dockerfile* contendo a linguagem Ruby foi obtido no repositório oficial no [DockerHub](https://hub.docker.com/): [Ruby Dockerfile](https://hub.docker.com/_/ruby/)
- O *Dockerfile* para PostgreSQL foi obtido no repositório oficial no [DockerHub](https://hub.docker.com/): [Postgresql Dockerfile](https://hub.docker.com/_/postgres/)
- O script para a criação de mútiplos *databases* no PostgreSQL foi obtido no repositório [docker-postgresql-multiple-databases](https://github.com/mrts/docker-postgresql-multiple-databases) do [Github](https://github.com)
