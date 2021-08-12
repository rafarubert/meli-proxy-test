
# meli-proxy

## Desafio
Executar a função de proxy sobre o domínio api.mercadolibre.com, isto é, ele deve agir como um intermediário para as requisições dos clientes, enviando-as à api.mercadolibre.com.

- Deverá permitir o controle das quantidades máximas de requisições por:
  - IP de origem
  - Path de destino
  - Combinações de ambos
- Outros critérios ou alternativas de controle são bem vindos ;)
- Deve armazenar (e também permitir que se consulte) as estatísticas de uso do proxy.
- O código deve estar disponível em um repositório do Github ou Bitbucket.
- O proxy (como solução) deverá poder superar 50.000 requisições por segundo.

Não faremos testes de carga, mas avaliaremos se a arquitetura utilizada é escalável o suficiente.

**Alguns desejáveis:**

- A interface para estatísticas e controle deveria prover APIs Rest.
- Um desenho simples de arquitetura da solução e documentação (README) conta muito.
- Sabemos que o teste é complexo e seria desejável ter todos os requisitos implementados (e funcionando), no entanto, qualquer nível de completude será aceita


## Dependencies
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Run docker without sudo(linux user only)](https://docs.docker.com/engine/install/linux-postinstall/)

## Pre install
Add into .bashrc or .zshrc
```
export UID
export USER
```

```cp .env.sample .env```
## Build project
    docker-compose build
### run Project
    docker-compose up

### run project console
    docker-compose run --rm app rake console

### run tests
    docker-compose run --rm app rspec

### run linux shell
    docker-compose run --rm app sh

# TODO
## Add rspec tests
- Configure envirorments for development and tests
## Check method for call posts requests

**Options**
- Simulate http request with sinatra (using views)
- Use Net::HTTP for submit request and redirect for get path

## Run in background log write
**Options**
- Use sidekiq
- Use Fibbers
