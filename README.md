# Meus Produtos - API Rest (Backend)

Autor: Wallisson Rony de M. N.

Este é um repositório que apresenta um CRUD simples para manipulação de produtos. Este projeto tem alguns projetos relacionados, como o repositório com o projeto <a href="https://github.com/wallrony/products-frontend" target="_blank">Frontend WEB</a> e o repositório com o projeto <a href="https://github.com/wallrony/products-frontend" target="_blank">Mobile</a>.

O projeto tem como principal objetivo apresentar o CRUD de produtos, entidade essa que a seguinte estrutura:

```json
{
  "name": "Nome do produto",
  "price": "Preço do produto",
  "image_path": "Link da imagem do produto (facultativo)"
}
```

### Features Implementadas

- Roteamento de telas;
- Listagem de produtos;
- Adição de um produto (nome, preço e imagem);
- Alteração de um produto (nome, preço e imagem);
- Exclusão de um produto por id;
- Organização de camadas da aplicação:
- 1. View;
- 2. Provider;
- 3. Service;
- 4. Facade;
- 4. Api Class (para enviar requisição para o backend).
- Componentização;
- Estilização;

## Como Executar?

- Dê um git clone do repositório para obtê-lo por completo;
- Entre na pasta do projeto;
- Execute `pub get` instalar todas as dependências do projeto;
- Abra o arquivo "/lib/data/api/client.dart" e altere a variável "baseUrl" para o endereço do backend que está executando na sua máquina ou de forma virtual, sempre colocando a rota "/api" junto da URL. Exemplo: `http://seuip:3333/api`, colocando, no lugar de "seuip" o ip do seu dispositivo que está executando o backend;
- Em caso de erro com a comunicação com o banco de dados, o host do backend. é errôneo (por exemplo), utilizar como host "localhost", pois o aplicativo, quando executa no dispositivo móvel, há "localhost" com referência no próprio dispositivo, com isso, recomendo utilizar como host o endereço o ip do dispositivo que está executando o backend;
- Inicie um emulador de dispositivo móvel ou conecte seu smartphone no computador (certifique-se que seu aparelho tenha a Depuração USB ativada);
- Execute `flutter run` para executar o aplicativo no seu dispositivo conectado (ou emulado).
- E pronto, o aplicativo estará executando no seu celular.

Obs.: ao executar `flutter run --release` para executar o .apk no modo release do aplicativo, há um bug onde a versão release não encontra o endereço do backend. Logo, recomendo que, para testes com banco de dados local, execute o comando `flutter run`. Caso queira executar em modo release, faça deploy do backend em alguma plataforma online (ex.: Heroku), e edite a variável "baseUrl" lá em "/lib/data/api/client.dart", colocando o host do backend.

E é isso, você está executando a aplicação mobile do projeto de produtos!

Qualquer dúvida, crie uma issue que te responderei assim que possível!
