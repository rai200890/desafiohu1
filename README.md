# Desafio de auto-complete e busca disponibilidade

Neste problema você deve implementar o widget de busca de hoteis. Este desenvolvimento engloba o auto-complete de hoteis e a busca por disponibilidades quando o usuário informa um periodo de estadia. 

A interface em anexo precisa ser implementada assim como o backend para consumir a lista de hoteis e as disponibilidades. Tudo será avaliado. Faça o seu melhor na linguagem onde vc possui o maior domínio.

***Restrições***
* Eu preciso conseguir rodar seu código no mac os x OU no ubuntu;
* Eu vou executar seu código com os seguintes comandos:

>1. *git clone seu-fork*
2. *cd seu-fork*
3. *comando para instalar dependências*
4. *comando para executar a aplicação*

Esses comandos tem que ser o suficiente para configurar meu mac os x OU ubuntu e rodar seu programa. Pode considerar que eu tenho instalado no meu sistema Python, Java, PHP, Ruby e/ou Node. Qualquer outra dependência que eu precisar vc tem que prover.

***Performance***
* Preciso que os seus serviços suportem um volume de 1000 requisições por segundo

***Artefatos***
* Imagens e database de hoteis e disponibilidades estão na pasta arquivos
*

# Minha solução

##Visão Geral
A aplicação está divida em 2 partes:

* No diretório *hu_api*:
  * API em Rails. 
* No diretório *interface*:
  * Single Page Application usando AngularJS, que faz requisições a API.

### Instalação das dependências adicionais do projeto

``` shell
sh install_dependencies.sh
```

### Criação do banco de dados e execução do servidor rails(porta 3000) e do servidor estático(porta 9000)
(A partir do diretório raiz do projeto)
``` shell
sh serve_application.sh
```

### HU Api

#### Criação e migração do banco de dados
``` shell
rake db:create
rake db:migrate
```

#### Seed dos dados contidos no diretório *artefatos*:
``` shell
thor db:seed --hotel_file ../artefatos/hoteis.txt --availability_file ../artefatos/disp.txt
```

#### Execução dos testes unitários
``` shell
rake db:migrate RAILS_ENV=test
rspec
```

#### Para executar o servidor
```shell
rails s Puma -p 3000
```

### Interface

#### Para executar o servidor estático
```shell
grunt serve
```


